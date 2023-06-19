#!/bin/bash
# NB git bash ne peut lancer ce fichier

destination="docker/.env"

# Récupération de l'adresse IP de la machine
IP=$(hostname -I | awk '{print $1}')
echo "Adresse IP : ${IP}"

# construction de l'uri
URI="http://${IP}:8089"
echo "Adresse URI : ${URI}"

# Vérification si le fichier de destination existe
if [ -f "$destination" ]; then
  # Extraction de la valeur actuelle de IP_DEV
  IP_DEV=$(sed -n 's/^IP_DEV=//p' "$destination")
  echo "Valeur actuelle de IP_DEV : ${IP_DEV}"
else
  echo "Le fichier de destination $destination n'existe pas."
  exit 1
fi

# Vérification si IP_DEV est déjà définie
if [ -z "$IP_DEV" ]; then
  echo "IP_DEV est déjà définie à la valeur : ${IP_DEV}"
else

# Copie de la chaîne de caractères au bon emplacement
  awk -v str="$URI" 'BEGIN {FS=OFS="="} $1=="IP_DEV" && NF==2 {$2=str; copied=1} 1;
  END {if (!copied) print "IP_DEV="str}' "$destination" > temp_file && mv temp_file "$destination"


  # Vérification de la copie
  if grep -q "^IP_DEV=$URI$" "$destination"; then
    #echo "La chaîne a été copiée avec succès à la 2e ligne et à la 8e position du fichier $fichier_dest."
    echo "La variable a été initialiser "
  else
    echo "Erreur lors de la copie de la chaîne dans le fichier $destination."
  fi
fi