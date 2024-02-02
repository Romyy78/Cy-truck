set terminal png font "arial,10"
  set output "s.png"
  set title "Option -s"
  set style data lines
  set style fill solid 0.5
  set datafile separator ";"
  set xrange [1:*]
  set xtic rotate by 45 right
  set xlabel "ID"
  set ylabel "Distance" rotate by -270
  set title "Option -s "
  plot "temp/traitement_s.txt" using 1:3:5:xtic(2) with filledcurves below title "Distance Min/Max" lc rgb "#64DC64", '' u 1:4 lc rgb "#99DC99" title "Distance Moy"
