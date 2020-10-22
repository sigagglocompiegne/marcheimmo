 
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

DROP VIEW IF EXISTS x_apps.xapps_geo_v_immo_etat;


-- #################################################################################################################################
-- ###                                                                                                                           ###
-- ###                                                      VUES APPLICATIVES                                                    ###
-- ###                                                                                                                           ###
-- #################################################################################################################################


    
--################################################## AFFICHAGE DES BIENS DISPONIBLES ###############################################

CREATE OR REPLACE VIEW x_apps.xapps_geo_v_immo_etat AS
SELECT
o.idimmo,
CASE WHEN c1.etat IS NULL THEN c2.etat ELSE c1.etat END as etat,
CASE 
WHEN c1.etat IS NULL THEN 
	CASE
		WHEN c2.etat = '10' or c2.etat = '20' THEN 'En vente'
		WHEN c2.etat = '30' THEN 'En location'
		WHEN c2.etat = '40' THEN 'En vente et/ou en location'
	END
ELSE
	CASE
		WHEN c1.etat = '10' or c1.etat = '20' THEN 'En vente'
		WHEN c1.etat = '30' THEN 'En location'
		WHEN c1.etat = '40' THEN 'En vente et/ou en location'
	END
END as dispo,
st_pointonsurface(geom) as geom
FROM 
m_economie.geo_immo_bien o
LEFT JOIN m_economie.an_immo_comm c1 ON c1.idimmo = o.idimmo
LEFT JOIN m_economie.an_immo_bien b ON b.idimmo = o.idimmo
LEFT JOIN m_economie.an_immo_comm c2 ON c2.idbien = b.idbien
LEFT JOIN m_economie.lt_immo_etat e1 ON c1.etat = e1.code 
LEFT JOIN m_economie.lt_immo_etat e2 ON c2.etat = e2.code 
WHERE (c1.etat <> 'ZZ' or c2.etat <> 'ZZ');

COMMENT ON VIEW x_apps.xapps_geo_v_immo_etat
    IS 'Vue géographique présentant l''état de disponibilités d''un local/terrain (en vente, en location) et intégrée à la cartographie de l''application GEO ';
													



