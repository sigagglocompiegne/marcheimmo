                                                                          
/*IMMO V1.0*/
/*Creation du squelette de la structure des données (tables, séquences, triggers,...) */
/*IMMO_10_SQUELETTE.sql */
/*PostGIS*/
/*GeoCompiegnois - http://geo.compiegnois.fr/ */
/*Auteur : Grégory Bodet */

/*
SOMMAIRE :
 - DROP
 - SEQUENCES
 - DOMAINES DE VALEUR
 - CLASSES OBJETS
 - CONTRAINTES
*/


-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                           DROP                                                          ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################


-- VUES 

-- CLASSES

DROP TABLE IF EXISTS m_economie.geo_immo_objet CASCADE;
DROP TABLE IF EXISTS m_economie.an_immo_bien CASCADE;
DROP TABLE IF EXISTS m_economie.an_immo_bati CASCADE;
DROP TABLE IF EXISTS m_economie.an_immo_prop CASCADE;
DROP TABLE IF EXISTS m_economie.an_immo_comm CASCADE;
DROP TABLE IF EXISTS m_economie.an_immo_media CASCADE;
DROP TABLE IF EXISTS m_economie.lk_immo_objet CASCADE;
DROP TABLE IF EXISTS m_economie.lk_immo_occupant CASCADE;
DROP TABLE IF EXISTS m_economie.lk_immo_bienbati CASCADE;

-- DOMAINES DE VALEUR

DROP TABLE IF EXISTS m_economie.m lt_immo_ityp CASCADE;
DROP TABLE IF EXISTS m_economie.m lt_immo_bdesc CASCADE;
DROP TABLE IF EXISTS m_economie.m lt_immo_bbati CASCADE;
DROP TABLE IF EXISTS m_economie.m lt_immo_tbien CASCADE;
DROP TABLE IF EXISTS m_economie.m lt_immo_etat CASCADE;


--SEQUENCES

DROP SEQUENCE m_economie. ;

--TRIGGERS

DROP TRIGGER IF EXISTS  ON m_economie. ;



-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                         SEQUENCE                                                        ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################


--############################################################ NAME ##################################################



-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                    DOMAINES DE VALEURS                                                  ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################


--############################################################ NAME ##################################################


INSERT INTO m_economie.lt_(code, valeur)
    VALUES
	('10','Actif'),
	('11','Inactif'),
	('12','Supprimé');

COMMENT ON TABLE m_economie.lt_ecl_situation
  IS 'Code permettant de décrire la situation réelle de l''objet';
COMMENT ON COLUMN m_economie.lt_ecl_situation.code IS 'Code de la liste';
COMMENT ON COLUMN m_economie.lt_ecl_situation.valeur IS 'Valeur de la liste';

	
-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                        CLASSES OBJETS                                                   ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################


--################################################################# NAME #######################################################





-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                        CONTRAINTES                                                      ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################




