![picto](/img/geocompiegnois20.png)

# Documentation d'administration de la base #

## Principes
 
 (à rédiger)
 
 * **résumé fonctionnel** :
 
 (à rédiger)

## Modèle conceptuel simplifié

[Ouvrez le diagramme](https://dbdiagram.io/d/5e9552f139d18f5553fd8d0c)

![mcd](/img/BAL.png)

## Schéma fonctionnel

![schema_fonctionnel](img/.png)

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





