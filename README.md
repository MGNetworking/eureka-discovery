## Table of contents

* [General info](#general-info)
* [Technologies](#technologies)
* [Setup](#setup)
* [Dev](#Dev)

## General info

Ce micro-service a pour but référencer tous les micro-services du projet. Cette liste est utilisé par les
micro-services `gateway` qui en gestion de faire suivre
les requêtes.

## Technologies

Ce projet a été créer avec : `Spring boot version : 2.4.5`

## Setup

Les scripts `run.sh` et `down.sh` ont été créer dans le but de facilité l'exécution du projet en environnenemt DEV.

Les scripts

* `run.sh` : permet de lancer le docker compose
* `down.sh` : permet l'arrêter est la suppression du conteneur et l'images

## Dev

Pour créer dans intellij, un module de lancement :  
```shell
clean test -Dspring.profiles.active=dev spring-boot:run -Dspring-boot.run.jvmArguments=-Dspring.profiles.active=dev
```
Pour le mode debug
```shell
clean test -Dspring.profiles.active=dev -DCONFIG_SERVICE_URI_host=http://192.168.1.68:8089 spring-boot:run "-Dspring-boot.run.jvmArguments=-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005 -DCONFIG_SERVICE_URI_host=http://192.168.1.68:8089 -Dspring.profiles.active=dev"
```


