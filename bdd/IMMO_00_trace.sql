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
2020-01-22 : GB / Intégration de la géolocalisation des bâtiments sur la Base Adresse Locale (BAL), permettant de récupérer la liste des établissements (occupants) affectés sur la BAL
2020-01-29 : GB / Simplification des bâtiments avec 1 local, fusionner avec les bâtiments contenant n locaux
2020-02-01 : GB / Documentation GitHub pas à jour manque les éléments descriptifs qui seront intégrés plus tard (en attente retour service métier)
2020-02-16 : GB / Intégration des derniers ajustements concernant les libellés affichés sur les locaux et les bâtiments
2021-04-07 : GB / Intégration d'une vue applicative recomposant l'affichage des locaux d'activité et le libellé des occupants (reconstitution de l'affichage de la partie carto de l'application)
2021-04-15 : GB / Adaptation mineure au niveau de la gestion des médias
