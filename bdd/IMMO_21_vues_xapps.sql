 
/*IMMO V1.0*/
/*Creation des vues nécessaires à l'application web-métier */
/*IMMO_21_VUES_XAPPS.sql */
/*PostGIS*/
/* GeoCompiegnois - http://geo.compiegnois.fr/ */
/* Auteur : Grégory Bodet */


-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                           DROP                                                          ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################

--VUES

DROP VIEW IF EXISTS x_apps.xapps_an_vmr_immo_bati;
DROP VIEW IF EXISTS x_apps.xapps_geo_v_immo_etat;
DROP VIEW IF EXISTS x_apps.xapps_geo_v_immo_bati;


-- #################################################################################################################################
-- ###                                                                                                                           ###
-- ###                                                      VUES APPLICATIVES                                                    ###
-- ###                                                                                                                           ###
-- #################################################################################################################################

--################################################## xapps_geo_v_immo_etat ###############################################

-- View: x_apps.xapps_geo_vmr_immo_etat

-- DROP MATERIALIZED VIEW x_apps.xapps_geo_vmr_immo_etat;

CREATE MATERIALIZED VIEW x_apps.xapps_geo_vmr_immo_etat
TABLESPACE pg_default
AS
 SELECT DISTINCT row_number() OVER () AS gid,
    o.idimmo,
    o.idbati,
    b.idbien,
        CASE
            WHEN o.ityp::text = '10'::text THEN 'Terrain'::text
            ELSE 'Local'::text
        END AS ityp,
    o.ityp AS ityp_code,
    b.surf_p AS surface,
    d.observ AS observ_desc,
    c.prix,
    c.prix_m,
    c.loyer,
    c.loyer_m,
    c.loyer_mp,
    c.bail,
    c.etat,
        CASE
            WHEN c.etat::text = ANY (ARRAY['10'::character varying::text, '20'::character varying::text]) THEN 'En vente'::text
            WHEN c.etat::text = '30'::text THEN 'En location'::text
            WHEN c.etat::text = '40'::text THEN 'En vente et/ou en location'::text
            ELSE ''::text
        END AS dispo,
    tb.valeur AS typlocal,
    b.libelle,
    b.adr,
    b.adrcomp,
    o.commune,
    s.site_nom AS za,
    st_buffer(o.geom, 2.5::double precision) AS geom,
    st_pointonsurface(o.geom) AS geom1
   FROM m_economie.geo_immo_bien o
     JOIN m_economie.an_immo_bien b ON b.idimmo = o.idimmo
     LEFT JOIN m_economie.an_immo_desc d ON d.idbien = b.idbien
     JOIN m_economie.an_immo_comm c ON c.idbien = b.idbien
     JOIN m_economie.lt_immo_tbien tb ON tb.code::text = b.tbien::text
     LEFT JOIN m_economie.an_sa_site s ON s.idsite::text = o.idsite::text
  WHERE c.etat::text <> 'ZZ'::text
WITH DATA;

ALTER TABLE x_apps.xapps_geo_vmr_immo_etat
    OWNER TO sig_create;

COMMENT ON MATERIALIZED VIEW x_apps.xapps_geo_vmr_immo_etat
    IS 'Vue matérialisée géographique présentant l''état de disponibilités d''un local/terrain (en vente, en location) et intégrée à la cartographie de l''application GEO et permettant les recherches';



--################################################## xapps_geo_v_immo_bati ###############################################

-- View: x_apps.xapps_geo_vmr_immo_bati

-- DROP MATERIALIZED VIEW x_apps.xapps_geo_vmr_immo_bati;

CREATE MATERIALIZED VIEW x_apps.xapps_geo_vmr_immo_bati
TABLESPACE pg_default
AS
 WITH req_bati AS (
         SELECT o.idbati,
            ba.libelle,
            ba.libelle AS etiquette,
            stat.nbloc_tot,
            o.idsite,
            st_multi(st_union(o.geom))::geometry(MultiPolygon,2154) AS geom
           FROM m_economie.geo_immo_bien o,
            m_economie.an_immo_bati ba,
            x_apps.xapps_an_vmr_immo_bati stat
          WHERE o.idbati = ba.idbati AND o.idbati = stat.idbati AND o.ityp::text <> '10'::text
          GROUP BY o.idbati, ba.libelle, stat.nbloc_tot, o.idsite
        ), req_compteetab AS (
         SELECT ba.idbati,
            count(*) AS nb_etab,
            string_agg(
                CASE
                    WHEN length(ae.l_nom::text) <> 0 THEN ae.l_nom
                    WHEN length(ne.enseigne1etablissement::text) <> 0 THEN ne.enseigne1etablissement
                    WHEN length(ne.enseigne2etablissement::text) <> 0 THEN ne.enseigne2etablissement
                    WHEN length(ne.enseigne3etablissement::text) <> 0 THEN ne.enseigne3etablissement
                    WHEN length(ne.denominationusuelleetablissement::text) <> 0 THEN ne.denominationusuelleetablissement
                    WHEN length(t2.denominationunitelegale::text) <> 0 THEN t2.denominationunitelegale
                    WHEN length(t2.denominationusuelle1unitelegale::text) <> 0 THEN t2.denominationusuelle1unitelegale
                    WHEN length(t2.denominationusuelle2unitelegale::text) <> 0 THEN t2.denominationusuelle2unitelegale
                    WHEN length(t2.denominationusuelle3unitelegale::text) <> 0 THEN t2.denominationusuelle3unitelegale
                    WHEN length(t2.nomunitelegale::text) <> 0 THEN t2.nomunitelegale
                    WHEN length(t2.nomusageunitelegale::text) <> 0 THEN t2.nomusageunitelegale
                    WHEN length(t2.pseudonymeunitelegale::text) <> 0 THEN t2.pseudonymeunitelegale
                    ELSE ''::character varying
                END::text, chr(10)) AS liste_etab
           FROM m_economie.an_immo_bati ba,
            m_economie.lk_immo_batiadr a,
            m_economie.lk_adresseetablissement e_1,
            m_economie.an_sa_etab ae,
            s_sirene.an_etablissement_api ne
             JOIN ( SELECT an_unitelegale_api.siren,
                    max(an_unitelegale_api.gid) AS max,
                    an_unitelegale_api.denominationunitelegale,
                    an_unitelegale_api.denominationusuelle1unitelegale,
                    an_unitelegale_api.denominationusuelle2unitelegale,
                    an_unitelegale_api.denominationusuelle3unitelegale,
                    an_unitelegale_api.nomunitelegale,
                    an_unitelegale_api.nomusageunitelegale,
                    an_unitelegale_api.pseudonymeunitelegale
                   FROM s_sirene.an_unitelegale_api
                  GROUP BY an_unitelegale_api.siren, an_unitelegale_api.denominationunitelegale, an_unitelegale_api.denominationusuelle1unitelegale, an_unitelegale_api.denominationusuelle2unitelegale, an_unitelegale_api.denominationusuelle3unitelegale, an_unitelegale_api.nomunitelegale, an_unitelegale_api.nomusageunitelegale, an_unitelegale_api.pseudonymeunitelegale) t2 ON ne.siren::text = t2.siren::text
          WHERE ba.idbati = a.idbati AND a.id_adresse = e_1.idadresse AND e_1.siret::text = ne.siret::text AND e_1.siret::text = ae.idsiret::text AND ae.l_compte = true AND ne.etatadministratifetablissement::text = 'A'::text
          GROUP BY ba.idbati
        )
 SELECT row_number() OVER () AS gid,
    b.idbati,
    b.libelle,
        CASE
            WHEN e.nb_etab <= 3 THEN e.liste_etab::character varying
            ELSE b.libelle
        END AS etiquette,
    e.nb_etab,
    b.nbloc_tot,
    b.idsite,
    b.geom
   FROM req_bati b
     LEFT JOIN req_compteetab e ON b.idbati = e.idbati
WITH DATA;

ALTER TABLE x_apps.xapps_geo_vmr_immo_bati
    OWNER TO sig_create;

COMMENT ON MATERIALIZED VIEW x_apps.xapps_geo_vmr_immo_bati
    IS 'Vue géographique présentant le bâtiment reconstitué à partir des locaux indépendant divisés d''un même bâtiment (pour la cartographie GEO de l''application)';
  
--################################################## xapps_an_vmr_immo_bati ###############################################

-- View: x_apps.xapps_an_vmr_immo_bati

-- DROP MATERIALIZED VIEW x_apps.xapps_an_vmr_immo_bati;

CREATE MATERIALIZED VIEW x_apps.xapps_an_vmr_immo_bati
TABLESPACE pg_default
AS
 WITH req_bati AS (
         SELECT b.idbati
           FROM m_economie.an_immo_bati b
        ), req_bati_ssol_2123 AS (
         SELECT ba.idbati,
            sum(bi.sup_m2) AS surf_sol_tot
           FROM m_economie.an_immo_bati ba,
            m_economie.geo_immo_bien bi
          WHERE ba.idimmo = bi.idimmo AND (ba.ityp::text = '21'::text OR ba.ityp::text = '23'::text)
          GROUP BY ba.idbati
        ), req_bati_nbloc_2123 AS (
         WITH req_bati2123 AS (
                 SELECT ba.idbati
                   FROM m_economie.an_immo_bati ba
                  WHERE ba.ityp::text = '21'::text OR ba.ityp::text = '23'::text
                ), req_bati2123_nbloc AS (
                 SELECT ba.idbati,
                    count(*) AS nbloc_tot
                   FROM m_economie.an_immo_bati ba,
                    m_economie.geo_immo_bien bi,
                    m_economie.an_immo_bien bien
                  WHERE ba.idimmo = bi.idimmo AND bi.idimmo = bien.idimmo AND (ba.ityp::text = '21'::text OR ba.ityp::text = '23'::text)
                  GROUP BY ba.idbati
                )
         SELECT req_bati2123.idbati,
                CASE
                    WHEN req_bati2123_nbloc.nbloc_tot IS NULL THEN 0::bigint
                    ELSE req_bati2123_nbloc.nbloc_tot
                END AS nbloc_tot
           FROM req_bati2123
             LEFT JOIN req_bati2123_nbloc ON req_bati2123.idbati = req_bati2123_nbloc.idbati
        ), req_bati_22 AS (
         SELECT ba.idbati,
            sum(bi.sup_m2) AS surf_sol_tot
           FROM m_economie.an_immo_bati ba,
            m_economie.geo_immo_bien bi
          WHERE ba.idbati = bi.idbati AND ba.ityp::text = '22'::text
          GROUP BY ba.idbati
        ), req_biensp_22 AS (
         WITH req_bati22 AS (
                 SELECT ba.idbati
                   FROM m_economie.an_immo_bati ba
                  WHERE ba.ityp::text = '22'::text
                ), req_bati22_biensp AS (
                 SELECT ba.idbati,
                    sum(abi.surf_p) AS surfpbien_tot,
                    count(*) AS nbloc_tot
                   FROM m_economie.an_immo_bati ba,
                    m_economie.geo_immo_bien bi,
                    m_economie.an_immo_bien abi
                  WHERE ba.idbati = bi.idbati AND bi.idimmo = abi.idimmo AND ba.ityp::text = '22'::text
                  GROUP BY ba.idbati
                )
         SELECT req_bati22.idbati,
                CASE
                    WHEN req_bati22_biensp.surfpbien_tot IS NULL THEN 0::bigint
                    ELSE req_bati22_biensp.surfpbien_tot
                END AS surfpbien_tot,
                CASE
                    WHEN req_bati22_biensp.nbloc_tot IS NULL THEN 0::bigint
                    ELSE req_bati22_biensp.nbloc_tot
                END AS nbloc_tot
           FROM req_bati22
             LEFT JOIN req_bati22_biensp ON req_bati22.idbati = req_bati22_biensp.idbati
        ), req_biensp_2123 AS (
         WITH req_bati2123 AS (
                 SELECT ba.idbati
                   FROM m_economie.an_immo_bati ba
                  WHERE ba.ityp::text = '21'::text OR ba.ityp::text = '23'::text
                ), req_bati2123_biensp AS (
                 SELECT ba.idbati,
                    sum(abi.surf_p) AS surfpbien_tot
                   FROM m_economie.an_immo_bati ba,
                    m_economie.geo_immo_bien bi,
                    m_economie.an_immo_bien abi
                  WHERE ba.idimmo = bi.idimmo AND bi.idimmo = abi.idimmo AND (ba.ityp::text = '21'::text OR ba.ityp::text = '23'::text)
                  GROUP BY ba.idbati
                )
         SELECT req_bati2123.idbati,
                CASE
                    WHEN req_bati2123_biensp.surfpbien_tot IS NULL THEN 0::bigint
                    ELSE req_bati2123_biensp.surfpbien_tot
                END AS surfpbien_tot
           FROM req_bati2123
             LEFT JOIN req_bati2123_biensp ON req_bati2123.idbati = req_bati2123_biensp.idbati
        )
 SELECT req_bati.idbati,
        CASE
            WHEN req_bati_22.surf_sol_tot IS NOT NULL THEN req_bati_22.surf_sol_tot
            ELSE req_bati_ssol_2123.surf_sol_tot
        END AS surfsolbati_tot,
        CASE
            WHEN req_biensp_22.nbloc_tot IS NULL THEN req_bati_nbloc_2123.nbloc_tot
            ELSE req_biensp_22.nbloc_tot
        END AS nbloc_tot,
        CASE
            WHEN req_biensp_22.surfpbien_tot IS NULL THEN req_biensp_2123.surfpbien_tot
            ELSE req_biensp_22.surfpbien_tot
        END AS surfpbien_tot
   FROM req_bati
     LEFT JOIN req_bati_ssol_2123 ON req_bati.idbati = req_bati_ssol_2123.idbati
     LEFT JOIN req_bati_22 ON req_bati.idbati = req_bati_22.idbati
     LEFT JOIN req_bati_nbloc_2123 ON req_bati.idbati = req_bati_nbloc_2123.idbati
     LEFT JOIN req_biensp_2123 ON req_bati.idbati = req_biensp_2123.idbati
     LEFT JOIN req_biensp_22 ON req_bati.idbati = req_biensp_22.idbati
WITH DATA;

ALTER TABLE x_apps.xapps_an_vmr_immo_bati
    OWNER TO sig_create;

COMMENT ON MATERIALIZED VIEW x_apps.xapps_an_vmr_immo_bati
    IS 'Vue matérialisée rafraichies par trigger à la mise à jour des données du marché immobilier formatant les données calculées aux bâtiments des locaux d''activités';

CREATE INDEX idx_xapps_an_immo_bati_idbati
    ON x_apps.xapps_an_vmr_immo_bati USING btree
    (idbati COLLATE pg_catalog."default")
    TABLESPACE pg_default;




