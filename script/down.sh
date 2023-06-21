#!/bin/bash

image="ms-eureka-service"
mon_conteneur="eureka"
nom_reseau="blog-network"

delete_conteneur() {
  # suppression de l'images conteneuriser
  docker rmi $image
  result=$(docker images -f "reference=$image")

  # verification le code de retour de la suppression de l'image
  # if [[ $result != "" ]]; then
  if [[ $? -eq 0 ]]; then
    echo "************************************"
    echo "L'images : $image a bien été supprimer "
  else
    echo "************************************"
    echo "L'images : $image n'a pas été supprimer "
  fi
}

delete_reseau() {

  # Vérifie si le conteneur est actif
  if docker ps -f "network=blog-network" -f "status=running" --format '{{.ID}}' | grep -q .; then
    echo "Le conteneur est actif sur le réseau bridge (blog-network)."
  else
    echo "Le conteneur n'est pas actif sur le réseau bridge (blog-network)."
    docker network rm $nom_reseau
    docker network ls --filter "name=$nom_reseau"

    if [[ $? -eq 0 ]]; then
      echo "************************************"
      echo "Le réseau a été supprimé avec succès."
    else
      echo "************************************"
      echo "Échec de la suppression du réseau $nom_reseau"
    fi
  fi

}

docker compose -f ./docker/docker-compose.yml down

# Vérifier si le conteneur n'est plus en cours d'exécution
if [[ -z "$(docker ps -q -f 'status=exited' -f 'name='$mon_conteneur)" ]]; then
  echo "************************************"
  echo "Le conteneur n'est plus en cours d'exécution."

  # Recherche de l'images avant supression
  if [[ $(docker images -q $image) != "" ]]; then

    echo "************************************"
    echo "Suppression de l'images "
    delete_conteneur

    echo "************************************"
    echo "Etat du réseau $nom_reseau :  "
    delete_reseau

  else
    echo "************************************"
    echo "L'images : $image a déjà était supprimer "
  fi

else
  echo "************************************"
  echo "Le conteneur est toujours en cours d'exécution."
fi

# affichage
echo "************************************"
echo "Liste des processus en cours d'exécution : "
docker ps -a

echo "************************************"
echo "Liste des images déployées : "
docker images

echo "************************************"
echo "List des réseaux "
docker network ls
