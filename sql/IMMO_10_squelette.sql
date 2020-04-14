                                                                          
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

 (à venir)

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

DROP TABLE IF EXISTS m_economie.lt_immo_ityp CASCADE;
DROP TABLE IF EXISTS m_economie.lt_immo_bdesc CASCADE;
DROP TABLE IF EXISTS m_economie.lt_immo_bbati CASCADE;
DROP TABLE IF EXISTS m_economie.lt_immo_tbien CASCADE;
DROP TABLE IF EXISTS m_economie.lt_immo_etat CASCADE;


--SEQUENCES

DROP SEQUENCE m_economie.geo_immo_objet_seq;
DROP SEQUENCE m_economie.an_immo_bien_seq;
DROP SEQUENCE m_economie.an_immo_comm_seq ;
DROP SEQUENCE m_economie.an_immo_bati_seq;
DROP SEQUENCE m_economie.an_immo_prop_seq;
DROP SEQUENCE m_economie.an_immo_media_seq;

--TRIGGERS

DROP TRIGGER IF EXISTS  ON m_economie. ;



-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                         SEQUENCE                                                        ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################


--############################################################ geo_immo_objet_seq ##################################################

--############################################################ an_immo_bien_seq ##################################################

--############################################################ an_immo_comm_seq ##################################################

--############################################################ an_immo_bati_seq ##################################################

--############################################################ an_immo_prop_seq ##################################################

--############################################################ an_immo_media_seq ##################################################


-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                    DOMAINES DE VALEURS                                                  ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################


--############################################################ lt_immo_ityp ##################################################


INSERT INTO m_economie.lt_immo_ityp(code, valeur)
    VALUES
	('10','Terrain virger'),
	('20','..'),
	('21','..');

COMMENT ON TABLE m_economie.lt_immo_ityp
  IS 'Code permettant de décrire le type d''objet saisie';
COMMENT ON COLUMN m_economie.lt_immo_ityp.code IS 'Code de la liste de l''objet saisi';
COMMENT ON COLUMN m_economie.lt_immo_ityp.valeur IS 'Valeur de la liste l''objet saisi';

	
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




