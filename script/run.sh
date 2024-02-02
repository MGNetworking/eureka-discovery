#!/bin/bash

name_conteneur="eureka"

docker info >/dev/null 2>&1
DOCKER_STATUS=$?

# vérifier que docker est en cours d'exécution
if [ $DOCKER_STATUS -eq 0 ]; then
  echo "Docker est en cours d'exécution."

  status=$(docker inspect --format='{{.State.Status}}' $name_conteneur >/dev/null 2>&1)

  # vérifier que le conteneur est en cours d'exécution
  if [[ $status == "running" ]]; then

    timeUTC=$(docker inspect --format='{{.State.StartedAt}}' $name_conteneur)
    conversion=$(date -d $timeUTC)
    echo "************************************"
    echo "Le conteneur $name_conteneur est en cour d'exécution depuis : $conversion"
    docker compose logs -f

    # si a l'arrêt
  elif [[ $status == "exited" ]]; then
    echo "************************************"
    echo "Lancement du conteneur $name_conteneur"
    docker container rm $name_conteneur

  else

    echo "Création de l'images est du conteneur $name_conteneur"
    docker compose build --no-cache
    docker compose up -d
    docker compose logs -f

  fi

else
  echo "Docker n'est pas en cours d'exécution."
fi
