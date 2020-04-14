![picto](/img/geocompiegnois20.png)

# Documentation d'administration de la base #

## Principes
 
 * **Généralités** :
 
Le service du développement économique exploite déjà une base de données liée à son domaine d'activité à savoir le suivi de la commercialisation du foncier à vocation économique dans les zones aménagées par l'Agglomération de la Région de Compiègne. 

Ce suivi est complété par une information sur les contacts et les emplois par entreprises. Ces données locales viennent enrichir la base SIRENE de l'Insee sur les établissement mise à jour trimestriellement et géolocalisés à l'adresse. L'ensemble de ces informations permet d'extraire des indicateurs de suivis sur les ZAE (zones d'activités économiques).

Une bourse aux locaux (BAL) a également été mise en place pour répondre aux demandes d'entreprises cherchant à s'implanter sur le territoire. Cette BAL ne répond pas entièrement aux attentes du service et une réflexion s'est engagée pour que le service puisse disposer d'une vision globale d'occupation des locaux et de proposer des terrains privés à la vente. 

Cette orientation pourrait également déboucher sur un observatoire des commerces ou locaux de centre-ville à moyen ou long terme.
 
 * **Résumé fonctionnel** :
 
 * une seule géométrie est créé pour : un terrain (non bâti), un local d'activité correspondant à un bâtiment, un local dans un bâtiment comprenant x locaux (locaux divisés), un local (non identifié) dans un bâtiment (dans ce cas la géométrie du local est égale à la géométrie du bâtiment)
 * une classe `biens` permet de décrire le type de biens (terrain ou local) avec la possibilité d'intégrer des informations sur le bâtiment et le propriétaire
 * un `bien` est complété par son occupant (si existe) à savoir un établissement. Par défaut un local sans occupant est concidéré comme vacant (fonctionnel de la vacance à confirmer ici)
 * une classe `commercialisation` gère les périodes de mise en location ou vente
 * toutes les classes peuvent indépendemment intégrer de la documentation

## Modèle conceptuel simplifié

![mcd](/img/BAL.png)

[Ou accédez au diagramme source](https://dbdiagram.io/d/5e9552f139d18f5553fd8d0c)

## Schéma fonctionnel

(à venir)

## Dépendances

La base de données des contrôles de conformité s'appuie sur des référentiels préexistants constituant autant de dépendances nécessaires pour l'implémentatation de cette base.

|Schéma | Table/Vue | Description | Usage |
|:---|:---|:---|:---|
|[schema] | [table, vue] | ... | ... |

## Classes d'objets

L'ensemble des classes d'objets de gestion sont stockés dans le schéma `m_economie` et celles applicatives dans le schéma 
`x_apps`.

 ### classes d'objets de gestion :
  
   `...` : table des attributs métiers permettant de gérer l'ensemble des éléments d'un contrôle de conformité.
   
|Nom attribut | Définition | Type | Valeurs par défaut |
|:---|:---|:---|:---|
|idcc|Identifiant interne unique du contrôle|integer|nextval('m_reseau_humide.an_euep_cc_idcc_seq'::regclass)|


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





