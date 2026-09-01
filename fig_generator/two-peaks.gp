reset

#L = 0.40
#W = 0.12

L = 0.60
W = 0.20

# peak 1: (-0.5, 0.5)
q1(x,t) = (x+t)**2/(2*L**2) \
        + (t-x-1.0)**2/(2*W**2)

# peak 2: (0.5, 1.5)
q2(x,t) = (x+t-2.0)**2/(2*L**2) \
        + (t-x-1.0)**2/(2*W**2)

f1(x,t) = exp(-q1(x,t))
f2(x,t) = exp(-q2(x,t))

f(x,t) = f1(x,t) + f2(x,t)

set xrange [-1:1]
set yrange [0:2]

set xlabel "x"
set ylabel "t"

set size ratio -1

set samples 400
set isosamples 400

set contour base
unset surface

set cntrparam levels auto 10

set table "contour.dat"
splot f(x,y)
unset table

plot "contour.dat" using 1:2 \
     with lines lc rgb "#aaaaaa" lw 1.0 notitle

pause -1
