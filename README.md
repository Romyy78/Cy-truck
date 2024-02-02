# Cy-truck

Bienvenue dans le Projet CY-Trucks de Ghilas Bougdal, Roméo Atchori et Leon Chen




Utilisation du programme :

Il faut insérer le fichier à trier (data.csv) dans le dossier "data" prévu pour cela.
Pour lancer le programme il suffit d'entrer la commande : ./ tout.sh data.csv (traitement)
par exemple pour lancer le traitement d1 on écrit : ./ tout.sh data.csv -d1

``` sh
  les traitements sont ci-dessous:

    -d1 : Afficher les 10 conducteurs ayant effectué le plus grand nombre de trajets, triés par ordre décroissant du nombre de trajets.

    -d2 : Afficher les 10 conducteurs ayant parcouru la plus longue distance, triés par ordre décroissant de la distance totale parcourue.

    -l : Afficher les 10 numéros d'identifiant des trajets ayant la plus longue distance, triés par ordre décroissant de cette distance.

    -t : Afficher les 10 villes avec le plus grand nombre de trajets, triées par ordre alphabétique.

    -s : Afficher les 50 numéros d'identifiant des trajets présentant la plus grande différence entre la distance maximale et minimale parcourue, triés par ordre décroissant de cette différence.

    Si vous avez un promblème tapez : ./tout.sh data.csv -h


```






Lorsque vous aurez executé un des arguments, le graphique qui correspond au traitement choisi s'affichera automatiquement. Vous pouvez egalement  retrouver ce graphique dans le dossier "images" ainsi que les resulats du traitements dans le document "temp"
