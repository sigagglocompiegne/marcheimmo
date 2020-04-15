
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

-- #################################################################### DOMAINE DE VALEUR  ####################################################################

ALTER TABLE m_economie.lt_immo_ityp
  OWNER TO sig_create;
GRANT ALL ON TABLE m_economie.lt_immo_ityp TO sig_create;
GRANT ALL ON TABLE m_economie.lt_immo_ityp TO create_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_economie.lt_immo_ityp TO edit_sig;
GRANT SELECT ON TABLE m_economie.lt_immo_ityp TO read_sig;

ALTER TABLE m_economie.lt_immo_dbien
  OWNER TO sig_create;
GRANT ALL ON TABLE m_economie.lt_immo_dbien TO sig_create;
GRANT ALL ON TABLE m_economie.lt_immo_dbien TO create_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_economie.lt_immo_dbien TO edit_sig;
GRANT SELECT ON TABLE m_economie.lt_immo_dbien TO read_sig;

ALTER TABLE m_economie.lt_immo_dbati
  OWNER TO sig_create;
GRANT ALL ON TABLE m_economie.lt_immo_dbati TO sig_create;
GRANT ALL ON TABLE m_economie.lt_immo_dbati TO create_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_economie.lt_immo_dbati TO edit_sig;
GRANT SELECT ON TABLE m_economie.lt_immo_dbati TO read_sig;

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

ALTER TABLE m_economie.lk_immo_bien
  OWNER TO sig_create;
GRANT ALL ON TABLE m_economie.lk_immo_bien TO sig_create;
GRANT ALL ON TABLE m_economie.lk_immo_bien TO create_sig;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE m_economie.lk_immo_bien TO edit_sig;
GRANT SELECT ON TABLE m_economie.lk_immo_bien TO read_sig;

