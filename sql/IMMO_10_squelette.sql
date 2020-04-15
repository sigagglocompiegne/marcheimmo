                                                                          
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

-- (à venir)

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
/*
DROP SEQUENCE m_economie.geo_immo_bien_seq;
DROP SEQUENCE m_economie.an_immo_bien_seq;
DROP SEQUENCE m_economie.an_immo_comm_seq ;
DROP SEQUENCE m_economie.an_immo_bati_seq;
DROP SEQUENCE m_economie.an_immo_prop_seq;
DROP SEQUENCE m_economie.an_immo_media_seq;
DROP SEQUENCE m_economie.lk_immo_bien_seq;
*/
--TRIGGERS

-- DROP TRIGGER IF EXISTS  ON m_economie. ;



-- ###############################################################################################################################
-- ###                                                                                                                         ###
-- ###                                                         SEQUENCE                                                        ###
-- ###                                                                                                                         ###
-- ###############################################################################################################################


--############################################################ geo_immo_bien_seq ##################################################

--############################################################ OBJETS ##################################################

/*
--DROP SEQUENCE m_economie.geo_immo_bien_seq;

CREATE SEQUENCE m_economie.geo_immo_bien_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1 
  CACHE 1;
  
COMMENT ON SEQUENCE m_economie.geo_immo_bien_seq
  IS 'Séquence unique pour tous les objets biens (la séquence est complétée par ''O'' dans l''attribut idimmo)';
*/
--############################################################ an_immo_bien_seq ##################################################

--DROP SEQUENCE m_economie.an_immo_bien_seq;
/*
CREATE SEQUENCE m_economie.an_immo_bien_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1 
  CACHE 1;
  
COMMENT ON SEQUENCE m_economie.an_immo_bien_seq
  IS 'Séquence unique pour tous les objets biens (la séquence est complétée par ''B'' dans l''attribut idbien)';
  */
--############################################################ an_immo_comm_seq ##################################################

--DROP SEQUENCE m_economie.an_immo_comm_seq;
/*
CREATE SEQUENCE m_economie.an_immo_comm_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1 
  CACHE 1;
  
COMMENT ON SEQUENCE m_economie.an_immo_comm_seq
  IS 'Séquence unique pour les bâtiments (la séquence est complétée par ''C'' dans l''attribut idcomm)';
  */

--############################################################ an_immo_bati_seq ##################################################

--DROP SEQUENCE m_economie.an_immo_bati_seq;
/*
CREATE SEQUENCE m_economie.an_immo_bati_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1 
  CACHE 1;
  
COMMENT ON SEQUENCE m_economie.an_immo_bati_seq
  IS 'Séquence unique pour les bâtiments (la séquence est complétée par ''BA'' dans l''attribut idbati)';
  */

--############################################################ an_immo_prop_seq ##################################################

--DROP SEQUENCE m_economie.an_immo_prop_seq;
/*
CREATE SEQUENCE m_economie.an_immo_prop_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1 
  CACHE 1;
  
COMMENT ON SEQUENCE m_economie.an_immo_prop_seq
  IS 'Séquence unique pour les propriétaires (la séquence est complétée par ''P'' dans l''attribut idprop)';
  */

--############################################################ an_immo_media_seq ##################################################

--############################################################ lk_immo_bien_seq ##################################################

--DROP SEQUENCE m_economie.lk_immo_bien_seq;
/*
CREATE SEQUENCE m_economie.lk_immo_bien_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1 
  CACHE 1;
  
COMMENT ON SEQUENCE m_economie.lk_immo_bien_seq
  IS 'Séquence unique pour toutes les relations objats bien et attributs métiers bien';
*/
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
	('10','Terrain'),
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
	('1','Double vitrage'),
	('2','Site clôturé'),
	('3','Places de parking'),
	('4','Murs périphériques (bardage métallique…)'),
	('5','Ossature (couverture bac acier…)'),
	('6','Menuiserie aluminium'),
	('7','Accès sécurisé'),
	('8','Système d''alarme'),
	('9','Parties communes'),
	('10','Portes de plain-pied'),
	('11','Charge au sol');

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
  code character varying(4) NOT NULL,
  valeur character varying(80) NOT NULL,
  ityp character varying(2) NOT NULL,
  CONSTRAINT lt_immo_tbien_pkey PRIMARY KEY (code)
)
WITH (
  OIDS=FALSE
);

INSERT INTO m_economie.lt_immo_tbien(code, valeur,ityp)
    VALUES
        ('1010','Terrain vierge','10'),
	('1110','Parking','10'),
	('1210','Surface de dépôt ou de stockage','10'),
	('1310','Surface agricole','10'),
	('2021','Bureau','21'),
	('2121','Commerce','21'),
	('2221','Activité','21'),
	('2022','Bureau','22'),
	('2122','Commerce','22'),
	('2222','Activité','22'),
	('2023','Bureau','23'),
	('2123','Commerce','23'),
	('2223','Activité','23');

COMMENT ON TABLE m_economie.lt_immo_tbien
  IS 'Code permettant de décrire le type de bien';
COMMENT ON COLUMN m_economie.lt_immo_tbien.code IS 'Code du type de bien';
COMMENT ON COLUMN m_economie.lt_immo_tbien.valeur IS 'Valeur du type de bien';
COMMENT ON COLUMN m_economie.lt_immo_tbien.ityp IS 'Valeur du type d''occupation liée (pour fonctionnel GEO)';

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
	idimmo      text DEFAULT 'O' || nextval('m_economie.geo_immo_bien_seq') NOT NULL,--------- Identifiant unique de l'objet
	idsite      character varying (7),-------------------------------------------------------- Identifiant du site d'activité d'appartenance
	sup_m2      integer ,--------------------------------------------------------------------- Superficie de l''objet en m² (surface SIG)
	ityp        character varying (2) ,------------------------------------------------------- Type d''occupation
	observ      character varying (1000) ,----------------------------------------------------- Observations
	op_sai      character varying (25),------------------------------------------------------- Opérateur de saisie
	date_sai    timestamp without time zone default now(),------------------------------------ Date de saisie
	date_maj    timestamp without time zone ,------------------------------------------------- Date de mise à jour
	src_geom    varchar(2) NOT NULL DEFAULT '00',--------------------------------------------- Source du référentiel géographique pour le positionnement du nœud
	src_date    integer,---------------------------------------------------------------------- Année du référentiel de saisi
	insee       character varying(11),-------------------------------------------------------- Code Insee de la ou des communes d'assises
	commune     character varying(160),------------------------------------------------------- Libellé de la ou des communes d'assises
	geom       geometry(MultiPolygon,2154)---------------------------------------------------- Attribut de géométrie
);

ALTER TABLE m_economie.geo_immo_bien
  ADD CONSTRAINT geo_immo_bien_pkey PRIMARY KEY(idimmo);

COMMENT ON TABLE m_economie.geo_immo_bien IS 'Table des objets graphiques correspond à la primitive des biens immobiliers';
COMMENT ON COLUMN m_economie.geo_immo_bien.idimmo IS 'Identifiant unique de l''objet';
COMMENT ON COLUMN m_economie.geo_immo_bien.idsite IS 'Identifiant du site d''activité d''appartenance';
COMMENT ON COLUMN m_economie.geo_immo_bien.sup_m2 IS 'Superficie de l''objet en m²';
COMMENT ON COLUMN m_economie.geo_immo_bien.ityp IS 'Type d''occupation';
COMMENT ON COLUMN m_economie.geo_immo_bien.observ IS 'Observations';
COMMENT ON COLUMN m_economie.geo_immo_bien.op_sai IS 'Opérateur de saisie';
COMMENT ON COLUMN m_economie.geo_immo_bien.date_sai IS 'Date de saisie';
COMMENT ON COLUMN m_economie.geo_immo_bien.date_maj IS 'Date de mise à jour';
COMMENT ON COLUMN m_economie.geo_immo_bien.src_geom IS 'Source du référentiel géographique pour le positionnement du nœud';
COMMENT ON COLUMN m_economie.geo_immo_bien.src_date IS 'Année du référentiel de saisi';
COMMENT ON COLUMN m_economie.geo_immo_bien.insee IS 'Code Insee de la ou des communes d''assises';
COMMENT ON COLUMN m_economie.geo_immo_bien.commune IS 'Libellé de la ou des communes d''assises';
COMMENT ON COLUMN m_economie.geo_immo_bien.geom IS 'Attribut de géométrie';

--################################################################# an_immo_bien #######################################################

CREATE TABLE m_economie.an_immo_bien--------------------------------------------- Attribut métier du bien immobilier
	(
	idbien      text DEFAULT 'B' || nextval('m_economie.an_immo_bien_seq') NOT NULL,---------- Identifiant unique du bien
	idimmo      text,------------------------------------------------------------------------- Identifiant de l''objet bien
	tbien       character varying (4),-------------------------------------------------------- Type de bien
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
	observ      character varying (1000) ----------------------------------------------------- Observations
);

ALTER TABLE m_economie.an_immo_bien
  ADD CONSTRAINT an_immo_bien_pkey PRIMARY KEY(idimmo);

COMMENT ON TABLE m_economie.an_immo_bien IS 'Table des objets graphiques correspond à la primitive des biens immobiliers';
COMMENT ON COLUMN m_economie.an_immo_bien.idbien IS 'Identifiant unique du bien';
COMMENT ON COLUMN m_economie.an_immo_bien.idimmo IS 'Identifiant unique de l''objet bien';
COMMENT ON COLUMN m_economie.an_immo_bien.tbien IS 'Type de bien';
COMMENT ON COLUMN m_economie.an_immo_bien.libelle IS 'Libellé du bien';
COMMENT ON COLUMN m_economie.an_immo_bien.bdesc IS 'Description du bien';
COMMENT ON COLUMN m_economie.an_immo_bien.pdp IS 'Bien en pas-de-porte';
COMMENT ON COLUMN m_economie.an_immo_bien.bal IS 'Identifiant de la base adresse';
COMMENT ON COLUMN m_economie.an_immo_bien.adr IS 'Adresse litérale (si différente de la BAL)';
COMMENT ON COLUMN m_economie.an_immo_bien.adrcomp IS 'Complément d''adresse';
COMMENT ON COLUMN m_economie.an_immo_bien.surf IS 'Surface en hectare';
COMMENT ON COLUMN m_economie.an_immo_bien.surf_m IS 'Surface en m²';
COMMENT ON COLUMN m_economie.an_immo_bien.mprop IS 'Même propriétaire que le bâtiment';
COMMENT ON COLUMN m_economie.an_immo_bien.source IS 'Source de la mise à jour';
COMMENT ON COLUMN m_economie.an_immo_bien.refext IS 'Lien vers un site présentant le terrain';
COMMENT ON COLUMN m_economie.an_immo_bien.observ IS 'Observations';

--################################################################# an_immo_prop #######################################################

CREATE TABLE m_economie.an_immo_prop --------------------------------------------- Attribut métier du propriétaire
	(
	idprop      text DEFAULT 'P' || nextval('m_economie.an_immo_prop_seq') NOT NULL,---------- Identifiant unique du propriétaire
	idbati      text,------------------------------------------------------------------------- Identifiant du bâtiment
	idimmo	    text,------------------------------------------------------------------------- Identifiant de l'objet
	propnom     character varying (100),------------------------------------------------------ Nom du propriétaire
	proptel     character varying (14),------------------------------------------------------- Téléphone du propriétaire
	proptelp    character varying (14),------------------------------------------------------- Téléphone portable du propriétaire	
	propmail    character varying (80),------------------------------------------------------- Email du propriétaire	
	observ      character varying (1000) ----------------------------------------------------- Observations
);

ALTER TABLE m_economie.an_immo_prop
  ADD CONSTRAINT an_immo_prop_pkey PRIMARY KEY(idprop);

COMMENT ON TABLE m_economie.an_immo_prop IS 'Table des objets graphiques correspond à la primitive des biens immobiliers';
COMMENT ON COLUMN m_economie.an_immo_prop.idprop IS 'Identifiant du propriétaire';
COMMENT ON COLUMN m_economie.an_immo_prop.idbati IS 'Identifiant du bâtiment';
COMMENT ON COLUMN m_economie.an_immo_prop.idimmo IS 'Identifiant de l''objet';
COMMENT ON COLUMN m_economie.an_immo_prop.propnom IS 'Nom du propriétaire';
COMMENT ON COLUMN m_economie.an_immo_prop.proptel IS 'Téléphone du propriétaire';
COMMENT ON COLUMN m_economie.an_immo_prop.proptelp IS 'Téléphone portable du propriétaire';
COMMENT ON COLUMN m_economie.an_immo_prop.propmail IS 'Email du propriétaire';
COMMENT ON COLUMN m_economie.an_immo_prop.observ IS 'Observations';

--################################################################# an_immo_bati #######################################################

CREATE TABLE m_economie.an_immo_bati --------------------------------------------- Attribut métier du propriétaire
	(
	idbati      text DEFAULT 'BA' || nextval('m_economie.an_immo_bati_seq') NOT NULL,--------- Identifiant unique du bâtiment
	idimmo      text,------------------------------------------------------------------------- Identifiant de l''objet
	libelle     character varying (254),------------------------------------------------------ Libellé du bâtiment
	surf_m      integer,---------------------------------------------------------------------- Surface en m²	
	shon        integer,---------------------------------------------------------------------- Surface de plancher en m²
	hauteur     integer,---------------------------------------------------------------------- Hauteur em mètre
	nbloc       integer,---------------------------------------------------------------------- Nombre de local dans le bâtiment
	bdesc       character varying(100),------------------------------------------------------- Description du bâtiment
	observ      character varying(1000)------------------------------------------------------- Observations
);

ALTER TABLE m_economie.an_immo_bati
  ADD CONSTRAINT an_immo_bati_pkey PRIMARY KEY(idbati);

COMMENT ON TABLE m_economie.an_immo_bati IS 'Table des objets graphiques correspond au bâtiment contenant le bien de type de local';
COMMENT ON COLUMN m_economie.an_immo_bati.idbati IS 'Identifiant du bâtiment';
COMMENT ON COLUMN m_economie.an_immo_bati.idimmo IS 'Identifiant de l''objet';
COMMENT ON COLUMN m_economie.an_immo_bati.libelle IS 'Libellé du bâtiment';
COMMENT ON COLUMN m_economie.an_immo_bati.surf_m IS 'Surface en m²';
COMMENT ON COLUMN m_economie.an_immo_bati.shon IS 'Surface de plancher en m²';
COMMENT ON COLUMN m_economie.an_immo_bati.hauteur IS 'Hauteur em mètre';
COMMENT ON COLUMN m_economie.an_immo_bati.nbloc IS 'Nombre de local dans le bâtiment';
COMMENT ON COLUMN m_economie.an_immo_bati.bdesc IS 'Description du bâtiment';
COMMENT ON COLUMN m_economie.an_immo_bati.observ IS 'Observations';

--################################################################# an_immo_comm #######################################################

CREATE TABLE m_economie.an_immo_comm --------------------------------------------- Attribut métier de la commercialisation
	(
	idcomm      text DEFAULT 'C' || nextval('m_economie.an_immo_comm_seq') NOT NULL,---------- Identifiant unique de la commercialisation
	idimmo      text,------------------------------------------------------------------------- Identifiant de l''objet bien
	prix     character varying (254),--------------------------------------------------------- Prix total
	prix_m      integer,---------------------------------------------------------------------- Prix au m²
	loyer        integer,--------------------------------------------------------------------- Loyer total
	loyer_m     integer,---------------------------------------------------------------------- Loyer au m²
	bail       integer,----------------------------------------------------------------------- Montant du Bail
	comm       character varying(100),-------------------------------------------------------- Nom du commercialisateur
	commtel      character varying(1000)------------------------------------------------------ Téléphone du commercialisateur
	commtelp      character varying(1000)----------------------------------------------------- Téléphone portable du commercialisateur
	commmail      character varying(1000)----------------------------------------------------- Email du commercialisateur
	etat      character varying(1000)--------------------------------------------------------- Etat de la commercialisation
	source      character varying(1000)------------------------------------------------------- Source
	refext      character varying(254)-------------------------------------------------------- Référence externe d'un site internet présentant une fiche de commercialisation
	observ      character varying(1000)------------------------------------------------------- Observations
);

ALTER TABLE m_economie.an_immo_comm
  ADD CONSTRAINT an_immo_comm_pkey PRIMARY KEY(idcomm);

COMMENT ON TABLE m_economie.an_immo_comm IS 'Table des objets graphiques correspond au bâtiment contenant le bien de type de local';
COMMENT ON COLUMN m_economie.an_immo_comm.idcomm IS 'Identifiant unique de la commercialisation';
COMMENT ON COLUMN m_economie.an_immo_comm.idimmo IS 'Identifiant de l''objet bien';
COMMENT ON COLUMN m_economie.an_immo_comm.prix IS 'Prix total';
COMMENT ON COLUMN m_economie.an_immo_comm.prix_m IS 'Prix au m²';
COMMENT ON COLUMN m_economie.an_immo_comm.loyer IS 'Loyer total';
COMMENT ON COLUMN m_economie.an_immo_comm.loyer_m IS 'Loyer au m²';
COMMENT ON COLUMN m_economie.an_immo_comm.bail IS 'Montant du Bail';
COMMENT ON COLUMN m_economie.an_immo_comm.comm IS 'Nom du commercialisateur';
COMMENT ON COLUMN m_economie.an_immo_comm.commtel IS 'Téléphone du commercialisateur';
COMMENT ON COLUMN m_economie.an_immo_comm.commtelp IS 'Téléphone portable du commercialisateur';
COMMENT ON COLUMN m_economie.an_immo_comm.commmail IS 'Email du commercialisateur';
COMMENT ON COLUMN m_economie.an_immo_comm.etat IS 'Etat de la commercialisation';
COMMENT ON COLUMN m_economie.an_immo_comm.source IS 'Source';
COMMENT ON COLUMN m_economie.an_immo_comm.refext IS 'Référence externe d'un site internet présentant une fiche de commercialisation';
COMMENT ON COLUMN m_economie.an_immo_comm.observ IS 'Observations';

--################################################################# lk_immo_bien #######################################################

CREATE TABLE m_economie.lk_immo_bien
	(
	id          integer DEFAULT nextval('m_economie.lk_immo_bien_seq') NOT NULL,---- Identifiant unique de l'objet
	idimmo      text,------------------------------------------------------------ Identifiant unique géographique du bien
	idbien      text ------------------------------------------------------------ Identifiant unique métier du bien
	
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

/*
-- pas de clé étrangère ici car plusieurs valeurs possibles depuis GEO
ALTER TABLE m_economie.an_immo_bati
  ADD CONSTRAINT an_immo_bati_bdesc_fkey FOREIGN KEY (bdesc)
      REFERENCES m_economie.lt_immo_dbati(code) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE SET DEFAULT;
*/

ALTER TABLE m_economie.an_immo_comm
  ADD CONSTRAINT an_immo_comm_etat_fkey FOREIGN KEY (etat)
      REFERENCES m_economie.lt_immo_etat(code) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE SET DEFAULT;
