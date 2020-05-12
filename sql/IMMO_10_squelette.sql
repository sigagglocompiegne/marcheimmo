                                                                          
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

DROP VIEW IF EXISTS x_apps.xapps_geo_v_immo_etat;

-- CLASSES

DROP TABLE IF EXISTS m_economie.geo_immo_bien CASCADE;
DROP TABLE IF EXISTS m_economie.an_immo_bien CASCADE;
DROP TABLE IF EXISTS m_economie.an_immo_bati CASCADE;
DROP TABLE IF EXISTS m_economie.an_immo_prop CASCADE;
DROP TABLE IF EXISTS m_economie.an_immo_comm CASCADE;
DROP TABLE IF EXISTS m_economie.an_immo_media CASCADE;
DROP TABLE IF EXISTS m_economie.lk_immo_occup CASCADE;
DROP TABLE IF EXISTS m_economie.lk_immo_ityp CASCADE;


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
DROP SEQUENCE m_economie.lk_immo_occup_seq;
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

--DROP SEQUENCE m_economie.an_immo_media_seq;
/*
CREATE SEQUENCE m_economie.an_immo_media_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1 
  CACHE 1;
  
COMMENT ON SEQUENCE m_economie.an_immo_media_seq
  IS 'Séquence unique pour l''identifiant media';
  */

--############################################################ lk_immo_occup_seq ##################################################
--DROP SEQUENCE m_economie.lk_immo_occup_seq;
/*
CREATE SEQUENCE m_economie.lk_immo_occup_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1 
  CACHE 1;
  
COMMENT ON SEQUENCE m_economie.lk_immo_occup_seq
  IS 'Séquence unique pour la relation bien et occupant(s)';
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
	('11','Charge au sol'),
	('12','Terrain attenant');

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
	('10','Disponible à la vente (vacant)'),
	('20','Disponible à la vente (occupé)'),
	('30','Disponible à la location'),
	('40','Disponible à la vente ou à la location'),
	('ZZ','Non concerné (occupé)');

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
	idbati	    text,------------------------------------------------------------------------- Identifiant du bâti
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
COMMENT ON COLUMN m_economie.geo_immo_bien.idbati IS 'Identifiant unique bu bâtiment';
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

-- FONCTIONS

-- CALCUL SURFACE SIG DE l'OBJET SAISI (à l'insertioin et à la mise à jour)

-- Trigger: t_t1_insert_update_surf_immo_bien
-- DROP TRIGGER t_t1_insert_update_surf_immo_bien ON m_economie.geo_immo_bien;

CREATE TRIGGER t_t1_insert_update_surf_immo_bien
    BEFORE INSERT OR UPDATE 
    ON m_economie.geo_immo_bien
    FOR EACH ROW
    EXECUTE PROCEDURE public.ft_r_sup_m2_maj();

-- INSERTION DATE DU JOUR UNIQUEMENT DANS LE CADRE D'UNE MISE A JOUR (date de mise à jour)

-- Trigger: t_t2_insert_update_datemaj_immo_bien
-- DROP TRIGGER t_t2_insert_update_datemaj_immo_bien ON m_economie.geo_immo_bien;

CREATE TRIGGER t_t2_insert_update_datemaj_immo_bien
    BEFORE UPDATE 
    ON m_economie.geo_immo_bien
    FOR EACH ROW
    EXECUTE PROCEDURE public.ft_r_timestamp_maj();

-- INSERTION DU OU DES CODES INSEE ET DU LIBELLE DE LA OU DES COMMUNNES correspondant à la commnune d'appartenance de l'objet saisie

-- Trigger: t_t3_insert_update_commune_immo_bien
-- DROP TRIGGER t_t3_insert_update_commune_immo_bien ON m_economie.geo_immo_bien;

CREATE TRIGGER t_t3_insert_update_commune_immo_bien
    BEFORE INSERT OR UPDATE
    ON m_economie.geo_immo_bien
    FOR EACH ROW
    EXECUTE PROCEDURE public.ft_r_commune_s();


   
    
-- FONCTIONN : SUPPRESSION DES OCCUPANTS LORSQUE SUPRESSION DE L'OBJET SAISI (les autres suppressions ont été définies dans GEO
-- au niveau des relations)


-- FUNCTION: m_economie.ft_m_delete_occup_immo_bati()
-- DROP FUNCTION m_economie.ft_m_delete_occup_immo_bati();

CREATE OR REPLACE FUNCTION m_economie.ft_m_delete_occup_immo_bati()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$


BEGIN

     DELETE FROM m_economie.lk_immo_occup WHERE idimmo = old.idimmo;
     return new ;

END;

$BODY$;

ALTER FUNCTION m_economie.ft_m_delete_occup_immo_bati()
    OWNER TO sig_create;

GRANT EXECUTE ON FUNCTION m_economie.ft_m_delete_occup_immo_bati() TO edit_sig;

GRANT EXECUTE ON FUNCTION m_economie.ft_m_delete_occup_immo_bati() TO sig_create;

GRANT EXECUTE ON FUNCTION m_economie.ft_m_delete_occup_immo_bati() TO create_sig;

GRANT EXECUTE ON FUNCTION m_economie.ft_m_delete_occup_immo_bati() TO PUBLIC;

COMMENT ON FUNCTION m_economie.ft_m_insert_immo_bati()
    IS 'Fonction gérant la suppression de la relation bien immobiliser occupant lorsque l''objet saisi est supprimé';
	

-- Trigger: t_t4_delete_occup_immo_bien
-- DROP TRIGGER t_t4_delete_occup_immo_bien ON m_economie.geo_immo_bien;

CREATE TRIGGER t_t4_delete_occup_immo_bien
    AFTER DELETE
    ON m_economie.geo_immo_bien
    FOR EACH ROW
    EXECUTE PROCEDURE m_economie.ft_m_delete_occup_immo_bati();

--################################################################# an_immo_bien #######################################################

CREATE TABLE m_economie.an_immo_bien--------------------------------------------- Attribut métier du bien immobilier
	(
	idbien      text DEFAULT 'B' || nextval('m_economie.an_immo_bien_seq') NOT NULL,---------- Identifiant unique du bien
	idimmo      text,------------------------------------------------------------------------- Identifiant de l''objet bien
	tbien       character varying (4),-------------------------------------------------------- Type de bien
	libelle     character varying (254) ,----------------------------------------------------- Libellé du bien
	bdesc       character varying (100) ,----------------------------------------------------- Description du bien
	pdp	    boolean default false,-------------------------------------------------------- Bien en pas-de-porte
	lib_occup   character varying(150),------------------------------------------------------- Libellé de l'occupant ou détail sur le type d'occupation (si pas un établissement lié)
	bal	    integer,---------------------------------------------------------------------- Identifiant de la base adresse
	adr	    character varying (254),------------------------------------------------------ Adresse litérale (si différente de la BAL)
	adrcomp	    character varying (100),------------------------------------------------------ Complément d'adresse
	surf_m	    integer,---------------------------------------------------------------------- Surface en m²
	source	    character varying (254),------------------------------------------------------ Source de la mise à jour
	refext	    character varying (254),------------------------------------------------------ Lien vers un site présentant le terrain
	observ      character varying (1000) ----------------------------------------------------- Observations
);

ALTER TABLE m_economie.an_immo_bien
  ADD CONSTRAINT an_immo_bien_pkey PRIMARY KEY(idbien);

COMMENT ON TABLE m_economie.an_immo_bien IS 'Table des objets graphiques correspond à la primitive des biens immobiliers';
COMMENT ON COLUMN m_economie.an_immo_bien.idbien IS 'Identifiant unique du bien';
COMMENT ON COLUMN m_economie.an_immo_bien.idimmo IS 'Identifiant unique de l''objet bien';
COMMENT ON COLUMN m_economie.an_immo_bien.tbien IS 'Type de bien';
COMMENT ON COLUMN m_economie.an_immo_bien.libelle IS 'Libellé du bien';
COMMENT ON COLUMN m_economie.an_immo_bien.lib_occup IS 'Libellé de l''occupant ou détail sur le type d''occupation (si pas un établissement lié)';
COMMENT ON COLUMN m_economie.an_immo_bien.bdesc IS 'Description du bien';
COMMENT ON COLUMN m_economie.an_immo_bien.pdp IS 'Bien en pas-de-porte';
COMMENT ON COLUMN m_economie.an_immo_bien.bal IS 'Identifiant de la base adresse';
COMMENT ON COLUMN m_economie.an_immo_bien.adr IS 'Adresse litérale (si différente de la BAL)';
COMMENT ON COLUMN m_economie.an_immo_bien.adrcomp IS 'Complément d''adresse';
COMMENT ON COLUMN m_economie.an_immo_bien.surf_m IS 'Surface en m²';
COMMENT ON COLUMN m_economie.an_immo_bien.source IS 'Source de la mise à jour';
COMMENT ON COLUMN m_economie.an_immo_bien.refext IS 'Lien vers un site présentant le terrain';
COMMENT ON COLUMN m_economie.an_immo_bien.observ IS 'Observations';


-- FONCTION : suppression des occupants à la suppression d'un bien (et en cascade si supprime l'objet saisi)

CREATE OR REPLACE FUNCTION m_economie.ft_m_delete_immo_bien()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$


BEGIN

     DELETE FROM m_economie.lk_immo_occup WHERE idbien = old.idbien;
     DELETE FROM m_economie.an_immo_prop WHERE idbien = old.idbien;
     DELETE FROM m_economie.an_immo_comm WHERE idbien = old.idbien;
     return new ;

END;

$BODY$;

ALTER FUNCTION m_economie.ft_m_delete_immo_bien()
    OWNER TO sig_create;

GRANT EXECUTE ON FUNCTION m_economie.ft_m_delete_immo_bien() TO edit_sig;

GRANT EXECUTE ON FUNCTION m_economie.ft_m_delete_immo_bien() TO sig_create;

GRANT EXECUTE ON FUNCTION m_economie.ft_m_delete_immo_bien() TO create_sig;

GRANT EXECUTE ON FUNCTION m_economie.ft_m_delete_immo_bien() TO PUBLIC;

COMMENT ON FUNCTION m_economie.ft_m_delete_immo_bien()
    IS 'Fonction gérant la suppression de la relation bien immobiliser occupant, des propriétaires et commercialisation lorsque le bien est supprimé';
	

-- Trigger: t_t4_delete_occup_immo_bien
-- DROP TRIGGER t_t4_delete_immo_bien ON m_economie.geo_immo_bien;

CREATE TRIGGER t_t4_delete_immo_bien
    AFTER DELETE
    ON m_economie.an_immo_bien
    FOR EACH ROW
    EXECUTE PROCEDURE m_economie.ft_m_delete_immo_bien();

--################################################################# an_immo_prop #######################################################

CREATE TABLE m_economie.an_immo_prop --------------------------------------------- Attribut métier du propriétaire
	(
	idprop      text DEFAULT 'P' || nextval('m_economie.an_immo_prop_seq') NOT NULL,---------- Identifiant unique du propriétaire
	idbati      text,------------------------------------------------------------------------- Identifiant du bâtiment
	idimmo	    text,------------------------------------------------------------------------- Identifiant de l'objet
	idbien	    text,------------------------------------------------------------------------- Identifiant du bien
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
COMMENT ON COLUMN m_economie.an_immo_prop.idbien IS 'Identifiant du bien';
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
	ityp        character varying (2) ,------------------------------------------------------- Type d''occupation
	libelle     character varying (254),------------------------------------------------------ Libellé du bâtiment
	surf_m      integer,---------------------------------------------------------------------- Surface en m²	
	shon        integer,---------------------------------------------------------------------- Surface de plancher en m²
	hauteur     integer,---------------------------------------------------------------------- Hauteur em mètre
	nbloc       integer,---------------------------------------------------------------------- Nombre de local dans le bâtiment
	bdesc       character varying(100),------------------------------------------------------- Description du bâtiment
	mprop	    boolean default false,-------------------------------------------------------- Même propriétaire que le bâtiment	
	observ      character varying(1000)------------------------------------------------------- Observations
);

ALTER TABLE m_economie.an_immo_bati
  ADD CONSTRAINT an_immo_bati_pkey PRIMARY KEY(idbati);

COMMENT ON TABLE m_economie.an_immo_bati IS 'Table des objets graphiques correspond au bâtiment contenant le bien de type de local';
COMMENT ON COLUMN m_economie.an_immo_bati.idbati IS 'Identifiant du bâtiment';
COMMENT ON COLUMN m_economie.an_immo_bati.idimmo IS 'Identifiant de l''objet';
COMMENT ON COLUMN m_economie.an_immo_bati.ityp IS 'Type d''occupation (incrémentation automatique par la table geo_immo_bien pour la gestion de la liste des domaines des bâtiments pour un type local non identifié)';
COMMENT ON COLUMN m_economie.an_immo_bati.libelle IS 'Libellé du bâtiment';
COMMENT ON COLUMN m_economie.an_immo_bati.surf_m IS 'Surface en m²';
COMMENT ON COLUMN m_economie.an_immo_bati.shon IS 'Surface de plancher en m²';
COMMENT ON COLUMN m_economie.an_immo_bati.hauteur IS 'Hauteur em mètre';
COMMENT ON COLUMN m_economie.an_immo_bati.nbloc IS 'Nombre de local dans le bâtiment';
COMMENT ON COLUMN m_economie.an_immo_bati.bdesc IS 'Description du bâtiment';
COMMENT ON COLUMN m_economie.an_immo_bati.mprop IS 'Même propriétaire que le local';
COMMENT ON COLUMN m_economie.an_immo_bati.observ IS 'Observations';


-- FONCTION : génère l'identifiant idbati avant insertion : permet de gérer le cas d'un ajout direct d'un bâtiment inexistant 
-- comprenant n locaux identifiable (dans liste de valeurs GEO)

-- FUNCTION: m_economie.ft_m_insert_immo_bati()
-- DROP FUNCTION m_economie.ft_m_insert_immo_bati();

CREATE OR REPLACE FUNCTION m_economie.ft_m_insert_immo_bati()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$


DECLARE v_idbati text;


BEGIN

     v_idbati := 'BA' || (SELECT nextval('m_economie.an_immo_bati_seq'::regclass));

	 
     new.ityp := '22'; -- force le type d''occupation à local divisé dans un bâtiment pour gérer l'affichage du bâtiment dans la liste de choix
		       -- à l'enregistrement le bâtiment prendra la valeur définitf de l'occupation de l'objet saisi avec le trigger after

     return new ;

END;

$BODY$;

ALTER FUNCTION m_economie.ft_m_insert_immo_bati()
    OWNER TO sig_create;

GRANT EXECUTE ON FUNCTION m_economie.ft_m_insert_immo_bati() TO edit_sig;

GRANT EXECUTE ON FUNCTION m_economie.ft_m_insert_immo_bati() TO sig_create;

GRANT EXECUTE ON FUNCTION m_economie.ft_m_insert_immo_bati() TO create_sig;

GRANT EXECUTE ON FUNCTION m_economie.ft_m_insert_immo_bati() TO PUBLIC;

COMMENT ON FUNCTION m_economie.ft_m_insert_immo_bati()
    IS 'Fonction gérant l''insertion d''nouvel identifiant du bâtiment (cas d''ajout de valeur depuis GEO)';
	
	
-- Trigger: t_t1_insert_immo_bati

-- DROP TRIGGER t_t1_insert_immo_bati ON m_economie.an_immo_bati;

CREATE TRIGGER t_t1_insert_immo_bati
    BEFORE INSERT
    ON m_economie.an_immo_bati
    FOR EACH ROW
    EXECUTE PROCEDURE m_economie.ft_m_insert_immo_bati();

-- FONCTION : Fonction refraichissant la vue matérialisée an_vmr_immo_ityp pour la mise à jour de l'attribut ityp

-- FUNCTION: m_economie.ft_m_insert_occup_immo_bati()

-- DROP FUNCTION m_economie.ft_m_insert_occup_immo_bati();

CREATE FUNCTION m_economie.ft_m_insert_occup_immo_bati()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$

BEGIN


	 -- je supprime le contenu de la table lk_immo_ityp permettant de mettre à jour l'attribut ityp de la table an_immo_bati
     DELETE FROM m_economie.lk_immo_ityp;
	 -- j'intègre les nouvelles valeurs dans la table pour la mise à jour de la table an_immo_bati déclenchée sur la table lk_immo_ityp après cette insertion
     INSERT INTO m_economie.lk_immo_ityp (id,idimmo, ityp_objet,ityp_bati)
     SELECT 
     	row_number() over() as id,
    	bi.idimmo,
    	bi.ityp AS ityp_objet,
    	ba.ityp AS ityp_bati
   	FROM m_economie.geo_immo_bien bi,
    	m_economie.an_immo_bati ba
  	WHERE bi.idimmo = ba.idimmo AND bi.ityp::text <> '22'::text;


     return new ;

END;

$BODY$;

ALTER FUNCTION m_economie.ft_m_update_immo_bati()
    OWNER TO sig_create;

GRANT EXECUTE ON FUNCTION m_economie.ft_m_update_immo_bati() TO edit_sig;

GRANT EXECUTE ON FUNCTION m_economie.ft_m_update_immo_bati() TO sig_create;

GRANT EXECUTE ON FUNCTION m_economie.ft_m_update_immo_bati() TO create_sig;

GRANT EXECUTE ON FUNCTION m_economie.ft_m_update_immo_bati() TO PUBLIC;

COMMENT ON FUNCTION m_economie.ft_m_update_immo_bati()
    IS 'Fonction refraichissant la vue matérialisée an_vmr_immo_ityp pour la mise à jour de l''attribut ityp';


-- Trigger: t_t2_insert_occup_immo_bati
-- t_t2_insert_occup_immo_bati ON m_economie.an_immo_bati;

CREATE TRIGGER t_t2_insert_occup_immo_bati
    AFTER INSERT 
    ON m_economie.an_immo_bati
    FOR EACH ROW
    EXECUTE PROCEDURE m_economie.ft_m_insert_occup_immo_bati();
					 
-- FONCTION : Fonction permettant de supprimer la ligne null créée après l'insertion d'un bâtiment dans le cas d'un ajout d'un bâtiment avec biens identifiés dans la table an_immo_bati

-- FUNCTION: m_economie.ft_m_delete_immo_bati_null()
-- DROP FUNCTION m_economie.ft_m_delete_immo_bati_null();

CREATE FUNCTION m_economie.ft_m_delete_immo_bati_null()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$

BEGIN

      -- je supprime uniquement pour les locaux divisés d'un même bâtiment, la valeur null qui s'est créée à l'enregistrement du bien saisi
      DELETE FROM m_economie.an_immo_bati WHERE ityp = '22' AND libelle IS NULL;
	  
     return new ;

END;

$BODY$;

ALTER FUNCTION m_economie.ft_m_delete_immo_bati_null()
    OWNER TO sig_create;

GRANT EXECUTE ON FUNCTION m_economie.ft_m_delete_immo_bati_null() TO edit_sig;

GRANT EXECUTE ON FUNCTION m_economie.ft_m_delete_immo_bati_null() TO sig_create;

GRANT EXECUTE ON FUNCTION m_economie.ft_m_delete_immo_bati_null() TO create_sig;

GRANT EXECUTE ON FUNCTION m_economie.ft_m_delete_immo_bati_null() TO PUBLIC;

COMMENT ON FUNCTION m_economie.ft_m_delete_immo_bati_null()
    IS 'Fonction gérant la suppression des bâtiments après insertion d''une occupation de type 22 (bâtiment avec n locaux identifiés)';				 
					 
-- Trigger: t_t3_delete_immo_bati_null
-- DROP TRIGGER t_t3_delete_immo_bati_null ON m_economie.an_immo_bati;

CREATE TRIGGER t_t3_delete_immo_bati_null
    AFTER INSERT
    ON m_economie.an_immo_bati
    FOR EACH ROW
    EXECUTE PROCEDURE m_economie.ft_m_delete_immo_bati_null();

					 

					 
--################################################################# an_immo_comm #######################################################

CREATE TABLE m_economie.an_immo_comm --------------------------------------------- Attribut métier de la commercialisation
	(
	idcomm      text DEFAULT 'C' || nextval('m_economie.an_immo_comm_seq') NOT NULL,---------- Identifiant unique de la commercialisation
	idimmo      text,------------------------------------------------------------------------- Identifiant de l''objet bien
	idbien      text,------------------------------------------------------------------------- Identifiant du bien
	prix_a	    integer,---------------------------------------------------------------------- Prix d'acquisition du bien occupé
	prix_am     integer,---------------------------------------------------------------------- Prix d'acquisition au m² du bien occupé
	loyer_a     integer,---------------------------------------------------------------------- Loyer actuel du bien
	loyer_am    integer,---------------------------------------------------------------------- Loyer actuel du bien au m²
	bail_a	    integer,---------------------------------------------------------------------- Montant du bail actuel du bien
	prix        integer,---------------------------------------------------------------------- Prix total
	prix_m      integer,---------------------------------------------------------------------- Prix au m²
	loyer       integer,---------------------------------------------------------------------- Loyer total
	loyer_m     integer,---------------------------------------------------------------------- Loyer au m²
	bail        integer,---------------------------------------------------------------------- Montant du Bail
	comm        character varying(150),------------------------------------------------------- Nom du commercialisateur
	commtel     character varying(14),-------------------------------------------------------- Téléphone du commercialisateur
	commtelp    character varying(14),-------------------------------------------------------- Téléphone portable du commercialisateur
	commmail    character varying(80),-------------------------------------------------------- Email du commercialisateur
	etat        character varying(2),--------------------------------------------------------- Etat de la commercialisation
	source      character varying(254),------------------------------------------------------- Source
	refext      character varying(254),------------------------------------------------------- Référence externe d'un site internet présentant une fiche de commercialisation
	observ      character varying(1000)------------------------------------------------------- Observations
);

ALTER TABLE m_economie.an_immo_comm
  ADD CONSTRAINT an_immo_comm_pkey PRIMARY KEY(idcomm);

COMMENT ON TABLE m_economie.an_immo_comm IS 'Table des objets graphiques correspond au bâtiment contenant le bien de type de local';
COMMENT ON COLUMN m_economie.an_immo_comm.idcomm IS 'Identifiant unique de la commercialisation';
COMMENT ON COLUMN m_economie.an_immo_comm.idimmo IS 'Identifiant de l''objet bien';
COMMENT ON COLUMN m_economie.an_immo_comm.idbien IS 'Identifiant du bien';
COMMENT ON COLUMN m_economie.an_immo_comm.prix_a IS 'Prix d''acquisition du bien occupé';
COMMENT ON COLUMN m_economie.an_immo_comm.prix_am IS 'Prix d''acquisition au m² du bien occupé';
COMMENT ON COLUMN m_economie.an_immo_comm.loyer_a IS 'Loyer actuel du bien';
COMMENT ON COLUMN m_economie.an_immo_comm.loyer_am IS 'Loyer actuel du bien au m²';
COMMENT ON COLUMN m_economie.an_immo_comm.bail_a IS 'Montant du bail actuel du bien';
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
COMMENT ON COLUMN m_economie.an_immo_comm.refext IS 'Référence externe d''un site internet présentant une fiche de commercialisation';
COMMENT ON COLUMN m_economie.an_immo_comm.observ IS 'Observations';

--################################################################# lk_immo_occup #######################################################

CREATE TABLE m_economie.lk_immo_occup
	(
	id          integer DEFAULT nextval('m_economie.lk_immo_occup_seq') NOT NULL,------------ Identifiant unique de l'occupation
	idbien      text,------------------------------------------------------------------------ Identifiant du bien occupé
	idimmo	    text,------------------------------------------------------------------------ Identifiant de l''objet bien
	siret       character varying(14)-------------------------------------------------------- N° SIRET de l'établissement occupant
	);

ALTER TABLE m_economie.lk_immo_occup
  ADD CONSTRAINT lk_immo_occup_pkey PRIMARY KEY(id);

COMMENT ON TABLE m_economie.lk_immo_occup IS 'Table des objets graphiques correspond au bâtiment contenant le bien de type de local';
COMMENT ON COLUMN m_economie.lk_immo_occup.id IS 'Identifiant unique de l''occupation';
COMMENT ON COLUMN m_economie.lk_immo_occup.idbien IS 'Identifiant du bien occupé';
COMMENT ON COLUMN m_economie.lk_immo_occup.idimmo IS 'Identifiant de l''objet bien';
COMMENT ON COLUMN m_economie.lk_immo_occup.siret IS 'N° SIRET de l''établissement occupant';


--################################################################# an_immo_media #######################################################
					 
					 
-- Table: m_economie.an_immo_media

-- DROP TABLE m_economie.an_immo_media;

CREATE TABLE m_economie.an_immo_media
(
    id text,
    media text,
    miniature bytea,
    n_fichier text,
    t_fichier text,
    op_sai character varying(20),
    date_sai timestamp without time zone,
    l_doc character varying(100),
    gid integer NOT NULL DEFAULT nextval('m_economie.an_immo_media_seq'::regclass),
    CONSTRAINT an_immo_media_pkey PRIMARY KEY (gid)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE m_economie.an_immo_media
    OWNER to sig_create;

GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_economie.an_immo_media TO edit_sig;

GRANT ALL ON TABLE m_economie.an_immo_media TO sig_create;

GRANT ALL ON TABLE m_economie.an_immo_media TO create_sig;

GRANT SELECT ON TABLE m_economie.an_immo_media TO read_sig;

COMMENT ON TABLE m_economie.an_immo_media
    IS 'Table gérant les documents intégrés pour la gestion des données du marché immobilier d''entreprises';

COMMENT ON COLUMN m_economie.an_immo_media.id
    IS 'Identifiant de l''objet saisi';

COMMENT ON COLUMN m_economie.an_immo_media.media
    IS 'Champ Média de GEO';

COMMENT ON COLUMN m_economie.an_immo_media.miniature
    IS 'Champ miniature de GEO';

COMMENT ON COLUMN m_economie.an_immo_media.n_fichier
    IS 'Nom du fichier';

COMMENT ON COLUMN m_economie.an_immo_media.t_fichier
    IS 'Type de média dans GEO';

COMMENT ON COLUMN m_economie.an_immo_media.op_sai
    IS 'Opérateur de saisie (par défaut login de connexion à GEO)';

COMMENT ON COLUMN m_economie.an_immo_media.date_sai
    IS 'Date de la saisie du document';
	COMMENT ON COLUMN m_economie.an_immo_media.l_doc
    IS 'Titre du document ou légère description';

COMMENT ON COLUMN m_economie.an_immo_media.gid
    IS 'Compteur (identifiant interne)';

--################################################################# lk_immo_ityp #######################################################

					 
-- View: m_economie.lk_immo_ityp

CREATE TABLE m_economie.lk_immo_ityp
	(
	id          integer NOT NULL,------------------------------------------------------------ Identifiant unique
	idimmo      text,------------------------------------------------------------------------ Identifiant de l''objet saisi
	ityp_objet  character varying(2),-------------------------------------------------------- Occupation de l''objet saisi
	ityp_bati   character varying(2)--------------------------------------------------------- Occupation du bâti
	);

ALTER TABLE m_economie.lk_immo_ityp
  ADD CONSTRAINT lk_immo_ityp_pkey PRIMARY KEY(id);

ALTER TABLE m_economie.lk_immo_ityp
    OWNER to sig_create;



COMMENT ON TABLE m_economie.lk_immo_ityp
    IS 'Table non géographiques listant les types d''occupation entre la table des objeys saisis et les attributs des bâtiments (exclu des bâtiments avec biens identifiés). Objectif : utiliser cette vue rafraichie après l''insertion d''un bâtiment pour mettre à jour cette même table des bâtis pour gérer la liste des bâtiments (uniquement si locaux identifiés) affichés à l''utilisateur dans GEO pour affecter un bâtiment à un bien identifié. Table incrémenté automatiquement à l''insertion d''une valeur dans la table an_immo_bati';

COMMENT ON COLUMN m_economie.lk_immo_ityp.id
    IS 'Identifiant unique';

COMMENT ON COLUMN m_economie.an_vlk_immo_itypmr_immo_ityp.idimmo
    IS 'Identifiant de l''objet saisi';

COMMENT ON COLUMN m_economie.lk_immo_ityp.ityp_objet
    IS 'Occupation de l''objet saisi';

COMMENT ON COLUMN m_economie.lk_immo_ityp.ityp_bati
    IS 'Occupation du bâti';
					 
COMMENT ON TABLE m_economie.lk_immo_ityp
    IS 'Table non géographiques listant les types d''occupation entre la table des objeys saisis et les attributs des bâtiments (exclu des bâtiments avec biens identifiés). Objectif : utiliser cette vue rafraichie après l''insertion d''un bâtiment pour mettre à jour cette même table des bâtis pour gérer la liste des bâtiments (uniquement si locaux identifiés) affichés à l''utilisateur dans GEO pour affecter un bâtiment à un bien identifié. Table incrémenté automatiquement à l''insertion d''une valeur dans la table an_immo_bati';

					 
-- FONCTION : Fonction permettant de mettre à jour l''attribut ityp dans la table an_immo_bati

-- FUNCTION: m_economie.ft_m_delete_immo_ityp()
-- DROP FUNCTION m_economie.ft_m_delete_immo_ityp();
					 
CREATE FUNCTION m_economie.ft_m_insert_immo_ityp()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$

BEGIN

     -- mise à jour de l'attribut ityp dans la table an_immo_bati (permet de filtrer correctement ityp = '22' dans la liste des bâtiments avec locaux identifiés dans GEO)
     UPDATE m_economie.an_immo_bati SET ityp = lk_immo_ityp.ityp_objet FROM m_economie.lk_immo_ityp WHERE lk_immo_ityp.idimmo = an_immo_bati.idimmo ;  

     return new ;

END;

$BODY$;

ALTER FUNCTION m_economie.ft_m_insert_immo_ityp()
    OWNER TO sig_create;

GRANT EXECUTE ON FUNCTION m_economie.ft_m_insert_immo_ityp() TO edit_sig;

GRANT EXECUTE ON FUNCTION m_economie.ft_m_insert_immo_ityp() TO sig_create;

GRANT EXECUTE ON FUNCTION m_economie.ft_m_insert_immo_ityp() TO create_sig;

GRANT EXECUTE ON FUNCTION m_economie.ft_m_insert_immo_ityp() TO PUBLIC;

COMMENT ON FUNCTION m_economie.ft_m_insert_immo_ityp()
    IS 'Fonction permettant de mettre à jour l''attribut ityp dans la table an_immo_bati via cette table de lien incrémentée après insertion dans cette même table an_immo_bati';


-- DROP TRIGGER t_t1_insert_immo_ityp ON m_economie.lk_immo_ityp;
CREATE TRIGGER t_t1_insert_immo_ityp
    AFTER INSERT
    ON m_economie.lk_immo_ityp
    FOR EACH ROW
    EXECUTE PROCEDURE m_economie.ft_m_insert_immo_ityp();
					 
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
