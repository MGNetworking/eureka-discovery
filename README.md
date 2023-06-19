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
Ce projet a était créer avec : `Spring boot version : 2.4.5`

## Setup 
Pour exécuter ce projet en phase de développement, vous devrez utilisé les fichiers 
script décrit dans la section plus bas.

Le dossier script contient les fichiers suivant :
* init.sh : permet de lancer le docker compose 
* down.sh : permet l'arréter est la suppression du conteneur et l'images 
* get_machine_ip.sh : permet de récupére l'IP 
* reseau.sh : permet de voir le reseau bridge du conteneur 


Les variables d'envrionnement du projet sont contenu dans le fichier `.env`. 
Le contenu de la variable `IP_DEV` et génére par le script `get_machine_ip.sh` dans le but récupérer
automatique l'idresse ip local de la machine. 

Cette variable permet de transmettre `docker compose` la valeur de l'ip de la machine
qui la transmettra au dockerfile pour la complation. Le dockerfile le récupére en argument 
et la transfert en variable d'environnement. Puis le fichier `application.yml` récupére cette variable 
d'environement pour connaitre l'emplacement du service de configuration.
Ce service permet de récupére la configuation du service eureka.

C'est pourquoi, pour facilité l'exécution en environenemt DEV, 
les scripts init et down ont etait créer. 

NB: Pour pouvoir lancer ces fichier, il faut un interpréteur de type `UNIX`.
Le `Git bash` peux être utilisé, mais pas 100%.

## Dev
Pour créer dans intellij, un module de lancement :  
`clean test -Dspring.profiles.active=dev spring-boot:run -Dspring-boot.run.jvmArguments=-Dspring.profiles.active=dev`
![image info](./READMEpicture/img_1.png)

Pour les test unitaire :
`profiles.active=dev;CONFIG_SERVICE_URI=http://192.168.1.30:8089`
![image info](./READMEpicture/img_2.png)