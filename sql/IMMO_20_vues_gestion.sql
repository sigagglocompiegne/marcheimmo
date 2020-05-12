/*IMMO V1.0*/
/*Creation des vues et triggers nécessaires à la gestion via l'application web-métier */
/*IMMO_20_VUES_GESTION.sql */
/*PostGIS*/
/* GeoCompiegnois - http://geo.compiegnois.fr/ */
/* Auteur : Grégory Bodet*/

/* PARTICULARTITE */

-- aucune vue de gestion proprement dite n'a été créée ici pour gérer les données directement en base depuis une vue. Le fonctionnel
-- applicatif a été entièrement géré dans l'application GEO. Seuls sont ici présentes des vues pour des particularités fonctionnelles non
-- gérées par une fonctionnalité GEO.


/*
SOMMAIRE :
 - DROP
 - VUES et COMMENTAIRES
 - TRIGGERS
*/

-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                           DROP                                                          ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################

--TRIGGERS


--VUES

 DROP MATERIALIZED VIEW m_economie.an_vmr_immo_ityp;




-- #################################################################################################################################
-- ###                                                                                                                           ###
-- ###                                                      VUES DE GESTION                                                      ###
-- ###                                                                                                                           ###
-- #################################################################################################################################

-- View: m_economie.an_vmr_immo_ityp

CREATE MATERIALIZED VIEW m_economie.an_vmr_immo_ityp AS
SELECT
row_number() over() as id,
bi.idimmo,
bi.ityp as ityp_objet,
ba.ityp as ityp_bati
FROM
m_economie.geo_immo_bien bi,
m_economie.an_immo_bati ba
WHERE
bi.idimmo = ba.idimmo
AND
bi.ityp <> '22'
WITH DATA;

ALTER TABLE m_economie.an_vmr_immo_ityp
    OWNER TO sig_create;

COMMENT ON MATERIALIZED VIEW m_economie.an_vmr_immo_ityp
    IS 'Vue non géographiques listant les types d''occupation entre la table des objeys saisis et les attributs des bâtiments (exclu des bâtiments avec biens identifiés). Objectif : utiliser cette vue rafraichie après l''insertion d''un bâtiment pour mettre à jour cette même table des bâtis pour gérer la liste des bâtiments (uniquement si locaux identifiés) affichés à l''utilisateur dans GEO pour affecter un bâtiment à un bien identifié';

