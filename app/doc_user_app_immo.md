![picto](https://github.com/sigagglocompiegne/orga_gest_igeo/blob/master/doc/img/geocompiegnois_2020_reduit_v2.png)

# Documentation utilisateur du module Marché immobilier dans l'application Activité Economique #

**Pour tous les utilisateurs ayant le droit d'accès à l'application** :
- [Accès aux informations d'un bâtiment ou d'un local d'activités](https://github.com/sigagglocompiegne/marcheimmoent/blob/master/app/doc_util_util_1_immo.md)
- [Recherche d'un bien disponible à la vente et/ou à la location](https://github.com/sigagglocompiegne/marcheimmoent/blob/master/app/doc_util_util_2_immo.md)

**Pour l'administrateur des données** :

Cette documentation est spécifique aux personnes intégrant de la donnée depuis l'application Web.

  * La modification de l'inventaire

Si le bien est déjà saisi, l'accès à ces informations pour compléments ou ajouts d'informations (média, occupants, locaux éventuels pour les bâtiments concernés) est possible par simple clic sur l'objet à partir de la carte. Ce fonctionnel permet d'accéder de nouveau à la fiche d'informations pour la modifier.

  * La suppression de l'inventaire

Pour supprimer un objet saisi, un simple clic sur l'objet à partir de la carte vous ouvre la fiche d'informations. Rendez la fiche d'informations éditable en cliquant sur EDITER, puis cliquez sur SUPPRIMER. Le développement fonctionnel supprime automatiquement les objets et les informations liées de cette manière :
    * pour un terrain : suppression classique de l'objet et des informations liées dans la base
    * pour un local (Bâtiment non divisé) : suppression de l'objet et des informatiosn liées dans la base, y compris les information du bâtiment
    * pour un local indépendant divisé : la suppression de tous les objets (ou locaux) appartenant à un même bâtiment supprime par défaut toutes les informations, y compris celles du bâtiment d'appartenance. Si il reste 1 local d'appartenance, les informations du bâtiment demeurent et le bâtiment est reconstruit virtuellement avec les locaux restant.
    * pour un local non identifié dans un bâtiment divisible : chaque local attaché à un bâtiment peut-être suppprimé indivuellement. La suppression de tous les locaux n'entraine pas ici la suppression des informations du bâtiment. Pour supprimer définitivement ces informations, il faut EDITER la fiche et cliquer sur SUPPRIMER.

  * La saisie dans l'inventaire

La saisie des objets doit respecter les principes et les règles de modélisation édictées [ici](https://github.com/sigagglocompiegne/marcheimmoent/blob/master/gabarit/livrables.md).

La documentation ci-après s'attachera à indiquer les outils fonctionnels de l'application Web à utiliser pour la saisie et la gestion des données.

  * Généralités

Le développement fonctionnel de l'inventaire cartographique priviligie l'accès par type de biens. Vous trouverez ci-dessous les différents choix possibles. 

![picto](doc_admin_menu.png)

 * 1 - Accès aux fonctionnalités avancées du module Marché Immobilier
 * 2 - Accès aux fonctionnalités de gestion
 
   * 3 - [Accès à la saisie d'un terrain]()
   * 4 - [Accès à la saisie d'un bâtiment contenant 1 ou n locaux non identifiables]()
   * 5 - [Accès à la saisie de locaux identifiables reconstruisant la bâtiment]()
   * 6 - [Accès à la gestion des bâtiments d'affectation]()
   * 7 - Accès à la Recherche par n° de bâtiment d'activité (ce choix est uniquement visible et accessible depuis l'application par le service SIG pour une gestion interne)
