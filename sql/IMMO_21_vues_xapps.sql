 
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


-- #################################################################################################################################
-- ###                                                                                                                           ###
-- ###                                                      VUES APPLICATIVES                                                    ###
-- ###                                                                                                                           ###
-- #################################################################################################################################


    
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




