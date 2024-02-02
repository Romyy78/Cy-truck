set terminal png size 1000,1152
set output 'D2.png'
set title '                                                          '
set style fill solid 
set boxwidth 0.5
 
# Configuration des axes  
set xrange [0:*] 
set yrange [0:*] 
# nom des axes
set y2label 'DISTANCE (km)' offset 3,0
set ylabel 'Option -d2 : Distance = f(driver)' 
set xlabel 'DRIVER NAMES' rotate by 180

set xtics nomirror rotate by -270 font '1' 
set ytics nomirror rotate by 90 
set offset 0.5,0,0,0
# Ajout d'une grille pour une meilleure lisibilité
set origin 0,0
set y2tics nomirror rotate by 90 out
set y2range [0:160000]

set datafile separator ';'

plot "tempD2.txt" using 2:xtic(1) with boxes lc rgb "red" notitle

