#!/bin/bash

# Nom du fichier CSV d'entrée
input_csv="trajet_diff.csv"
 
# Vérifier si le fichier CSV d'entrée existe
if [ ! -f "$input_csv" ]; then
  echo "Le fichier $input_csv n'existe pas."
  exit 1
fi

# Utilisation d'awk pour extraire et compter les conducteurs de la 6ème colonne
# Ensuite, utilise sort et uniq pour compter les occurrences de chaque conducteur
# Enfin, utilise sort, head et awk pour obtenir les 10 conducteurs les plus fréquents
conducteurs_plus_frequents=$(awk -F';' '{print $6}' "$input_csv" | sort | uniq -c | sort -nr | head -n 10)

# Afficher les 10 conducteurs les plus fréquents avec leur nom de famille
echo "Les 10 conducteurs les plus fréquents dans le fichier $input_csv :"
while read -r line; do
  prenom=$(echo "$line" | awk '{print $2}')
  nom=$(awk -F';' -v p="$prenom" '$6 ~ p {print $7}' "$input_csv" | sort -u)
  echo "$prenom $nom $line"
done <<< "$conducteurs_plus_frequents"

# Fin du script

