#!/bin/bash

  while true; do
    response=$(curl -s $CONFIG_SERVICE_URI_docker/eureka/dev)

    echo "request vers : $CONFIG_SERVICE_URI_docker/eureka/dev"

    if [ -n "$response" ]; then
      echo "Le service est en cours d'exécution."
      echo "Lancement du service Eureka "
      exec java -jar app.jar
      break  # Sortir de la boucle si le service est opérationnel
    else
      echo "Le service n'est pas encore opérationnel !"
      sleep 3
    fi

  done
