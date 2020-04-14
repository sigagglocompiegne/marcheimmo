                                                                          
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
DROP TABLE IF EXISTS m_economie.lt_immo_dbien CASCADE;
DROP TABLE IF EXISTS m_economie.lt_immo_dbati CASCADE;
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

CREATE TABLE m_reseau_sec.lt_immo_ityp
(
  code character varying(2) NOT NULL,
  valeur character varying(80) NOT NULL,
  CONSTRAINT lt_immo_ityp_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

INSERT INTO m_economie.lt_immo_ityp(code, valeur)
    VALUES
	('10','Terrain vierge'),
	('21','Local (Bâtiment non divisé)'),
	('22','Local indépendant divisé'),
	('23','Local non identifié dans un bâtiment divisible');

COMMENT ON TABLE m_economie.lt_immo_ityp
  IS 'Code permettant de décrire le type d''objet saisie';
COMMENT ON COLUMN m_economie.lt_immo_ityp.code IS 'Code du type d''objet immobilier saisi';
COMMENT ON COLUMN m_economie.lt_immo_ityp.valeur IS 'Valeur du type d''objet immobilier saisi';

--############################################################ lt_immo_dbati ##################################################

CREATE TABLE m_reseau_sec.lt_immo_dbati
(
  code character varying(2) NOT NULL,
  valeur character varying(80) NOT NULL,
  CONSTRAINT lt_immo_dbati_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

INSERT INTO m_economie.lt_immo_dbati(code, valeur)
    VALUES
	('0','Non renseigné'),
	('1','Double vitrage'),
	('2','Site clôturé'),
	('3','Places de parking'),
	('4','Murs périphériques (bardage métallique…)'),
	('5','Ossature (couverture bac acier…)'),
	('6','Menuiserie aluminium'),
	('7','Accès sécurisé'),
	('8','Système d''alarme'),
	('9','Parties communes'),
	('10','Portes de plain-pied),
	('11','Charge au sol);

COMMENT ON TABLE m_economie.lt_immo_dbati
  IS 'Code permettant de décrire la description du bâtiment';
COMMENT ON COLUMN m_economie.lt_immo_dbati.code IS 'Code du type décrivant des éléments du bâtiment';
COMMENT ON COLUMN m_economie.lt_immo_dbati.valeur IS 'Valeur du type décrivant des éléments du bâtiment';

--############################################################ lt_immo_dbien ##################################################

CREATE TABLE m_reseau_sec.lt_immo_dbien
(
  code character varying(2) NOT NULL,
  valeur character varying(80) NOT NULL,
  CONSTRAINT lt_immo_dbien_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

INSERT INTO m_economie.lt_immo_dbien(code, valeur)
    VALUES
	('0','Non renseigné'),
        ('1','Vitrine'),
	('2','Présence d''une remise'),
	('3','Autre')
	;

COMMENT ON TABLE m_economie.lt_immo_dbien
  IS 'Code permettant de décrire la description du bien';
COMMENT ON COLUMN m_economie.lt_immo_dbien.code IS 'Code du type décrivant des éléments du bien';
COMMENT ON COLUMN m_economie.lt_immo_dbien.valeur IS 'Valeur du type décrivant des éléments du bien';

--############################################################ lt_immo_tbien ##################################################

CREATE TABLE m_reseau_sec.lt_immo_tbien
(
  code character varying(2) NOT NULL,
  valeur character varying(80) NOT NULL,
  CONSTRAINT lt_immo_tbien_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

INSERT INTO m_economie.lt_immo_tbien(code, valeur)
    VALUES
        ('10','Terrain vierge'),
	('11','Parking'),
	('12','Surface de dépôt ou de stockage'),
	('13','Surface agricole'),
	('20','Bureau'),
	('21','Commerce'),
	('22','Activité');

COMMENT ON TABLE m_economie.lt_immo_tbien
  IS 'Code permettant de décrire le type de bien';
COMMENT ON COLUMN m_economie.lt_immo_tbien.code IS 'Code du type de bien';
COMMENT ON COLUMN m_economie.lt_immo_tbien.valeur IS 'Valeur du type de bien';

--############################################################ lt_immo_etat ##################################################

CREATE TABLE m_reseau_sec.lt_immo_etat
(
  code character varying(2) NOT NULL,
  valeur character varying(80) NOT NULL,
  CONSTRAINT lt_immo_etat_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

INSERT INTO m_economie.lt_immo_etat(code, valeur)
    VALUES
        ('00','Non renseigné'),
	('10','Disponible à la vente (vacant)'),
	('20','Disponible à la vente (occupé)'),
	('30','Disponible à la locatiob'),
	('40','Indisponible (occupé)'),
	('ZZ','Non concerné');

COMMENT ON TABLE m_economie.lt_immo_etat
  IS 'Code permettant de décrire l''état du bien pour la vente';
COMMENT ON COLUMN m_economie.lt_immo_etat.code IS 'Code de l''état du bien pour la vente';
COMMENT ON COLUMN m_economie.lt_immo_etat.valeur IS 'Valeur de l''état du bien pour la vente';

-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                        CLASSES OBJETS                                                   ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################


--################################################################# geo_immo_objet #######################################################

CREATE TABLE m_economie.geo_immo_objet--------------------------------------------- Objet primitif du bien immobilier
	(
	idimmo      integer DEFAULT nextval( 'O' || 'm_economie.geo_immo_objet_seq') NOT NULL,---- Identifiant unique de l'objet
	idsite      character varying (7),-------------------------------------------------------- Identifiant du site d'activité d'appartenance
	sup_m2      integer ,--------------------------------------------------------------------- Superficie de l''objet en m²
	ityp        character varying (2) ,--------------------------------------- --------------- Type d''objet
	observ      character varying (254) ,--------------------------------------- Commune sur laquelle est situé le nœud
	op_sai      character varying (5),------------------------------------------ Code insee de la commune sur laquelle est situé le nœud
	date_sai    character varying (254),---------------------------------------- Entreprise ayant posé l''ouvrage électrique
	date_maj    timestamp without time zone ,----------------------------------- Date de la pose
	src_geom    varchar(2) NOT NULL DEFAULT '00',-------------------------------- Source du référentiel géographique pour le positionnement du nœud
	src_date
	insee
	commune
	geom
);

ALTER TABLE m_economie.geo_immo_objet
  ADD CONSTRAINT geo_immo_objet_pkey PRIMARY KEY(idimmo);

COMMENT ON TABLE m_economie.geo_immo_objet IS 'Table des objets graphiques correspond à la primitive des biens immobiliers';
COMMENT ON COLUMN m_economie.geo_immo_objet.idimmo IS 'Identifiant unique de l''objet';
COMMENT ON COLUMN m_economie.geo_immo_objet.idimmo IS 'Identifiant du site d''activité d'appartenance';
COMMENT ON COLUMN m_economie.geo_immo_objet.sup_m2 IS 'Superficie de l''objet en m²';
COMMENT ON COLUMN m_economie.geo_immo_objet.ityp IS 'Type d''objet';


-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                        CONTRAINTES                                                      ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################




