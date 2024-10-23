# Objet : 
Lorsque vous testez vos formulaire, la saisie est une opération fastidieuse
Utiliser selenium ide peut rendre la tache moins rébarbative.
En utilisant ce script vous pourrez générer des suites de tests selenium variées rapidement.

### Pré requis
Connaissance sommaire du html/css d'un fichier "selenium.side"

### Le skeleton :
Il contient des modèles de seleniums avec des variables {{ma_variable_n}} qui seront gérées par le script pour builder la suite de test sélénium et alimentées par des datas (voir "###Les data")
Arborescence :
skeleton/$nom_projet/$uri

### Les datas : 
Dans le fichier excel du projet situé dans le répertoire "data" : $nom_projet.csv
Actuellement les datas concerne uniquement une seule colonne (email par exemple)

### Les Templates :
Fichiers selenium au format "suite.side"
Ils sont divisées en 3 parties : un entête, un corps et un pied de page
Seul le fichier base_unitaire.side est à modifier en utilisant le fichier selenium enregistré avec séléniumide.

### Préparation du projet init_project.sh :
./init_project.sh $nom_projet 

### Execution du script genere_seleniumide.sh :
./genere_suite_seleniumide.sh $nom_projet 

### Résultat
=> génère un script "suite_$nom_projet.side" de test exploitable par seleniumide situé dans le répertoire $nom_projet

#################################### ÉTAPES À SUIVRE POUR LE SITE hermes-cms.org###################################################

Nom de la suite de test : hermes-cms
url du site à tester : hermes-cms.org
uri du site à tester : /fr/contact
valeur1 : prenom
valeur2 : nom
valeur3 : email
valeur4 : numéro de téléphone
valeur5 : message


1. Installer l'extension selenium ide sur votre navigateur : https://addons.mozilla.org/fr/firefox/addon/selenium-ide/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search

2. Initialiser le projet :
Exécuter la commande ./init_project.sh monsite

Cela Dupliquera le répertoire data/test dans data/monsite où monsite est le nom du site à tester (ex: monsite = hermes-cms) : 
Modifier le fichier data/monsite/data.xlsx pour l'adapter au formulaire testé :
Les 2 premières colonnes correspondes à l'url du site (ex : hermes-cms.org) et à l'uri( "/fr/contact") de la page du formulaire à tester.
Les colonnes suivantes doivent avoir pour entête valeur1, valeur2, ..., valeur10.
On n'ira pas au dela de l'indice correspondant aux nombres de champs à saisir dans le formulaire.
La valeur sous ces colonnes est la valeur dans le formulaire. 
Exemple : la colonne "valeur1" aura une liste de nom si le nom est le premier champs du formulaire.

Cela Dupliquera le répertoire skeleton/test dans skeleton/monsite (skeleton/hermes-cms)

3. Enregistrer un nouveau test selenium pour le site web à tester (exemple : formulaire de contact à tester https://hermes-cms.org/fr/contact) en insérant les valeur "valeur1", "valeur2"... dans le formulaire.
Sauvegarder votre test dans un fichier "test.side".

4. fichier base_unitaire.side :
Copier l'ensemble des blocks de votre fichier test.side qui ont ce modèle :
	{
	      "id": "c18b5c06-d6d8-4f57-9641-bfc5015d7dea",
	      "comment": "",
	      "command": "open",
	      "target": "yyyyyyyy",
	      "targets": [],
	      "value": ""
	},
à la place du block {{REMPLACER PAR LES BLOCKS SELENIUM}}

5. fichier base_unitaire.side : remplacer les valeurs par les variables adéquates
	Après "command" :
		"target": "{{test_uri}}",
		"value": "{{valeurN}}" où N est l'indice de la valeur du formulaire. 
