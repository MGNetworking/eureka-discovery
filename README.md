<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> preprod
## Table of contents

* [General info](#general-info)
* [Technologies](#technologies)
* [Setup](#setup)
* [Dev](#Dev)

## General info

Ce micro-service a pour but référencer tous les micro-services du projet.
Cette liste est utilise par le micro-services `gateway` qui en gestion de faire suivre
les requêtes.

## Technologies

Ce projet a été créer avec : `Spring boot version : 2.4.5`

## Setup

Les scripts `init.sh` et `down.sh` ont etait créer dans le but de facilité l'exécution du projet en environnenemt DEV.

__Les script__
* __init.sh__ : permet de lancer le docker compose
* __down.sh__ : permet l'arréter est la suppression du conteneur et l'images
* __Get_IP_Config_Service.sh__ : permet de récupére l'IP du service `Configuration`
* __reseau.sh__ : permet de voir le reseau bridge du conteneur

__Les variables d'environement__  
Les variables d'envrionnement du projet sont contenu dans le fichier `.env`.
Le contenu de la variable `IP_DEV` et génére par le script `get_machine_ip.sh` dans le but récupérer
automatique l'idresse ip local de la machine.

__La variable__ `IP_DEV` :  
1. La variable `IP_DEV` permet de transmettre `docker compose` la valeur de l'ip qui RUN le projet
afin de la transmettra au dockerfile pour la complation.   
2. Le dockerfile le récupére en argument et la transfert en variable d'environnement.   
3. Puis pendant la phase de compilation le fichier `application.yml` récupére cette variable d'environnement 
pour localiser l'emplacement du service de configuration, qui va permet de récupére le fichier de properties du service.

__NB__  
Pour le lancement des script `Bash`, Vous aurez besoin d'un interpréteur de commande de type `UNIX`.
Le `Git bash` peux être utilisé, mais pas 100%, il y a certain variable inconnue dans les scripts pour le `Git bash`.

Aussi, il est possible que les fichiers contienne des caractères de fin de ligne type
window. Cela peut provoquer des erreurs, voici une commande `linux` permettent de modifier ces
caractères. 

Exemple :
````shell
dos2unix init.sh
````

Cette commmande permettra par exemple de modifier les caractères spéciaux contenu dans
le fichier `init.sh` 


## Dev

Pour créer dans intellij, un module de lancement :  
`clean test -Dspring.profiles.active=dev spring-boot:run -Dspring-boot.run.jvmArguments=-Dspring.profiles.active=dev`

Pour les tests unitaires :
`profiles.active=dev;CONFIG_SERVICE_URI=http://192.168.1.30:8089`

=======

Pour les tests unitaires :
`profiles.active=dev;CONFIG_SERVICE_URI=http://192.168.1.30:8089`


=======
## Table of contents

* [General info](#general-info)
* [Technologies](#technologies)
* [Setup](#setup)
* [Dev](#Dev)

## General info

Ce micro-service a pour but référencer tous les micro-services du projet.
Cette liste est utilise par le micro-services `gateway` qui en gestion de faire suivre
les requêtes.

## Technologies

Ce projet a été créer avec : `Spring boot version : 2.4.5`

## Setup

Les scripts `init.sh` et `down.sh` ont etait créer dans le but de facilité l'exécution du projet en environnenemt DEV.

__Les script__
* __init.sh__ : permet de lancer le docker compose
* __down.sh__ : permet l'arréter est la suppression du conteneur et l'images
* __Get_IP_Config_Service.sh__ : permet de récupére l'IP du service `Configuration`
* __reseau.sh__ : permet de voir le reseau bridge du conteneur

__Les variables d'environement__  
Les variables d'envrionnement du projet sont contenu dans le fichier `.env`.
Le contenu de la variable `IP_DEV` et génére par le script `get_machine_ip.sh` dans le but récupérer
automatique l'idresse ip local de la machine.

__La variable__ `IP_DEV` :  
1. La variable `IP_DEV` permet de transmettre `docker compose` la valeur de l'ip qui RUN le projet
afin de la transmettra au dockerfile pour la complation.   
2. Le dockerfile le récupére en argument et la transfert en variable d'environnement.   
3. Puis pendant la phase de compilation le fichier `application.yml` récupére cette variable d'environnement 
pour localiser l'emplacement du service de configuration, qui va permet de récupére le fichier de properties du service.

__NB__  
Pour le lancement des script `Bash`, Vous aurez besoin d'un interpréteur de commande de type `UNIX`.
Le `Git bash` peux être utilisé, mais pas 100%, il y a certain variable inconnue dans les scripts pour le `Git bash`.

Aussi, il est possible que les fichiers contienne des caractères de fin de ligne type
window. Cela peut provoquer des erreurs, voici une commande `linux` permettent de modifier ces
caractères. 

Exemple :
````shell
dos2unix init.sh
````

Cette commmande permettra par exemple de modifier les caractères spéciaux contenu dans
le fichier `init.sh` 


## Dev

Pour créer dans intellij, un module de lancement :  
`clean test -Dspring.profiles.active=dev spring-boot:run -Dspring-boot.run.jvmArguments=-Dspring.profiles.active=dev`


Pour les tests unitaires :
`profiles.active=dev;CONFIG_SERVICE_URI=http://192.168.1.30:8089`


>>>>>>> preprod
>>>>>>> preprod
