                                                                          
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

DROP TABLE IF EXISTS m_economie.geo_immo_bien CASCADE;
DROP TABLE IF EXISTS m_economie.an_immo_bien CASCADE;
DROP TABLE IF EXISTS m_economie.an_immo_bati CASCADE;
DROP TABLE IF EXISTS m_economie.an_immo_prop CASCADE;
DROP TABLE IF EXISTS m_economie.an_immo_comm CASCADE;
DROP TABLE IF EXISTS m_economie.an_immo_media CASCADE;
DROP TABLE IF EXISTS m_economie.lk_immo_bien CASCADE;
DROP TABLE IF EXISTS m_economie.lk_immo_occupant CASCADE;
DROP TABLE IF EXISTS m_economie.lk_immo_bienbati CASCADE;



-- DOMAINES DE VALEUR

DROP TABLE IF EXISTS m_economie.lt_immo_ityp CASCADE;
DROP TABLE IF EXISTS m_economie.lt_immo_dbien CASCADE;
DROP TABLE IF EXISTS m_economie.lt_immo_dbati CASCADE;
DROP TABLE IF EXISTS m_economie.lt_immo_tbien CASCADE;
DROP TABLE IF EXISTS m_economie.lt_immo_etat CASCADE;


--SEQUENCES

DROP SEQUENCE m_economie.geo_immo_bien_seq;
DROP SEQUENCE m_economie.an_immo_bien_seq;
DROP SEQUENCE m_economie.an_immo_comm_seq ;
DROP SEQUENCE m_economie.an_immo_bati_seq;
DROP SEQUENCE m_economie.an_immo_prop_seq;
DROP SEQUENCE m_economie.an_immo_media_seq;
DROP SEQUENCE m_economie.lk_immo_bien_seq;

--TRIGGERS

-- DROP TRIGGER IF EXISTS  ON m_economie. ;



-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                         SEQUENCE                                                        ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################


--############################################################ geo_immo_bien_seq ##################################################

--############################################################ OBJETS ##################################################


--DROP SEQUENCE m_economie.geo_immo_bien_seq;

CREATE SEQUENCE m_economie.geo_immo_bien_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1 
  CACHE 1;
  
COMMENT ON SEQUENCE m_economie.geo_immo_bien_seq
  IS 'Séquence unique pour tous les objets biens (la séquence est complétée par 'O' dans l'attribut idimmo);

--############################################################ an_immo_bien_seq ##################################################

--DROP SEQUENCE m_economie.an_immo_bien_seq;

CREATE SEQUENCE m_economie.an_immo_bien_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1 
  CACHE 1;
  
COMMENT ON SEQUENCE m_economie.an_immo_bien_seq
  IS 'Séquence unique pour tous les objets biens (la séquence est complétée par 'B' dans l'attribut idbien);
  
--############################################################ an_immo_comm_seq ##################################################

--############################################################ an_immo_bati_seq ##################################################

--############################################################ an_immo_prop_seq ##################################################

--############################################################ an_immo_media_seq ##################################################

--############################################################ lk_immo_bien_seq ##################################################

--DROP SEQUENCE m_economie.lk_immo_bien_seq;

CREATE SEQUENCE m_economie.lk_immo_bien_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1 
  CACHE 1;
  
COMMENT ON SEQUENCE m_economie.lk_immo_bien_seq
  IS 'Séquence unique pour toutes les relations objats bien et attributs métiers bien;

-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                    DOMAINES DE VALEURS                                                  ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################


--############################################################ lt_immo_ityp ##################################################

CREATE TABLE m_economie.lt_immo_ityp
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

CREATE TABLE m_economie.lt_immo_dbati
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

CREATE TABLE m_economie.lt_immo_dbien
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

CREATE TABLE m_economie.lt_immo_tbien
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

CREATE TABLE m_economie.lt_immo_etat
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


--################################################################# geo_immo_bien #######################################################

CREATE TABLE m_economie.geo_immo_bien--------------------------------------------- Objet primitif du bien immobilier
	(
	idimmo      integer DEFAULT nextval( 'O' || 'm_economie.geo_immo_bien_seq') NOT NULL,---- Identifiant unique de l'objet
	idsite      character varying (7),-------------------------------------------------------- Identifiant du site d'activité d'appartenance
	sup_m2      integer ,--------------------------------------------------------------------- Superficie de l''objet en m² (surface SIG)
	ityp        character varying (2) ,------------------------------------------------------- Type d''objet
	observ      character varying (254) ,----------------------------------------------------- Observations
	op_sai      character varying (25),------------------------------------------------------- Opérateur de saisie
	date_sai    timestamp without time zone default now(),------------------------------------ Date de saisie
	date_maj    timestamp without time zone ,------------------------------------------------- Date de mise à jour
	src_geom    varchar(2) NOT NULL DEFAULT '00',--------------------------------------------- Source du référentiel géographique pour le positionnement du nœud
	src_date    integer,---------------------------------------------------------------------- Année du référentiel de saisi
	insee       character varying(11),-------------------------------------------------------- Code Insee de la ou des communes d'assises
	commune     character varying(160),------------------------------------------------------- Libellé de la ou des communes d'assises
	geom        geom(multipolygon,2154)------------------------------------------------------- Attribut de géométrie
);

ALTER TABLE m_economie.geo_immo_bien
  ADD CONSTRAINT geo_immo_bien_pkey PRIMARY KEY(idimmo);

COMMENT ON TABLE m_economie.geo_immo_bien IS 'Table des objets graphiques correspond à la primitive des biens immobiliers';
COMMENT ON COLUMN m_economie.geo_immo_bien.idimmo IS 'Identifiant unique de l''objet';
COMMENT ON COLUMN m_economie.geo_immo_bien.idimmo IS 'Identifiant du site d''activité d'appartenance';
COMMENT ON COLUMN m_economie.geo_immo_bien.sup_m2 IS 'Superficie de l''objet en m²';
COMMENT ON COLUMN m_economie.geo_immo_bien.ityp IS 'Type d''objet';
COMMENT ON COLUMN m_economie.geo_immo_bien.observ IS 'Observations';
COMMENT ON COLUMN m_economie.geo_immo_bien.op_sai IS 'Opérateur de saisie';
COMMENT ON COLUMN m_economie.geo_immo_bien.date_sai IS 'Date de saisie';
COMMENT ON COLUMN m_economie.geo_immo_bien.date_maj IS 'Date de mise à jour';
COMMENT ON COLUMN m_economie.geo_immo_bien.src_geom IS 'Source du référentiel géographique pour le positionnement du nœud';
COMMENT ON COLUMN m_economie.geo_immo_bien.src_date IS 'Année du référentiel de saisi';
COMMENT ON COLUMN m_economie.geo_immo_bien.insee IS 'Code Insee de la ou des communes d'assises';
COMMENT ON COLUMN m_economie.geo_immo_bien.commune IS 'Libellé de la ou des communes d'assises';
COMMENT ON COLUMN m_economie.geo_immo_bien.geom IS 'Attribut de géométrie';

--################################################################# an_immo_bien #######################################################

CREATE TABLE m_economie.an_immo_bien--------------------------------------------- Objet primitif du bien immobilier
	(
	idbien      integer DEFAULT nextval( 'B' || 'm_economie.geo_immo_objet_seq') NOT NULL,---- Identifiant unique du bien
	tbien       character varying (2),-------------------------------------------------------- Type de bien
	libelle     character varying (254) ,----------------------------------------------------- Libellé du bien
	bdesc       character varying (100) ,----------------------------------------------------- Description du bien
	pdp	    boolean default false,-------------------------------------------------------- Bien en pas-de-porte
	bal	    integer,---------------------------------------------------------------------- Identifiant de la base adresse
	adr	    character varying (254),------------------------------------------------------ Adresse litérale (si différente de la BAL)
	adrcomp	    character varying (100),------------------------------------------------------ Complément d'adresse
	surf	    double precision,------------------------------------------------------------- Surface en hectare
	surf_m	    integer,---------------------------------------------------------------------- Surface en m²
	mprop	    boolean default false,-------------------------------------------------------- Même propriétaire que le bâtiment
	source	    character varying (254),------------------------------------------------------ Source de la mise à jour
	refext	    character varying (254),------------------------------------------------------ Lien vers un site présentant le terrain
	observ      character varying (254) ,----------------------------------------------------- Observations
	op_sai      character varying (25),------------------------------------------------------- Opérateur de saisie
	date_sai    timestamp without time zone default now(),------------------------------------ Date de saisie
	date_maj    timestamp without time zone--------------------------------------------------- Date de mise à jour
);

ALTER TABLE m_economie.geo_immo_objet
  ADD CONSTRAINT geo_immo_objet_pkey PRIMARY KEY(idimmo);

COMMENT ON TABLE m_economie.geo_immo_objet IS 'Table des objets graphiques correspond à la primitive des biens immobiliers';
COMMENT ON COLUMN m_economie.geo_immo_objet.idbien IS '';
COMMENT ON COLUMN m_economie.geo_immo_objet.tbien IS '';
COMMENT ON COLUMN m_economie.geo_immo_objet.libelle IS '';
COMMENT ON COLUMN m_economie.geo_immo_objet.bdesc IS '';
COMMENT ON COLUMN m_economie.geo_immo_objet.pdp IS '';
COMMENT ON COLUMN m_economie.geo_immo_objet.bal IS '';
COMMENT ON COLUMN m_economie.geo_immo_objet.adr IS '';
COMMENT ON COLUMN m_economie.geo_immo_objet.adrcomp IS '';
COMMENT ON COLUMN m_economie.geo_immo_objet.surf IS '';
COMMENT ON COLUMN m_economie.geo_immo_objet.surf_m IS '';
COMMENT ON COLUMN m_economie.geo_immo_objet.mprop IS '';
COMMENT ON COLUMN m_economie.geo_immo_objet.source IS '';
COMMENT ON COLUMN m_economie.geo_immo_objet.refext IS '';
COMMENT ON COLUMN m_economie.geo_immo_objet.observ IS '';
COMMENT ON COLUMN m_economie.geo_immo_objet.op_sai IS '';
COMMENT ON COLUMN m_economie.geo_immo_objet.date_sai IS '';
COMMENT ON COLUMN m_economie.geo_immo_objet.date_maj IS '';


--################################################################# lk_immo_bien #######################################################

CREATE TABLE m_economie.lk_immo_bien
	(
	id          integer DEFAULT nextval('m_economie.lk_immo_bien_seq') NOT NULL,---- Identifiant unique de l'objet
	idimmo      integer,------------------------------------------------------------ Identifiant unique géographique du bien
	idbien      integer ------------------------------------------------------------ Identifiant unique métier du bien
	
);

ALTER TABLE m_economie.lk_immo_bien
  ADD CONSTRAINT lk_immo_bien_pkey PRIMARY KEY(id);

COMMENT ON TABLE m_economie.lk_immo_bien IS 'Table des relations entre les objets biens et les attributs métiers biens (1 objet peut contenir n fiches bien)';
COMMENT ON COLUMN m_economie.lk_immo_bien.id IS 'Identifiant unique de la relation';
COMMENT ON COLUMN m_economie.lk_immo_bien.idimmo IS 'Identifiant unique géographique du bien';
COMMENT ON COLUMN m_economie.lk_immo_bien.idbien IS 'Identifiant unique métier du bien';


-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                        CONTRAINTES                                                      ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################


-- CLE ETRANGERE

ALTER TABLE m_economie.geo_immo_bien
  ADD CONSTRAINT geo_immo_bien_ityp_fkey FOREIGN KEY (ityp)
      REFERENCES m_economie.lt_immo_ityp(code) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE SET DEFAULT;
      
ALTER TABLE m_economie.geo_immo_bien
  ADD CONSTRAINT geo_immo_bien_geom_fkey FOREIGN KEY (src_geom)
      REFERENCES r_objet.lt_src_geom(code) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE SET DEFAULT;
      
ALTER TABLE m_economie.an_immo_bien
  ADD CONSTRAINT an_immo_bien_tbien_fkey FOREIGN KEY (tbien)
      REFERENCES m_economie.lt_immo_tbien(code) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE SET DEFAULT;
