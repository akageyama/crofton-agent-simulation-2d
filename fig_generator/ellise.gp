# gnuplot

a = 0.5
b = 0.25

set parametric

set size ratio -1
set xrange [-1.0:1.0]
set yrange [0.0:2.0]

set xlabel "x"
set ylabel "t"
set grid

set terminal pngcairo size 800,800
set output "ellise.png"

plot [t=0:2*pi] a*cos(t), b*sin(t)+1.0 with lines lw 2 notitle

