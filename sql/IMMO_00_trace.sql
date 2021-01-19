/*IMMO V1.0*/
/*Creation du fichier trace qui permet de suivre l'évolution du code*/
/* IMMO_10_trace.sql */
/*PostGIS*/

/* Propriétaire : GeoCompiegnois - http://geo.compiegnois.fr/ */
/* Auteur : Bodet Grégory */

/*  
 
  Liste des dépendances :
  schéma          | table                 | description                                                   | usage
*/

/*
#################################################################### SUIVI CODE SQL ####################################################################
2020-04-14 : GB / initialisation du code (1ère version d'essai d'un fonctionnel)
2020-04-21 : GB / adaptation mineure des attributs suites première présentation fonctionnelle
2020-05-05 : GB / début du développement de fonctions triggers pour générer les automatismes fonctionnelles
2020-01-19 : GB / refonte complète de la gestion des données du patrimoine cartographique des bâtiments et locaux d'activités (vue de gestion + fonction trigger)
2020-01-19 : GB / Mise à jour de structure initiale avec attributs métiers complémentaires et intégration dans les routines de gestion
