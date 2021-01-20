                                                                          
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

-- VUE

DROP VIEW IF EXISTS x_apps.xapps_an_vmr_immo_bati;
DROP VIEW IF EXISTS an_v_immo_bien_locnonident;
DROP VIEW IF EXISTS geo_v_immo_bien_locident;
DROP VIEW IF EXISTS geo_v_immo_bien_locnonident;
DROP VIEW IF EXISTS geo_v_immo_bien_locunique;
DROP VIEW IF EXISTS geo_v_immo_bien_terrain;

-- CLASSES

DROP TABLE IF EXISTS m_economie.geo_immo_bien;
DROP TABLE IF EXISTS m_economie.an_immo_bien;
DROP TABLE IF EXISTS m_economie.an_immo_bati;
DROP TABLE IF EXISTS m_economie.an_immo_propbati;
DROP TABLE IF EXISTS m_economie.an_immo_propbien;
DROP TABLE IF EXISTS m_economie.an_immo_comm;
DROP TABLE IF EXISTS m_economie.an_immo_media ;
DROP TABLE IF EXISTS m_economie.lk_immo_occup;



-- DOMAINES DE VALEUR

DROP TABLE IF EXISTS m_economie.lt_immo_ityp CASCADE;
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

-- Table: m_economie.geo_immo_bien

-- DROP TABLE m_economie.geo_immo_bien;

CREATE TABLE m_economie.geo_immo_bien
(
    idimmo text COLLATE pg_catalog."default" NOT NULL,
    idbati text COLLATE pg_catalog."default",
    idsite character varying(7) COLLATE pg_catalog."default",
    sup_m2 integer,
    ityp character varying(2) COLLATE pg_catalog."default",
    observ character varying(1000) COLLATE pg_catalog."default",
    op_sai character varying(25) COLLATE pg_catalog."default",
    date_sai timestamp without time zone DEFAULT now(),
    date_maj timestamp without time zone,
    src_geom character varying(2) COLLATE pg_catalog."default" NOT NULL DEFAULT '00'::character varying,
    src_date integer,
    insee character varying(25) COLLATE pg_catalog."default",
    commune character varying(160) COLLATE pg_catalog."default",
    geom geometry(MultiPolygon,2154),
    CONSTRAINT geo_immo_bien_pkey PRIMARY KEY (idimmo),
    CONSTRAINT geo_immo_bien_geom_fkey FOREIGN KEY (src_geom)
        REFERENCES r_objet.lt_src_geom (code) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE SET DEFAULT,
    CONSTRAINT geo_immo_bien_ityp_fkey FOREIGN KEY (ityp)
        REFERENCES m_economie.lt_immo_ityp (code) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE SET DEFAULT
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;


COMMENT ON TABLE m_economie.geo_immo_bien
    IS 'Table des objets graphiques correspond à la primitive des biens immobiliers';

COMMENT ON COLUMN m_economie.geo_immo_bien.idimmo
    IS 'Identifiant unique de l''objet';

COMMENT ON COLUMN m_economie.geo_immo_bien.idbati
    IS 'Identifiant unique bu bâtiment';

COMMENT ON COLUMN m_economie.geo_immo_bien.idsite
    IS 'Identifiant du site d''activité d''appartenance';

COMMENT ON COLUMN m_economie.geo_immo_bien.sup_m2
    IS 'Superficie de l''objet en m²';

COMMENT ON COLUMN m_economie.geo_immo_bien.ityp
    IS 'Type d''occupation';

COMMENT ON COLUMN m_economie.geo_immo_bien.observ
    IS 'Observations';

COMMENT ON COLUMN m_economie.geo_immo_bien.op_sai
    IS 'Opérateur de saisie';

COMMENT ON COLUMN m_economie.geo_immo_bien.date_sai
    IS 'Date de saisie';

COMMENT ON COLUMN m_economie.geo_immo_bien.date_maj
    IS 'Date de mise à jour';

COMMENT ON COLUMN m_economie.geo_immo_bien.src_geom
    IS 'Source du référentiel géographique pour le positionnement du nœud';

COMMENT ON COLUMN m_economie.geo_immo_bien.src_date
    IS 'Année du référentiel de saisi';

COMMENT ON COLUMN m_economie.geo_immo_bien.insee
    IS 'Code Insee de la ou des communes d''assises';

COMMENT ON COLUMN m_economie.geo_immo_bien.commune
    IS 'Libellé de la ou des communes d''assises';

COMMENT ON COLUMN m_economie.geo_immo_bien.geom
    IS 'Attribut de géométrie';
-- Index: idx_geo_immo_bien_idbati

-- DROP INDEX m_economie.idx_geo_immo_bien_idbati;

CREATE INDEX idx_geo_immo_bien_idbati
    ON m_economie.geo_immo_bien USING btree
    (idbati COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;


--################################################################# an_immo_bien #######################################################

-- Table: m_economie.an_immo_bien

-- DROP TABLE m_economie.an_immo_bien;

CREATE TABLE m_economie.an_immo_bien
(
    idbien text COLLATE pg_catalog."default" NOT NULL,
    idimmo text COLLATE pg_catalog."default",
    tbien character varying(4) COLLATE pg_catalog."default",
    libelle character varying(254) COLLATE pg_catalog."default",
    pdp boolean DEFAULT false,
    lib_occup character varying(150) COLLATE pg_catalog."default",
    bal integer,
    adr character varying(254) COLLATE pg_catalog."default",
    adrcomp character varying(100) COLLATE pg_catalog."default",
    surf_p integer,
    source character varying(254) COLLATE pg_catalog."default",
    refext character varying(254) COLLATE pg_catalog."default",
    observ character varying(1000) COLLATE pg_catalog."default",
    surf_rdc integer DEFAULT 0,
    surf_etag integer DEFAULT 0,
    surf_mezza integer DEFAULT 0,
    surf_acti integer DEFAULT 0,
    surf_bur integer DEFAULT 0,
    CONSTRAINT an_immo_bien_pkey PRIMARY KEY (idbien),
    CONSTRAINT an_immo_bien_tbien_fkey FOREIGN KEY (tbien)
        REFERENCES m_economie.lt_immo_tbien (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

COMMENT ON TABLE m_economie.an_immo_bien
    IS 'Table alphanumérique contenant les informations des biens immobiliers ou locaux';

COMMENT ON COLUMN m_economie.an_immo_bien.idbien
    IS 'Identifiant unique du bien';

COMMENT ON COLUMN m_economie.an_immo_bien.idimmo
    IS 'Identifiant unique de l''objet bien';

COMMENT ON COLUMN m_economie.an_immo_bien.tbien
    IS 'Type de bien';

COMMENT ON COLUMN m_economie.an_immo_bien.libelle
    IS 'Libellé du bien';

COMMENT ON COLUMN m_economie.an_immo_bien.pdp
    IS 'Bien en pas-de-porte';

COMMENT ON COLUMN m_economie.an_immo_bien.lib_occup
    IS 'Libellé de l''occupant ou détail sur le type d''occupation (si pas un établissement lié)';

COMMENT ON COLUMN m_economie.an_immo_bien.bal
    IS 'Identifiant de la base adresse';

COMMENT ON COLUMN m_economie.an_immo_bien.adr
    IS 'Adresse litérale (si différente de la BAL)';

COMMENT ON COLUMN m_economie.an_immo_bien.adrcomp
    IS 'Complément d''adresse';

COMMENT ON COLUMN m_economie.an_immo_bien.surf_p
    IS 'Surface totale de plancher totale en m²';

COMMENT ON COLUMN m_economie.an_immo_bien.source
    IS 'Source de la mise à jour';

COMMENT ON COLUMN m_economie.an_immo_bien.refext
    IS 'Lien vers un site présentant le terrain';

COMMENT ON COLUMN m_economie.an_immo_bien.observ
    IS 'Observations';

COMMENT ON COLUMN m_economie.an_immo_bien.surf_rdc
    IS 'Surface en rez-de-chaussée';

COMMENT ON COLUMN m_economie.an_immo_bien.surf_etag
    IS 'Surface à l''étage';

COMMENT ON COLUMN m_economie.an_immo_bien.surf_mezza
    IS 'Surface en mezzanine';

COMMENT ON COLUMN m_economie.an_immo_bien.surf_acti
    IS 'Surface  en activité (atelier)';

COMMENT ON COLUMN m_economie.an_immo_bien.surf_bur
    IS 'Surface en bureau';
-- Index: fki_an_immo_bien_tbien_fkey

-- DROP INDEX m_economie.fki_an_immo_bien_tbien_fkey;

CREATE INDEX fki_an_immo_bien_tbien_fkey
    ON m_economie.an_immo_bien USING btree
    (tbien COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_an_immo_bien_idimmo

-- DROP INDEX m_economie.idx_an_immo_bien_idimmo;

CREATE INDEX idx_an_immo_bien_idimmo
    ON m_economie.an_immo_bien USING btree
    (idimmo COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;



--################################################################# an_immo_propbati #######################################################

-- Table: m_economie.an_immo_propbati

-- DROP TABLE m_economie.an_immo_propbati;

CREATE TABLE m_economie.an_immo_propbati
(
    idprop text COLLATE pg_catalog."default" NOT NULL,
    idbati text COLLATE pg_catalog."default",
    propnom character varying(100) COLLATE pg_catalog."default",
    proptel character varying(14) COLLATE pg_catalog."default",
    proptelp character varying(14) COLLATE pg_catalog."default",
    propmail character varying(80) COLLATE pg_catalog."default",
    observ character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT an_immo_prop_pkey PRIMARY KEY (idprop)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;


COMMENT ON TABLE m_economie.an_immo_propbati
    IS 'Table alphanumérique des propriétaires bâtis';

COMMENT ON COLUMN m_economie.an_immo_propbati.idprop
    IS 'Identifiant du propriétaire';

COMMENT ON COLUMN m_economie.an_immo_propbati.idbati
    IS 'Identifiant du bâtiment';

COMMENT ON COLUMN m_economie.an_immo_propbati.propnom
    IS 'Nom du propriétaire';

COMMENT ON COLUMN m_economie.an_immo_propbati.proptel
    IS 'Téléphone du propriétaire';

COMMENT ON COLUMN m_economie.an_immo_propbati.proptelp
    IS 'Téléphone portable du propriétaire';

COMMENT ON COLUMN m_economie.an_immo_propbati.propmail
    IS 'Email du propriétaire';

COMMENT ON COLUMN m_economie.an_immo_propbati.observ
    IS 'Observations';
-- Index: idx_an_immo_prop_idbati

-- DROP INDEX m_economie.idx_an_immo_prop_idbati;

CREATE INDEX idx_an_immo_prop_idbati
    ON m_economie.an_immo_propbati USING btree
    (idbati COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

--################################################################# an_immo_propbien #######################################################

-- Table: m_economie.an_immo_propbien

-- DROP TABLE m_economie.an_immo_propbien;

CREATE TABLE m_economie.an_immo_propbien
(
    idprop text COLLATE pg_catalog."default" NOT NULL,
    idbien text COLLATE pg_catalog."default",
    propnom character varying(100) COLLATE pg_catalog."default",
    proptel character varying(14) COLLATE pg_catalog."default",
    proptelp character varying(14) COLLATE pg_catalog."default",
    propmail character varying(80) COLLATE pg_catalog."default",
    observ character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT n_immo_propbien_pkey PRIMARY KEY (idprop)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;


COMMENT ON TABLE m_economie.an_immo_propbien
    IS 'Table alphanumérique des propriétaires des biens immobiliers ou locaux';

COMMENT ON COLUMN m_economie.an_immo_propbien.idprop
    IS 'Identifiant du propriétaire';

COMMENT ON COLUMN m_economie.an_immo_propbien.idbien
    IS 'Identifiant du bien immobilier ou local';

COMMENT ON COLUMN m_economie.an_immo_propbien.propnom
    IS 'Nom du propriétaire';

COMMENT ON COLUMN m_economie.an_immo_propbien.proptel
    IS 'Téléphone du propriétaire';

COMMENT ON COLUMN m_economie.an_immo_propbien.proptelp
    IS 'Téléphone portable du propriétaire';

COMMENT ON COLUMN m_economie.an_immo_propbien.propmail
    IS 'Email du propriétaire';

COMMENT ON COLUMN m_economie.an_immo_propbien.observ
    IS 'Observations';

--################################################################# an_immo_bati #######################################################

-- Table: m_economie.an_immo_bati

-- DROP TABLE m_economie.an_immo_bati;

CREATE TABLE m_economie.an_immo_bati
(
    idbati text COLLATE pg_catalog."default" NOT NULL,
    idimmo text COLLATE pg_catalog."default",
    ityp character varying(2) COLLATE pg_catalog."default",
    libelle character varying(254) COLLATE pg_catalog."default",
    surf_p integer,
    mprop boolean DEFAULT false,
    observ character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT an_immo_bati_pkey PRIMARY KEY (idbati),
    CONSTRAINT an_immo_bati_ityp_fkey FOREIGN KEY (ityp)
        REFERENCES m_economie.lt_immo_ityp (code) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;


COMMENT ON TABLE m_economie.an_immo_bati
    IS 'Table alphanumérique contenant les informations aux bâtiments';

COMMENT ON COLUMN m_economie.an_immo_bati.idbati
    IS 'Identifiant du bâtiment';

COMMENT ON COLUMN m_economie.an_immo_bati.idimmo
    IS 'Identifiant de l''objet';

COMMENT ON COLUMN m_economie.an_immo_bati.ityp
    IS 'Type d''occupation (incrémentation automatique par la table geo_immo_bien pour la gestion de la liste des domaines des bâtiments pour un type local non identifié)';

COMMENT ON COLUMN m_economie.an_immo_bati.libelle
    IS 'Libellé du bâtiment';

COMMENT ON COLUMN m_economie.an_immo_bati.surf_p
    IS 'Surface de plancher total du bâtiment renseigné par l''utilisateur';

COMMENT ON COLUMN m_economie.an_immo_bati.mprop
    IS 'Type de propriétaire (unique ou en copropriété). La valeur true indique qu''il s''agit d''une copropriété';

COMMENT ON COLUMN m_economie.an_immo_bati.observ
    IS 'Observations';
-- Index: fki_an_immo_bati_ityp_fkey

-- DROP INDEX m_economie.fki_an_immo_bati_ityp_fkey;

CREATE INDEX fki_an_immo_bati_ityp_fkey
    ON m_economie.an_immo_bati USING btree
    (ityp COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_an_immo_bati_idimmo

-- DROP INDEX m_economie.idx_an_immo_bati_idimmo;

CREATE INDEX idx_an_immo_bati_idimmo
    ON m_economie.an_immo_bati USING btree
    (idimmo COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

-- Trigger: t_t1_insert_immo_bati

-- DROP TRIGGER t_t1_insert_immo_bati ON m_economie.an_immo_bati;

CREATE TRIGGER t_t1_insert_immo_bati
    BEFORE INSERT
    ON m_economie.an_immo_bati
    FOR EACH ROW
    EXECUTE PROCEDURE m_economie.ft_m_gestion_immo_insertbati();


					 
--################################################################# an_immo_comm #######################################################

-- Table: m_economie.an_immo_comm

-- DROP TABLE m_economie.an_immo_comm;

CREATE TABLE m_economie.an_immo_comm
(
    idcomm text COLLATE pg_catalog."default" NOT NULL,
    idimmo text COLLATE pg_catalog."default",
    idbien text COLLATE pg_catalog."default",
    prix_a integer,
    prix_am integer,
    loyer_a integer,
    loyer_am integer,
    bail_a integer,
    prix integer,
    prix_m integer,
    loyer integer,
    loyer_m integer,
    bail integer,
    comm character varying(150) COLLATE pg_catalog."default",
    commtel character varying(14) COLLATE pg_catalog."default",
    commtelp character varying(14) COLLATE pg_catalog."default",
    commmail character varying(80) COLLATE pg_catalog."default",
    etat character varying(2) COLLATE pg_catalog."default",
    refext character varying(254) COLLATE pg_catalog."default",
    observ character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT an_immo_comm_pkey PRIMARY KEY (idcomm),
    CONSTRAINT an_immo_comm_etat_fkey FOREIGN KEY (etat)
        REFERENCES m_economie.lt_immo_etat (code) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE SET DEFAULT
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

COMMENT ON TABLE m_economie.an_immo_comm
    IS 'Table alphanumérique contenant les informations sur la commercialisation des biens immobiliers ou locaux';

COMMENT ON COLUMN m_economie.an_immo_comm.idcomm
    IS 'Identifiant unique de la commercialisation';

COMMENT ON COLUMN m_economie.an_immo_comm.idimmo
    IS 'Identifiant de l''objet bien';

COMMENT ON COLUMN m_economie.an_immo_comm.idbien
    IS 'Identifiant du bien';

COMMENT ON COLUMN m_economie.an_immo_comm.prix_a
    IS 'Prix d''acquisition du bien occupé';

COMMENT ON COLUMN m_economie.an_immo_comm.prix_am
    IS 'Prix d''acquisition au m² du bien occupé';

COMMENT ON COLUMN m_economie.an_immo_comm.loyer_a
    IS 'Loyer actuel du bien';

COMMENT ON COLUMN m_economie.an_immo_comm.loyer_am
    IS 'Loyer actuel du bien au m²';

COMMENT ON COLUMN m_economie.an_immo_comm.bail_a
    IS 'Montant du bail actuel du bien';

COMMENT ON COLUMN m_economie.an_immo_comm.prix
    IS 'Prix total';

COMMENT ON COLUMN m_economie.an_immo_comm.prix_m
    IS 'Prix au m²';

COMMENT ON COLUMN m_economie.an_immo_comm.loyer
    IS 'Loyer total';

COMMENT ON COLUMN m_economie.an_immo_comm.loyer_m
    IS 'Loyer au m²';

COMMENT ON COLUMN m_economie.an_immo_comm.bail
    IS 'Montant du Bail';

COMMENT ON COLUMN m_economie.an_immo_comm.comm
    IS 'Nom du commercialisateur';

COMMENT ON COLUMN m_economie.an_immo_comm.commtel
    IS 'Téléphone du commercialisateur';

COMMENT ON COLUMN m_economie.an_immo_comm.commtelp
    IS 'Téléphone portable du commercialisateur';

COMMENT ON COLUMN m_economie.an_immo_comm.commmail
    IS 'Email du commercialisateur';

COMMENT ON COLUMN m_economie.an_immo_comm.etat
    IS 'Etat de la commercialisation';

COMMENT ON COLUMN m_economie.an_immo_comm.refext
    IS 'Référence externe d''un site internet présentant une fiche de commercialisation';

COMMENT ON COLUMN m_economie.an_immo_comm.observ
    IS 'Observations';

--################################################################# lk_immo_occup #######################################################

-- Table: m_economie.lk_immo_occup

-- DROP TABLE m_economie.lk_immo_occup;

CREATE TABLE m_economie.lk_immo_occup
(
    id integer NOT NULL DEFAULT nextval('m_economie.lk_immo_occup_seq'::regclass),
    idbien text COLLATE pg_catalog."default",
    siret character varying(14) COLLATE pg_catalog."default",
    CONSTRAINT lk_immo_occup_pkey PRIMARY KEY (id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

COMMENT ON TABLE m_economie.lk_immo_occup
    IS 'Table des objets graphiques correspond au bâtiment contenant le bien de type de local';

COMMENT ON COLUMN m_economie.lk_immo_occup.id
    IS 'Identifiant unique de l''occupation';

COMMENT ON COLUMN m_economie.lk_immo_occup.idbien
    IS 'Identifiant du bien occupé';

COMMENT ON COLUMN m_economie.lk_immo_occup.siret
    IS 'N° SIRET de l''établissement occupant';
-- Index: idx_lk_immo_occup_idbien

-- DROP INDEX m_economie.idx_lk_immo_occup_idbien;

CREATE INDEX idx_lk_immo_occup_idbien
    ON m_economie.lk_immo_occup USING btree
    (idbien COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_lk_immo_occup_siret

-- DROP INDEX m_economie.idx_lk_immo_occup_siret;

CREATE INDEX idx_lk_immo_occup_siret
    ON m_economie.lk_immo_occup USING btree
    (siret COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;


--################################################################# an_immo_media #######################################################
					 
					 
-- Table: m_economie.an_immo_media

-- DROP TABLE m_economie.an_immo_media;

CREATE TABLE m_economie.an_immo_media
(
    id text COLLATE pg_catalog."default",
    media text COLLATE pg_catalog."default",
    miniature bytea,
    n_fichier text COLLATE pg_catalog."default",
    t_fichier text COLLATE pg_catalog."default",
    op_sai character varying(20) COLLATE pg_catalog."default",
    date_sai timestamp without time zone,
    l_doc character varying(100) COLLATE pg_catalog."default",
    gid integer NOT NULL DEFAULT nextval('m_economie.an_immo_media_seq'::regclass),
    CONSTRAINT an_immo_media_pkey PRIMARY KEY (gid)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

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
-- Index: idx_an_immo_media_id

-- DROP INDEX m_economie.idx_an_immo_media_id;

CREATE INDEX idx_an_immo_media_id
    ON m_economie.an_immo_media USING btree
    (id COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

