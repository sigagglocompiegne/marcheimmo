![picto](/img/geocompiegnois20.png)

# Documentation d'administration de la base #

## Principes
 
 **Généralités** :
 
Le service du développement économique exploite déjà une base de données liée à son domaine d'activité à savoir le suivi de la commercialisation du foncier à vocation économique dans les zones aménagées par l'Agglomération de la Région de Compiègne. 

Ce suivi est complété par une information sur les contacts et les emplois par entreprises. Ces données locales viennent enrichir la base SIRENE de l'Insee sur les établissement mise à jour trimestriellement et géolocalisés à l'adresse. L'ensemble de ces informations permet d'extraire des indicateurs de suivis sur les ZAE (zones d'activités économiques).

Une bourse aux locaux (BAL) a également été mise en place pour répondre aux demandes d'entreprises cherchant à s'implanter sur le territoire. Cette BAL ne répond pas entièrement aux attentes du service et une réflexion s'est engagée pour que le service puisse disposer d'une vision globale d'occupation des locaux et de proposer des terrains privés à la vente. 

Cette orientation pourrait également déboucher sur un observatoire des commerces ou locaux de centre-ville à moyen ou long terme.
 
 **Résumé fonctionnel** :
 
La donnée a été construite de façon à pouvoir réaliser un inventaire cartographique selon la composition des bâtiments. 3 scénarii de construction ont été établis en dehors de la gestion des terrains qui se réalise indépendemment.

- le local et le bâtiment en font qu'une seule entité : Local (Bâtiment non divisé)
- le bâtiment contient au moins 2 locaux mais ils ne sont identifiables (localisation ou numérisation impossible) : Local non identifié dans un bâtiment divisible
- le bâtiment est composé d'au moins 2 locaux identifiables (dans ce cas le bâtiment est reconstruit virtuellement par l'association des locaus qui le composent) : Local indépendant divisé

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


## Séquences 

Il y a 7 séquences. Cinq sont dédiées aux classes métiers et composées d'une lettre et d'un serial afin de mieux les distinguer dans la structure interne des données. La gestion de la base imliquant des écritures d'identifiant métiers dans plusieurs tables, cette structuration de séquences est une aide à l'administration.

Les 2 autres séquences sont uniquement de type serial pour la gestion d'identifiant unique interne à la gestion des classes correspondantes.


## Classes d'objets

L'ensemble des classes d'objets de gestion sont stockés dans le schéma `m_economie` et celles applicatives dans le schéma 
`x_apps`.

 ### classes d'objets de gestion :
  
   `geo_immo_bien` : table des attributs métiers permettant de gérer l'ensemble des éléments de la primitive graphique (terrain, local ou bâtiment contenant un ou des locaux).
   
|Nom attribut | Définition | Type | Valeurs par défaut |
|:---|:---|:---|:---|
|idimmo|Identifiant unique de l'objet|text|('O'::text nextval('m_economie.geo_immo_bien_seq'::regclass))|
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
|geom|Attribut de géométrie|Multipolygon,2154| |


Particularité(s) à noter :
* (à venir)

---
   `an_immo_bien` : table des attributs métiers permettant de gérer l'ensemble des éléments décrivant le bien (terrain ou local)
   
|Nom attribut | Définition | Type | Valeurs par défaut |
|:---|:---|:---|:---|
|idbien|Identifiant unique du bien|text|('B'::text nextval('m_economie.an_immo_bien_seq'::regclass))|
|idimmo|Identifiant unique de l'objet bien|text| |
|tbien|Type de bien|character varying(4)| |
|libelle|Libellé du bien|character varying(254)| |
|bdesc|Description du bien|character varying(100)| |
|pdp|Bien en pas-de-porte|boolean|false|
|lib_occup|Libellé de l'occupant ou détail sur le type d'occupation (si pas un établissement lié)|character varying(150)| |
|bal|Identifiant de la base adresse|integer| |
|adr|Adresse litérale (si différente de la BAL)|character varying(254)| |
|adrcomp|Complément d'adresse|character varying(100)| |
|surf|Surface en hectare|double precision| |
|surf_m|Surface en m²|integer| |
|source|Source de la mise à jour|character varying(254)| |
|refext|Lien vers un site présentant le terrain|character varying(254)| |
|observ|Observations|character varying(1000)| |


Particularité(s) à noter :
* (à venir)

---

 `an_immo_bati` : table des attributs métiers permettant de gérer l'ensemble des éléments décrivant le bâtiment
   
|Nom attribut | Définition | Type | Valeurs par défaut |
|:---|:---|:---|:---|
|idbati|Identifiant du bâtiment|text|('BA'::text nextval('m_economie.an_immo_bati_seq'::regclass))|
|idimmo|Identifiant de l'objet|text| |
|libelle|Libellé du bâtiment|character varying(254)| |
|surf_m|Surface en m²|integer| |
|shon|Surface de plancher en m²|integer| |
|hauteur|Hauteur em mètre|integer| |
|nbloc|Nombre de local dans le bâtiment|integer| |
|bdesc|Description du bâtiment|character varying(100)| |
|mprop|Même propriétaire que le local|boolean|false|
|observ|Observations|character varying(1000)| |


Particularité(s) à noter :
* (à venir)

---

 `an_immo_prop` : table des attributs métiers permettant de gérer l'ensemble des éléments décrivant le propriétaire du bâtiment, du local ou du terrain
   
|Nom attribut | Définition | Type | Valeurs par défaut |
|:---|:---|:---|:---|
|idprop|Identifiant du propriétaire|text|('P'::text nextval('m_economie.an_immo_prop_seq'::regclass))|
|idbati|Identifiant du bâtiment|text| |
|idimmo|Identifiant de l'objet|text| |
|idbien|Identifiant du bien|text| |
|propnom|Nom du propriétaire|character varying(100)| |
|proptel|Téléphone du propriétaire|character varying(14)| |
|proptelp|Téléphone portable du propriétaire|character varying(14)| |
|propmail|Email du propriétaire|character varying(80)| |
|observ|Observations|character varying(1000)| |


Particularité(s) à noter :
* (à venir)

---

 `an_immo_comm` : table des attributs métiers permettant de gérer l'ensemble des éléments liés à la commercialisation et aux conditions financières de l'occupation actuelle
   
|Nom attribut | Définition | Type | Valeurs par défaut |
|:---|:---|:---|:---|
|idcomm|Identifiant unique de la commercialisation|text|('C'::text nextval('m_economie.an_immo_comm_seq'::regclass))|
|idimmo|Identifiant de l'objet bien|text| |
|idbien|Identifiant du bien|text| |
|prix_a|Prix d'acquisition du bien occupé|integer| |
|prix_am|Prix d'acquisition au m² du bien occupé|integer| |
|loyer_a|Loyer actuel du bien|integer| |
|loyer_am|Loyer actuel du bien au m²|integer| |
|bail_a|Montant du bail actuel du bien|integer| |
|prix|Prix total|integer| |
|prix_m|Prix au m²|integer| |
|loyer|Loyer total|integer| |
|loyer_m|Loyer au m²|integer| |
|bail|Montant du Bail|integer| |
|comm|Nom du commercialisateur|character varying(150)| |
|commtel|Téléphone du commercialisateur|character varying(14)| |
|commtelp|Téléphone portable du commercialisateur|character varying(14)| |
|commmail|Email du commercialisateur|character varying(80)| |
|etat|Etat de la commercialisation|character varying(2)| |
|source|Source|character varying(254)| |
|refext|Référence externe d'un site internet présentant une fiche de commercialisation|character varying(254)| |
|observ|Observations|character varying(1000)| |

Particularité(s) à noter :
* (à venir)

---

 `an_immo_comm` : table des attributs métiers permettant de gérer l'ensemble des éléments liés à la commercialisation et aux conditions financières de l'occupation actuelle
   
|Nom attribut | Définition | Type | Valeurs par défaut |
|:---|:---|:---|:---|
|idcomm|Identifiant unique de la commercialisation|text|('C'::text nextval('m_economie.an_immo_comm_seq'::regclass))|
|idimmo|Identifiant de l'objet bien|text| |
|idbien|Identifiant du bien|text| |
|prix_a|Prix d'acquisition du bien occupé|integer| |
|prix_am|Prix d'acquisition au m² du bien occupé|integer| |
|loyer_a|Loyer actuel du bien|integer| |
|loyer_am|Loyer actuel du bien au m²|integer| |
|bail_a|Montant du bail actuel du bien|integer| |
|prix|Prix total|integer| |
|prix_m|Prix au m²|integer| |
|loyer|Loyer total|integer| |
|loyer_m|Loyer au m²|integer| |
|bail|Montant du Bail|integer| |
|comm|Nom du commercialisateur|character varying(150)| |
|commtel|Téléphone du commercialisateur|character varying(14)| |
|commtelp|Téléphone portable du commercialisateur|character varying(14)| |
|commmail|Email du commercialisateur|character varying(80)| |
|etat|Etat de la commercialisation|character varying(2)| |
|source|Source|character varying(254)| |
|refext|Référence externe d'un site internet présentant une fiche de commercialisation|character varying(254)| |
|observ|Observations|character varying(1000)| |

Particularité(s) à noter :
* (à venir)---

 `lk_immo_occup` : table de liens permettant l'affectation d'un ou plusieurs établissements à un local ou un terrain
   
|Nom attribut | Définition | Type | Valeurs par défaut |
|:---|:---|:---|:---|
|id|Identifiant unique de l'occupation|integer|nextval('m_economie.lk_immo_occup_seq'::regclass)|
|idbien|Identifiant du bien occupé|text| |
|idimmo|Identifiant de l'objet bien|text| |
|siret|N° SIRET de l'établissement occupant|character varying(14)| |

Particularité(s) à noter :
* (à venir)

### classes d'objets applicatives métiers sont classés dans le schéma x_apps :
 
`x_apps.xapps_geo_v_immo` : Vue d'exploitation permettant de lister les biens mis en disponibilité (vente, location ou les deux) et afficher au niveau de la cartographie de l'application WebSIG.

### classes d'objets applicatives grands publics sont classés dans le schéma x_apps_public :

Sans objet


### classes d'objets opendata sont classés dans le schéma x_opendata :

Sans objet

---

## Liste de valeurs

`lt_immo_ityp` : Liste des types de biens immobilier saisis

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    
|code|Code interne des types de bien saisi |character(2)| |
|valeur|Libellé des types de bien saisi |character varying(80)| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ code 

Valeurs possibles :

|Code|Valeur|
|:---|:---|
|10|Terrain|
|21|Local (Bâtiment non divisé)|
|22|Local indépendant divisé|
|23|Local non identifié dans un bâtiment divisible|

---

`lt_immo_tbien` : Liste des usages des biens immobilier propre aux types saisis

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    
|code|Code interne des usages des biens|character(2)| |
|valeur|Libellé des usages des biens |character varying(80)| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ code 
* Afin d'effectuer des filtres diversifiés dans l'application WebSIG, les types de biens pour les locaux ont été dupliqués mais reste unique. A l'exploitation, bien intégrer l'ensemble des codes pour les valeurs communes.

Valeurs possibles :

|Code|Valeur|
|:---|:---|
|1010|Terrain vierge|
|1110|Parking|
|1210|Surface de dépôt ou de stockage|
|1310|Surface agricole|
|2021|Bureau|
|2121|Commerce|
|2221|Activité|
|2022|Bureau|
|2122|Commerce|
|2222|Activité|
|2023|Bureau|
|2123|Commerce|
|2223|Activité|

---

`lt_immo_dbien` : Liste des valeurs décrivant un bien

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    
|code|Code interne des descriptifs des biens|character(2)| |
|valeur|Libellé des descriptifs des biens |character varying(80)| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ code 

Valeurs possibles :

|Code|Valeur|
|:---|:---|
|1|Vitrine|
|2|Présence d'une remise|
|3|Autre|

---

`lt_immo_dbati` : Liste des valeurs décrivant un bâtiment

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    
|code|Code interne des descriptifs des bâtiments|character(2)| |
|valeur|Libellé des descriptifs des bâtiments |character varying(80)| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ code 

Valeurs possibles :

|Code|Valeur|
|:---|:---|
|1|Double vitrage|
|2|Site clôturé|
|3|Places de parking|
|4|Murs périphériques (bardage métallique…)|
|5|Ossature (couverture bac acier…)|
|6|Menuiserie aluminium|
|7|Accès sécurisé|
|8|Système d'alarme|
|9|Parties communes|
|10|Portes de plain-pied|
|11|Charge au sol|
|12|Terrain attenant|

---

`lt_immo_etat` : Liste des valeurs décrivant l'état de disponibilité d'un bien

|Nom attribut | Définition | Type  | Valeurs par défaut |
|:---|:---|:---|:---|    
|code|Code interne des disponibilités du bien|character(2)| |
|valeur|Libellé des disponibilités du bien |character varying(80)| |

Particularité(s) à noter :
* Une clé primaire existe sur le champ code 

Valeurs possibles :

|Code|Valeur|
|:---|:---|
|10|Disponible à la vente (vacant)|
|20|Disponible à la vente (occupé)|
|30|Disponible à la location|
|40|Disponible à la vente ou à la location|
|ZZ|Non concerné (occupé)|

## Projet QGIS pour la gestion

Aucun projet QGIS a été réalisé pour la gestion interne des données.


## Export Open Data

Sans objet

---





