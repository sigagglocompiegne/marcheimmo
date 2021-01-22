 
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

-- View: x_apps.xapps_geo_v_immo_etat

-- DROP VIEW x_apps.xapps_geo_v_immo_etat;

CREATE OR REPLACE VIEW x_apps.xapps_geo_v_immo_etat
 AS
 
 SELECT o.idimmo,
    b.idbien,
	ad.id_adresse,
        CASE
            WHEN o.ityp::text = '10'::text THEN 'Terrain'::text
            ELSE 'Local'::text
        END AS ityp,
    o.ityp AS ityp_code,
    b.surf_p AS surface,
	c.prix,
	c.prix_m,
	c.loyer,
	c.loyer_m,
	c.bail,
	c.etat,
	e.valeur AS dispo,
	tb.valeur AS typlocal,
    b.libelle,
    b.adr,
    b.adrcomp,
    o.commune,
    s.site_nom AS za,
    st_pointonsurface(o.geom) AS geom,
    o.geom AS geom1
   FROM m_economie.geo_immo_bien o
     LEFT JOIN m_economie.lk_immo_batiadr ad ON ad.idbati = o.idbati
     JOIN m_economie.an_immo_bien b ON b.idimmo = o.idimmo
     JOIN m_economie.an_immo_comm c ON c.idbien = b.idbien    
     JOIN m_economie.lt_immo_etat e ON c.etat::text = e.code::text
     JOIN m_economie.lt_immo_tbien tb ON tb.code::text = b.tbien::text
     LEFT JOIN m_economie.an_sa_site s ON s.idsite::text = o.idsite::text
  WHERE
  c.etat::text <> 'ZZ'::text;

COMMENT ON VIEW x_apps.xapps_geo_v_immo_etat
    IS 'Vue géographique présentant l''état de disponibilités d''un local/terrain (en vente, en location) et intégrée à la cartographie de l''application GEO et permettant les recherches';




--################################################## xapps_geo_v_immo_bati ###############################################

-- View: x_apps.xapps_geo_v_immo_bati

-- DROP VIEW x_apps.xapps_geo_v_immo_bati;

CREATE OR REPLACE VIEW x_apps.xapps_geo_v_immo_bati
 AS
 SELECT row_number() OVER () AS gid,
    ba.libelle,
    stat.nbloc_tot,
    st_multi(st_union(o.geom))::geometry(MultiPolygon,2154) AS geom
   FROM m_economie.geo_immo_bien o,
    m_economie.an_immo_bati ba,
	x_apps.xapps_an_vmr_immo_bati stat
  WHERE o.idbati = ba.idbati AND o.idbati = stat.idbati AND o.ityp::text <> '10'::text
  GROUP BY o.idbati, ba.libelle,stat.nbloc_tot;


COMMENT ON VIEW x_apps.xapps_geo_v_immo_bati
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



COMMENT ON MATERIALIZED VIEW x_apps.xapps_an_vmr_immo_bati
    IS 'Vue matérialisée rafraichies par trigger à la mise à jour des données du marché immobilier formatant les données calculées aux bâtiments des locaux d''activités';


CREATE INDEX idx_xapps_an_immo_bati_idbati
    ON x_apps.xapps_an_vmr_immo_bati USING btree
    (idbati COLLATE pg_catalog."default")
    TABLESPACE pg_default;




