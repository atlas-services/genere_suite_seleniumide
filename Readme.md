# Objet : 
Lorsque vous testez vos formulaires, la saisie est une opération fastidieuse
Utiliser selenium ide peut rendre la tache moins rébarbative.
En utilisant ce script vous pourrez générer des suites de tests selenium variées rapidement.

### Pré requis
Connaissance sommaire des langages html/css/json d'un fichier "selenium.side"

### Le skeleton :
Il contient des modèles de seleniums qui seront gérés par le script pour builder la suite de test sélénium "monsite/suite.side" et alimentées par des datas (voir "### Les data")

### Les datas : 
Dans le fichier excel du projet situé dans le répertoire "data" : data/monsite/data.xlsx

### Les Templates :
Fichiers selenium au format "suite.side"
Ils sont divisées en 3 parties : un entête, un corps et un pied de page
Seul le fichier base_unitaire.side est à modifier en utilisant le fichier selenium enregistré avec séléniumide.

### Préparation du projet init_project.sh :
./init_project.sh monsite : prépae les datas et le skeleton du projet monsite

### Execution du script genere_seleniumide.sh :
./genere_suite_seleniumide.sh monsite

### Résultat
=> génère un script "monsite/suite.side" de test exploitable par seleniumide.

### ÉTAPES À SUIVRE (exemple pour le site hermes-cms.org)

Nom du projet : hermes-cms
url du site à tester : hermes-cms.org
uri du site à tester : /fr/contact
valeur1 : prenom
valeur2 : nom
valeur3 : email
valeur4 : numéro de téléphone
valeur5 : message


1. Installer l'extension selenium ide sur votre navigateur : https://addons.mozilla.org/fr/firefox/addon/selenium-ide/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search

2. Initialiser le projet :
Exécuter la commande ./init_project.sh hermes-cms

Cela Dupliquera le répertoire data/test dans data/hermes-cms
Modifier le fichier data/hermes-cms/data.xlsx pour l'adapter au formulaire testé :
Les 2 premières colonnes correspondent à l'url du site (ex : hermes-cms.org) et à l'uri( "/fr/contact") de la page du formulaire à tester.
Les colonnes suivantes doivent avoir pour entête valeur1, valeur2, ..., valeur10.
On n'ira pas au dela de l'indice correspondant aux nombres de champs à saisir dans le formulaire.
La valeur sous ces colonnes est la valeur dans le formulaire.
Exemple : la colonne "valeur1" aura une liste de noms si le nom est le premier champs du formulaire à tester.

Cela Dupliquera le répertoire skeleton/test dans skeleton/hermes-cms (skeleton/hermes-cms)

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

5. Exécuter le script ./genere_suite_seleniumide.sh hermes-cms
Le fichier hermes-cms/suite.side a été créé et est désormais exploitable par l'extension seleniumide.
