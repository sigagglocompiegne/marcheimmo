/*ECL V1.0*/
/*Creation droits sur l'ensemble des objets */
/*IMMO_99_GRANT.sql */
/*PostGIS*/
/*GeoCompiegnois - http://geo.compiegnois.fr/ */
/*Auteur : Grégory Bodet */

-- ####################################################################################################################################################
-- ###                                                                                                                                              ###
-- ###                                                                        GRANT                                                                  ###
-- ###                                                                                                                                              ###
-- ####################################################################################################################################################


-- #################################################################### SEQUENCE  ####################################################################

ALTER SEQUENCE m_economie.geo_immo_bien_seq
    OWNER TO sig_create;
    
ALTER SEQUENCE m_economie.lk_immo_occup_seq
    OWNER TO sig_create;
    
ALTER SEQUENCE m_economie.an_immo_bati_seq
    OWNER TO sig_create;

ALTER SEQUENCE m_economie.an_immo_bien_seq
    OWNER TO sig_create;
    
ALTER SEQUENCE m_economie.an_immo_comm_seq
    OWNER TO sig_create;
    
ALTER SEQUENCE m_economie.an_immo_media_seq
    OWNER TO sig_create;
    
ALTER SEQUENCE m_economie.an_immo_prop_seq
    OWNER TO sig_create;
    
-- #################################################################### DOMAINE DE VALEUR  ####################################################################

ALTER TABLE m_economie.lt_immo_ityp
  OWNER TO sig_create;
GRANT ALL ON TABLE m_economie.lt_immo_ityp TO sig_create;
GRANT ALL ON TABLE m_economie.lt_immo_ityp TO create_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_economie.lt_immo_ityp TO edit_sig;
GRANT SELECT ON TABLE m_economie.lt_immo_ityp TO read_sig;

ALTER TABLE m_economie.lt_immo_tbien
  OWNER TO sig_create;
GRANT ALL ON TABLE m_economie.lt_immo_tbien TO sig_create;
GRANT ALL ON TABLE m_economie.lt_immo_tbien TO create_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_economie.lt_immo_tbien TO edit_sig;
GRANT SELECT ON TABLE m_economie.lt_immo_tbien TO read_sig;

ALTER TABLE m_economie.lt_immo_etat
  OWNER TO sig_create;
GRANT ALL ON TABLE m_economie.lt_immo_etat TO sig_create;
GRANT ALL ON TABLE m_economie.lt_immo_etat TO create_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_economie.lt_immo_etat TO edit_sig;
GRANT SELECT ON TABLE m_economie.lt_immo_etat TO read_sig;

-- #################################################################### TABLE  ####################################################################

ALTER TABLE m_economie.geo_immo_bien
  OWNER TO sig_create;
GRANT ALL ON TABLE m_economie.geo_immo_bien TO sig_create;
GRANT ALL ON TABLE m_economie.geo_immo_bien TO create_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_economie.geo_immo_bien TO edit_sig;
GRANT SELECT ON TABLE m_economie.geo_immo_bien TO read_sig;

ALTER TABLE m_economie.an_immo_bien
  OWNER TO sig_create;
GRANT ALL ON TABLE m_economie.an_immo_bien TO sig_create;
GRANT ALL ON TABLE m_economie.an_immo_bien TO create_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_economie.an_immo_bien TO edit_sig;
GRANT SELECT ON TABLE m_economie.an_immo_bien TO read_sig;

ALTER TABLE m_economie.an_immo_bati
  OWNER TO sig_create;
GRANT ALL ON TABLE m_economie.an_immo_bati TO sig_create;
GRANT ALL ON TABLE m_economie.an_immo_bati TO create_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_economie.an_immo_bati TO edit_sig;
GRANT SELECT ON TABLE m_economie.an_immo_bati TO read_sig;

ALTER TABLE m_economie.an_immo_comm
  OWNER TO sig_create;
GRANT ALL ON TABLE m_economie.an_immo_comm TO sig_create;
GRANT ALL ON TABLE m_economie.an_immo_comm TO create_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_economie.an_immo_comm TO edit_sig;
GRANT SELECT ON TABLE m_economie.an_immo_comm TO read_sig;

ALTER TABLE m_economie.an_immo_propbati
  OWNER TO sig_create;
GRANT ALL ON TABLE m_economie.an_immo_propbati TO sig_create;
GRANT ALL ON TABLE m_economie.an_immo_propbati TO create_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_economie.an_immo_propbati TO edit_sig;
GRANT SELECT ON TABLE m_economie.an_immo_propbati TO read_sig;

ALTER TABLE m_economie.an_immo_propbien
  OWNER TO sig_create;
GRANT ALL ON TABLE m_economie.an_immo_propbien TO sig_create;
GRANT ALL ON TABLE m_economie.an_immo_propbien TO create_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_economie.an_immo_propbien TO edit_sig;
GRANT SELECT ON TABLE m_economie.an_immo_propbien TO read_sig;

ALTER TABLE m_economie.an_immo_media
OWNER TO sig_create;
GRANT ALL ON TABLE m_economie.an_immo_media TO sig_create;
GRANT ALL ON TABLE m_economie.an_immo_media TO create_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_economie.an_immo_media TO edit_sig;
GRANT SELECT ON TABLE m_economie.an_immo_media TO read_sig;

ALTER TABLE m_economie.lk_immo_occup
  OWNER TO sig_create;
GRANT ALL ON TABLE m_economie.lk_immo_occup TO sig_create;
GRANT ALL ON TABLE m_economie.lk_immo_occup TO create_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_economie.lk_immo_occup TO edit_sig;
GRANT SELECT ON TABLE m_economie.lk_immo_occup TO read_sig;


-- ########################################################### FONCTION  ####################################################################

ALTER FUNCTION m_economie.ft_m_gestion_immo_insertbati()
    OWNER TO sig_create;

GRANT EXECUTE ON FUNCTION m_economie.ft_m_gestion_immo_insertbati() TO PUBLIC;
GRANT EXECUTE ON FUNCTION m_economie.ft_m_gestion_immo_insertbati() TO sig_create;
GRANT EXECUTE ON FUNCTION m_economie.ft_m_gestion_immo_insertbati() TO edit_sig;
GRANT EXECUTE ON FUNCTION m_economie.ft_m_gestion_immo_insertbati() TO create_sig;

ALTER FUNCTION m_economie.ft_m_gestion_immo_statbati()
    OWNER TO sig_create;

GRANT EXECUTE ON FUNCTION m_economie.ft_m_gestion_immo_statbati() TO PUBLIC;
GRANT EXECUTE ON FUNCTION m_economie.ft_m_gestion_immo_statbati() TO sig_create;
GRANT EXECUTE ON FUNCTION m_economie.ft_m_gestion_immo_statbati() TO edit_sig;
GRANT EXECUTE ON FUNCTION m_economie.ft_m_gestion_immo_statbati() TO create_sig;

ALTER FUNCTION m_economie.ft_m_gestion_immolocident()
    OWNER TO sig_create;

GRANT EXECUTE ON FUNCTION m_economie.ft_m_gestion_immolocident() TO PUBLIC;
GRANT EXECUTE ON FUNCTION m_economie.ft_m_gestion_immolocident() TO sig_create;
GRANT EXECUTE ON FUNCTION m_economie.ft_m_gestion_immolocident() TO create_sig;
GRANT EXECUTE ON FUNCTION m_economie.ft_m_gestion_immolocident() TO edit_sig;

ALTER FUNCTION m_economie.ft_m_gestion_immolocnonident()
    OWNER TO sig_create;

GRANT EXECUTE ON FUNCTION m_economie.ft_m_gestion_immolocnonident() TO PUBLIC;
GRANT EXECUTE ON FUNCTION m_economie.ft_m_gestion_immolocnonident() TO sig_create;
GRANT EXECUTE ON FUNCTION m_economie.ft_m_gestion_immolocnonident() TO create_sig;
GRANT EXECUTE ON FUNCTION m_economie.ft_m_gestion_immolocnonident() TO edit_sig;

ALTER FUNCTION m_economie.ft_m_gestion_immolocnonident_bien()
    OWNER TO sig_create;

GRANT EXECUTE ON FUNCTION m_economie.ft_m_gestion_immolocnonident_bien() TO PUBLIC;
GRANT EXECUTE ON FUNCTION m_economie.ft_m_gestion_immolocnonident_bien() TO sig_create;
GRANT EXECUTE ON FUNCTION m_economie.ft_m_gestion_immolocnonident_bien() TO create_sig;
GRANT EXECUTE ON FUNCTION m_economie.ft_m_gestion_immolocnonident_bien() TO edit_sig;

ALTER FUNCTION m_economie.ft_m_gestion_immolocunique()
    OWNER TO sig_create;

GRANT EXECUTE ON FUNCTION m_economie.ft_m_gestion_immolocunique() TO PUBLIC;
GRANT EXECUTE ON FUNCTION m_economie.ft_m_gestion_immolocunique() TO sig_create;
GRANT EXECUTE ON FUNCTION m_economie.ft_m_gestion_immolocunique() TO create_sig;
GRANT EXECUTE ON FUNCTION m_economie.ft_m_gestion_immolocunique() TO edit_sig;

ALTER FUNCTION m_economie.ft_m_gestion_immoterrain()
    OWNER TO sig_create;

GRANT EXECUTE ON FUNCTION m_economie.ft_m_gestion_immoterrain() TO PUBLIC;
GRANT EXECUTE ON FUNCTION m_economie.ft_m_gestion_immoterrain() TO sig_create;
GRANT EXECUTE ON FUNCTION m_economie.ft_m_gestion_immoterrain() TO create_sig;
GRANT EXECUTE ON FUNCTION m_economie.ft_m_gestion_immoterrain() TO edit_sig;


-- ########################################################### VUE DE GESTION  ####################################################################

ALTER TABLE m_economie.an_v_immo_bien_locnonident
    OWNER TO sig_create;

GRANT ALL ON TABLE m_economie.an_v_immo_bien_locnonident TO sig_create;
GRANT SELECT ON TABLE m_economie.an_v_immo_bien_locnonident TO read_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_economie.an_v_immo_bien_locnonident TO edit_sig;
GRANT ALL ON TABLE m_economie.an_v_immo_bien_locnonident TO create_sig;


ALTER TABLE m_economie.geo_v_immo_bien_locident
    OWNER TO sig_create;

GRANT ALL ON TABLE m_economie.geo_v_immo_bien_locident TO sig_create;
GRANT SELECT ON TABLE m_economie.geo_v_immo_bien_locident TO read_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_economie.geo_v_immo_bien_locident TO edit_sig;
GRANT ALL ON TABLE m_economie.geo_v_immo_bien_locident TO create_sig;

ALTER TABLE m_economie.geo_v_immo_bien_locnonident
    OWNER TO sig_create;

GRANT ALL ON TABLE m_economie.geo_v_immo_bien_locnonident TO sig_create;
GRANT SELECT ON TABLE m_economie.geo_v_immo_bien_locnonident TO read_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_economie.geo_v_immo_bien_locnonident TO edit_sig;
GRANT ALL ON TABLE m_economie.geo_v_immo_bien_locnonident TO create_sig;


ALTER TABLE m_economie.geo_v_immo_bien_locunique
    OWNER TO sig_create;

GRANT ALL ON TABLE m_economie.geo_v_immo_bien_locunique TO sig_create;
GRANT SELECT ON TABLE m_economie.geo_v_immo_bien_locunique TO read_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_economie.geo_v_immo_bien_locunique TO edit_sig;
GRANT ALL ON TABLE m_economie.geo_v_immo_bien_locunique TO create_sig;

ALTER TABLE m_economie.geo_v_immo_bien_terrain
    OWNER TO sig_create;

GRANT ALL ON TABLE m_economie.geo_v_immo_bien_terrain TO sig_create;
GRANT SELECT ON TABLE m_economie.geo_v_immo_bien_terrain TO read_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE m_economie.geo_v_immo_bien_terrain TO edit_sig;
GRANT ALL ON TABLE m_economie.geo_v_immo_bien_terrain TO create_sig;

-- ########################################################### VUE APPLICATIVE ####################################################################

ALTER TABLE x_apps.xapps_geo_v_immo_bati
    OWNER TO sig_create;

GRANT ALL ON TABLE x_apps.xapps_geo_v_immo_bati TO sig_create;
GRANT SELECT ON TABLE x_apps.xapps_geo_v_immo_bati TO read_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE x_apps.xapps_geo_v_immo_bati TO edit_sig;
GRANT ALL ON TABLE x_apps.xapps_geo_v_immo_bati TO create_sig;

ALTER TABLE x_apps.xapps_geo_v_immo_etat
    OWNER TO sig_create;

GRANT ALL ON TABLE x_apps.xapps_geo_v_immo_etat TO sig_create;
GRANT SELECT ON TABLE x_apps.xapps_geo_v_immo_etat TO read_sig;
GRANT SELECT ON TABLE x_apps.xapps_geo_v_immo_etat TO edit_sig;
GRANT ALL ON TABLE x_apps.xapps_geo_v_immo_etat TO create_sig;

ALTER TABLE x_apps.xapps_an_vmr_immo_bati
    OWNER TO sig_create;

GRANT ALL ON TABLE x_apps.xapps_an_vmr_immo_bati TO sig_create;
GRANT SELECT ON TABLE x_apps.xapps_an_vmr_immo_bati TO read_sig;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE x_apps.xapps_an_vmr_immo_bati TO edit_sig;
GRANT ALL ON TABLE x_apps.xapps_an_vmr_immo_bati TO create_sig;

