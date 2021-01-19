![picto](https://github.com/sigagglocompiegne/orga_gest_igeo/blob/master/doc/img/geocompiegnois_2020_reduit_v2.png)

# Prescriptions spécifiques (locales) pour le suivi du marché de l'immobilier d'entreprises

# Documentation du standard

# Changelog

- 19/01/2021 : description initiale du gabarit de production des bâtiments d'activités et des locaux les composant.

# Livrables

Le gabarit présenté ci-après s'organise autour de la production d'un inventaire cartographique des bâtiments d'activités et des locaux les composant dans les zones d'activités en priorité pour un déploiement progressif à moyen ou long terme en centre-ville. 
L'objectif principal est bien de recenser l'ensemble des objets participant à la structuration 
des locaux d'activité. En les typant par une nomenclature simple et compréhensible, cet inventaire peut-être
produit par un nom spécialiste.
Néanmoins pour les besoins d'un service gérant les locaux d'activité, ce gabarit a été pensé pour deux autres usages : l'un permettant
de détailler ces objets d'un point de vue métier et un autre dans une optique de connaissance du marché immobilier et proposer des biens à des entreprises.
Cet inventaire sera ainsi intégré à la base de données de la collectivité et pourra être également complété et mis à jour par le service métier à moyen et long terme.


## Gabarits

- Fichier gabarit Qgis 3.x (vierge) complet à télécharger (en cours de réalisation)

## Principe fonctionnel

(texte)

![picto](.png)

Schéma 1 : une représentation des objets d'un inventaire cartographique


## Règle de modélisation

### Règles générales

Les objets constituant l'inventaire cartographique initial sont organisés autour d'une seule primitive graphique de type polygone. 
**La saisie des objets de type multi est autorisée.**

La saisie de ces objets doit permettre une restitution de l'ordre du 1 000ème.

Les objets produits dans le cadre de cet inventaire devront être en cohérence topologique avec la précision des bâtiments du PCI Vecteur.


### La modélisation

Les règles de modélisation consiste à présenter la façon dont les objets doivent être saisis et restitués dans le gabarit.

Ici ils sont simples, un polygone représente au moins un local, qu'il correspond à un bâtiment ou constitue un bâtiment par regroupement. Un bâtiment regroupant n locaux non identifiés sera représenté par un polygone. Il n'y a pas de limites de surfaces pour la représentation d'un objet. Ils doivent simplement représenter une activité économique.


### Topologie

La cohérence topologique impose le partage de géométrie et donc l’utilisation des outils « d’accroches ».

- les objets peuvent être à cheval sur plusieurs communes,
- les objets peuvent appartenir à une site d'activités.

- Tous les objets de type "surface" sont des polygones fermés, et si ils sont adjacents, ils devront être topologique (absence de chevauchements et de micro-trous). 

![picto](topo_poly_1.png) ![picto](topo_poly_3.png)

- Un polygone contenant un autre polygone devra être découpé avec celui-ci.

![picto](topo_poly_2.png)

### Système de coordonnées

Les coordonnées seront exprimées en mètre avec trois chiffres après la virgule dans le système national en vigueur.
Sur le territoire métropolitain s'applique le système géodésique français légal RGF93 associé au système altimétrique IGN69. La projection associée Lambert 93 France (epsg:2154) sera à utiliser pour la livraison des données.

## Format des fichiers

Les fichiers sont disponibles au format ESRI Shape (.SHP) contenant la géométrie.
L'encodage des caractères est en UTF8. Les différents supports sont téléchargeables dans la rubrique Gabarits.

## Description des classes d'objets

|Nom fichier|Définition|Catégorie|Géométrie|
|:---|:---|:---|:---|
|geo_v_ev_point|Localisation des objets "espace vert" de représentation ponctuelle|Inventaire cartographique|Ponctuel|
|geo_v_ev_polygon|Délimitation des objets "espace vert" de représentation surfacique|Inventaire cartographique|Polygone|
|geo_v_ev_line|Tracé des objets "espace vert" de représentation rectiligne|Inventaire cartographique|Linéaire|

## Implémentation informatique

### Patrimoine

Ensemble des données décrivant les objets composant l'inventaire cartographique des espaces verts. 

`geo_v_ev_point` : fichier contenant les objets "espace vert" de type ponctuel

|Nom attribut|Définition|Type|Valeurs|Contraintes|Observations|
|:---|:---|:---|:---|:---|:---|
|idobjet|Identifiant unique des objets|integer|Incrémentation automatique valeur max(idobjet)+1|NOT NULL||
|typev1|Nomenclature de niveau 1 identifiant le type d'espace vert|character varying(1)|Liste de valeurs lt_ev_typev1|NOT NULL||
|typev2|Nomenclature de niveau 2 identifiant le type d'espace vert|character varying(3)|Liste de valeurs lt_ev_typev2|NOT NULL||
|srcgeom_sai|Référentiel de saisie|character varying(2)|Liste de valeurs lt_src_geom|NOT NULL||
|srcdate_sai|Année du référentiel de saisie|integer||NOT NULL||
|qualglocxy|Incertitude maximale de la précision de saisie en cm|integer||NOT NULL||
|op_sai|Opérateur de saisie |character varying(50)||NOT NULL||
|dat_sai|Date de saisie |Date|now()|NOT NULL|Valeur calculée automatiquement à la saisie|
|observ|Commentaires divers |character varying(254)||||
|surf_e|Surface d'emprise au sol en m²|integer|||(en fonction des choix de modélisation retenue)|


`geo_v_ev_polygon` : fichier contenant les objets "espace vert" de type surfacique

|Nom attribut|Définition|Type|Valeurs|Contraintes|Observations|
|:---|:---|:---|:---|:---|:---|
|idobjet|Identifiant unique des objets|integer|Incrémentation automatique valeur max(idobjet)+1|NOT NULL||
|typev1|Nomenclature de niveau 1 identifiant le type d'espace vert|character varying(1)|Liste de valeurs lt_ev_typev1|NOT NULL||
|typev2|Nomenclature de niveau 2 identifiant le type d'espace vert|character varying(3)|Liste de valeurs lt_ev_typev2|NOT NULL||
|srcgeom_sai|Référentiel de saisie|character varying(2)|Liste de valeurs lt_src_geom|NOT NULL||
|srcdate_sai|Année du référentiel de saisie|integer||NOT NULL||
|qualglocxy|Incertitude maximale de la précision de saisie en cm|integer||NOT NULL||
|op_sai|Opérateur de saisie |character varying(50)||NOT NULL||
|dat_sai|Date de saisie |Date|now()|NOT NULL||
|observ|Commentaires divers |character varying(254)||||
|sup_m²|Surface du polygone saisie en mètre carré|integer|$area|NOT NULL|Valeur calculée automatiquement à la saisie|
|perimetre|Périmètre du polygone saisie en mètre|integer|$perimetre|NOT NULL|Valeur calculée automatiquement à la saisie|

`geo_v_ev_line` : fichier contenant les objets "espace vert" de type linéaire

|Nom attribut|Définition|Type|Valeurs|Contraintes|Observations|
|:---|:---|:---|:---|:---|:---|
|idobjet|Identifiant unique des objets|integer|Incrémentation automatique valeur max(idobjet)+1|NOT NULL||
|typev1|Nomenclature de niveau 1 identifiant le type d'espace vert|character varying(1)|Liste de valeurs lt_ev_typev1|NOT NULL||
|typev2|Nomenclature de niveau 2 identifiant le type d'espace vert|character varying(3)|Liste de valeurs lt_ev_typev2|NOT NULL||
|srcgeom_sai|Référentiel de saisie|character varying(2)|Liste de valeurs lt_src_geom|NOT NULL||
|srcdate_sai|Année du référentiel de saisie|integer||NOT NULL||
|qualglocxy|Incertitude maximale de la précision de saisie en cm|integer||NOT NULL||
|op_sai|Opérateur de saisie |character varying(50)||NOT NULL||
|dat_sai|Date de saisie |Date|now()|NOT NULL||
|observ|Commentaires divers |character varying(254)||||
|long_m|Longueur du tracé saisie en mètre|integer|$length|NOT NULL|Valeur calculée automatiquement à la saisie|
|larg_cm|Largeur du tracé saisie en centimètre|integer||NOT NULL||

### Liste de valeurs

Le contenu des listes de valeurs est disponible dans la documentation complète de la base de données en cliquant [ici](/bdd/doc_admin_bd_ev.md) dans la rubrique `Liste de valeurs`.

Cependant, pour des questions de compréhension, la nomenclature définissant le type des objets "espace vert" est présentée ci-dessous. Pour l'inventaire cartographique, seuls les 2 premiers niveaux de nomenclature sont imposés.


`lt_ev_typev1` : liste des valeurs de la nomenclature de niveau 1 permettant de décrire les objets de l'inventaire cartographique des espaces verts

|Code|Valeur|
|:---|:---|
|1|Végétal|
|2|Minéral|
|3|Hydrographie|
|9|Référence non classée|

`lt_ev_typev2` : liste des valeurs de la nomenclature de niveau 2 permettant de décrire les objets de l'inventaire cartographique des espaces verts

|Code|Valeur|
|:---|:---|
|101|Arbre|
|102|Espace enherbé|
|103|Espace planté|
|104|Ponctuel fleuri|
|105|Haie, mur|
|106|Friche|
|201|Allée|
|202|Clôture|
|203|Zone de rencontre|
|204|Accès|
|205|Equipement|
|301|Bassin|
|302|Points d'eau|
|303|Cours d'eau|
|999|Référence non classée|

`lt_src_geom` : liste des valeurs des référentiels de saisis disponibles
|Code|Valeur|
|:---|:---|
|00|Non renseigné|
|20|Ortho-images|
|22|Orthophotoplan partenaire|
|50|Lever|
|51|Plan topographique|
|53|Trace GPS|
|99|Autre|

### Les identifiants

Les identifiants des objets des espaces verts sont des identifiants non signifiants (un simple numéro incrémenté de 1 à chaque insertion).



