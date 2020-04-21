![picto](/img/geocompiegnois20.png)

# Documentation d'administration de la base #

## Principes
 
 **Généralités** :
 
Le service du développement économique exploite déjà une base de données liée à son domaine d'activité à savoir le suivi de la commercialisation du foncier à vocation économique dans les zones aménagées par l'Agglomération de la Région de Compiègne. 

Ce suivi est complété par une information sur les contacts et les emplois par entreprises. Ces données locales viennent enrichir la base SIRENE de l'Insee sur les établissement mise à jour trimestriellement et géolocalisés à l'adresse. L'ensemble de ces informations permet d'extraire des indicateurs de suivis sur les ZAE (zones d'activités économiques).

Une bourse aux locaux (BAL) a également été mise en place pour répondre aux demandes d'entreprises cherchant à s'implanter sur le territoire. Cette BAL ne répond pas entièrement aux attentes du service et une réflexion s'est engagée pour que le service puisse disposer d'une vision globale d'occupation des locaux et de proposer des terrains privés à la vente. 

Cette orientation pourrait également déboucher sur un observatoire des commerces ou locaux de centre-ville à moyen ou long terme.
 
 **Résumé fonctionnel** :
 
 * une seule géométrie est créé pour : un terrain (non bâti), un local d'activité correspondant à un bâtiment, un local dans un bâtiment comprenant x locaux (locaux divisés), un local (non identifié) dans un bâtiment (dans ce cas la géométrie du local est égale à la géométrie du bâtiment)
 * une classe `biens` permet de décrire le type de biens (terrain ou local) avec la possibilité d'intégrer des informations sur le bâtiment et le propriétaire
 * un `bien` est complété par son occupant (si existe) à savoir un établissement. Par défaut un local sans occupant est concidéré comme vacant (fonctionnel de la vacance à confirmer ici)
 * une classe `commercialisation` gère les périodes de mise en location ou vente
 * toutes les classes peuvent indépendemment intégrer de la documentation

## Modèle conceptuel simplifié

[Cliquez ici pour accéder au MCD](https://dbdiagram.io/d/5e9552f139d18f5553fd8d0c)

## Schéma fonctionnel

(à venir)

## Dépendances

La base de données du suivi du marché de l'immobilier d'entreprises ne s'appuie sur aucun référentiel préexistant majeurs pour être implémentée. Néanmoins, son usage repose sur des relations avec des listes de valeurs communes ou des référentiels géographiques pouvant perturber son bon fonctionnement au travers de l'application WebSIG développée.

|Schéma | Table/Vue | Description | Usage |
|:---|:---|:---|:---|
|r_objet| lt_src_geom | Liste de valeurs | Valeurs décrivant le référentiel géographique utilisé pour la saisie des objets graphiques|
|x_apps| xapps_geo_vmr_adresse | Liste des adresses disponibles dans la BAL |Permet d'affecter l'identifiant de l'adresse BAL au bien|


## Classes d'objets

L'ensemble des classes d'objets de gestion sont stockés dans le schéma `m_economie` et celles applicatives dans le schéma 
`x_apps`.

 ### classes d'objets de gestion :
  
   `geo_immo_bien` : table des attributs métiers permettant de gérer l'ensemble des éléments de la primitive graphique (terrain, local ou bâtiment contenant un ou des locaux).
   
|Nom attribut | Définition | Type | Valeurs par défaut |
|:---|:---|:---|:---|
|idimmo|Identifiant unique de l'objet|text|('O'::text "||" nextval('m_economie.geo_immo_bien_seq'::regclass))|
|idsite|Identifiant du site d'activité d'appartenance|character varying(7)| |
|sup_m2|Superficie de l'objet en m²|integer| |
|ityp|Type d'occupation|character varying(2)| |
|observ|Observations|character varying(1000)| |
|op_sai|Opérateur de saisie|character varying(25)| |
|date_sai|Date de saisie|timestamp without time zone|now()|
|date_maj|Date de mise à jour|timestamp without time zone| |
|src_geom|Source du référentiel géographique pour le positionnement du nœud|character varying(2)|'00'::character varying|
|src_date|Année du référentiel de saisi|integer| |
|insee|Code Insee de la ou des communes d'assises|character varying(11)| |
|commune|Libellé de la ou des communes d'assises|character varying(160)| |
|geom|Attribut de géométrie|USER-DEFINED| |


Particularité(s) à noter :
* ...

---

---

### classes d'objets applicatives :

(à venir)

---

## Liste de valeurs

`...` : Liste des 

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    
|code|Code interne des ... |character(2)| |
|valeur|Libellé des ... |character varying(80)| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ code 

Valeurs possibles :

|Code|Valeur|
|:---|:---|
|00|Non renseigné|
|..|..|
|..|..|

---


## Projet QGIS pour la gestion

Aucun projet QGIS a été réalisé pour la gestion interne des données.


## Export Open Data

Sans objet

---





