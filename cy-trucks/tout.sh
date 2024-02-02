#!/bin/bash

# Nom des arguments
fichier_csv="$1"
traitement="$2"

#Nom de l'exécutable C
executable="projet"

#Vérification de la présence de l'exécutable
if [ ! -x "$executable" ]; then
   echo "L'exécutable n'est pas présent. Compilation en cours..."
   #Compilation du programme C
   make build
   #Vérification du déroulement de la compilation
   if [ $? -eq 0 ]; then
       echo "Compilation réussie. L'exécutable $executable a été créé."
   else
       echo "Erreur lors de la compilation."
       exit 1
   fi
else
    echo "L'exécutable $executable existe déjà."
fi

# Nom des dossiers
temp="./temp"
images="./images"

# Vérification de l'existence du dossier temp
if [ ! -d "$temp" ]; then
    echo "Le dossier temp n'existe pas, création en cours..."
    mkdir -p "$temp"
else
    echo "Le dossier temporaire existe. Vidage en cours..."
    rm -rf "$temp"/*
fi

# Vérification de l'existence du dossier images
if [ ! -d "$images" ]; then
    echo "Le dossier d'images n'existe pas, création en cours..."
    mkdir -p "$images"
fi

# Fonction pour vérifier l'existence du fichier CSV
check_csv_existence() {
    if [ ! -f "$fichier_csv" ]; then
        echo "Le fichier $fichier_csv n'existe pas."
        exit 1
    fi
}

# Fonction pour filtrer et trier les lignes avec l'étape 1
filter_and_sort() {
    awk -F';' '$2 == "1" {print}' "$fichier_csv" > "$temp_file"
    sort -t';' -k6,6 "$temp_file" > "${temp_file}_sorted"
    mv "${temp_file}_sorted" "$temp_file"
}

# Vérifier si le dossier "images" est vide.
if [ -z "$(ls -A images)" ]; then
    # Le dossier "images" est vide
    echo "Le dossier images est déja vide"
else
    # Déplacer les fichiers .png du dossier "images" vers "demo"
    mv images/*.png demo
    echo "Le dossier images a été vidé"
fi


# Analyse des traitements
 case $traitement in
    # Affichage du message d'aide
    -h)
        cat help.txt;;
    
    # Traitement -d1
    -d1)

	temps_debut=$(date +%s)

        temp_file="temp.txt"
        check_csv_existence
        filter_and_sort


        
        conducteurs_plus_frequents=$(awk -F';' '{print $6}' "$temp_file" | sort | uniq -c | sort -nr | head -n 10)
        

        # Afficher les 10 conducteurs les plus fréquents avec leur nom de famille
        echo "Les 10 conducteurs les plus fréquents dans le fichier $temp_file :"
        echo "$conducteurs_plus_frequents" > tmpD1.txt

        while read -r line; do
            prenom=$(echo "$line" | awk '{print $2}')
            nom=$(awk -F';' -v p="$prenom" '$6 ~ p {print $7}' "$temp_file" | sort -u)
        done <<< "$conducteurs_plus_frequents"

        awk '{print $2, $3 ";" ,$1}' tmpD1.txt > tempD1.txt
        rm tmpD1.txt
        rm "$temp_file"


        gnuplot D1.gnu
        convert -rotate 90 big_test.png bigtest.png
        rm big_test.png
        mv "bigtest.png" "$images"
        temps_fin=$(date +%s)
        temps_total=$((temps_fin - temps_debut))
	echo "Le fichier a été traité en $temps_total secondes."
         
        chemin_c="./images/bigtest.png"
        xdg-open "$chemin_c"
        
         

        ;;

    # Traitement -d2
    -d2)
    	temps_debut=$(date +%s)
        temp_file="temp.txt"
        check_csv_existence

        
        awk -F ';' '{total[$6]+=$5} END {for (i in total) print total[i], i}' "$fichier_csv" | sort -k1nr | head -n 10 > tmpD2.txt 
        

        awk '{print $2, $3 ";" ,$1}' tmpD2.txt > tempD2.txt
        rm tmpD2.txt

        gnuplot D2.gnu 
        temps_fin=$(date +%s)
        temps_total=$((temps_fin - temps_debut))
        echo "Le fichier a été traité en $temps_total secondes."

        convert -rotate 90 D2.png histogram_D2.png
        rm D2.png
        mv "histogram_D2.png" "$images"
        chemin_D="./images/histogram_D2.png"
	xdg-open "$chemin_D"



        ;;

    # Traitement -l
    -l)
	temps_debut=$(date +%s)
        temp_file="temp.txt"
        check_csv_existence

        temps_debut=$(date +%s)
        LC_NUMERIC=C awk -F ';' '{distance[$1]+=$5} END {for (i in distance) print i, distance[i]}' "$fichier_csv" | sort -k2nr,2 | head -n 10 | sort -k1nr,1 > resultatsL.txt
        

        gnuplot L.gnu 
	mv "L.png" "$images"
	temps_fin=$(date +%s)
        temps_total=$((temps_fin - temps_debut))
        echo "Le fichier a été traité en $temps_total secondes."
	chemin_L="./images/L.png"
	xdg-open "$chemin_L"
	mv "resultatsL.txt" "$temp"

        ;;


  #Traitement -t
-t)



	temps_debut=$(date +%s)
	temp_file="temp.txt"
    echo "Execution du traitement -t en cours..."
    ./projet "$fichier_csv" -t "$temp/traitement_t.txt"
    
    
    

     gnuplot t.gnu
     mv "traitement_t.png" "$images"
     temps_fin=$(date +%s)
     temps_total=$((temps_fin - temps_debut))
     echo "Le fichier a été traité en $temps_total secondes."
     cheminT="./images/traitement_t.png"
     xdg-open "$cheminT"
     ;;
    
        
-s)    
   #Traitement S


  echo "Execution du traitement -s en cours..."
  temp_file="temp.txt"
  ./projet "$fichier_csv" -s "$temp/traitement_s.txt"
   gnuplot s.gnu
   
   chemin_S="./images/traitement_s.png"
   xdg-open "$chemin_S"
     ;;
  
  
  # Par défaut
    *)
        echo "Le traitement saisi n'existe pas"
        ;;
        
        
esac

#mv *.png $images
#mv *.txt $temp
