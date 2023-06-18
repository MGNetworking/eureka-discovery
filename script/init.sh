#!/bin/bash

name_conteneur="eureka"

status=$(docker inspect --format='{{.State.Status}}' $name_conteneur)

if [[ $status == "running" ]]; then

  timeUTC=$(docker inspect --format='{{.State.StartedAt}}' $name_conteneur)
  conversion=$(date -d $timeUTC)
  echo "************************************"
  echo "Le conteneur $name_conteneur est en cour d'exécution depuis : $conversion"
  docker compose -f ./docker/docker-compose-DEV.yml logs -f

elif [[ $status == "exited" ]]; then
  echo "************************************"
  echo "Lancement du conteneur $name_conteneur"
  docker container start $name_conteneur
else
  echo "************************************"
  echo "Création de l'images est du conteneur $name_conteneur"
  docker compose -f ./docker/docker-compose-DEV.yml build --no-cache
  docker compose -f ./docker/docker-compose-DEV.yml up -d
  docker compose -f ./docker/docker-compose-DEV.yml logs -f
fi
