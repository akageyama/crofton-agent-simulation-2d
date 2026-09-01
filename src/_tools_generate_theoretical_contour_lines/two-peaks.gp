reset

A = 0.60
B = 0.20
ASQ = A*A
BSQ = B*B

# peak 1: (-0.5, 0.5)
q1(x,t) = (x+t)**2/(2*ASQ) \
        + (t-x-1.0)**2/(2*BSQ)

# peak 2: (0.5, 1.5)
q2(x,t) = (x+t-2.0)**2/(2*ASQ) \
        + (t-x-1.0)**2/(2*BSQ)

f1(x,t) = exp(-q1(x,t))
f2(x,t) = exp(-q2(x,t))

f(x,t) = f1(x,t) + f2(x,t)

set xrange [-1:1]
set yrange [0:2]

set xlabel "x"
set ylabel "time"

set size ratio -1

set samples 400
set isosamples 400

set contour base
unset surface

set cntrparam levels auto 10

set table "_sgks.dat"
splot f(x,y)
unset table

# f = 0.50 の等高線だけを別に生成
set cntrparam levels discrete 0.50

set table "_sgks_50.dat"
splot f(x,y)
unset table

# 灰色の等高線の上に f=0.50 を青太線で重ねる
plot "_sgks.dat" using 1:2 \
     with lines lc rgb "#aaaaaa" lw 1.0 notitle, \
     "_sgks_50.dat" using 1:2 \
     with lines lc rgb "blue" lw 3.0 notitle

pause -1

# pngファイルに出力
set terminal pngcairo size 800,800
set output "_two_peaks.png"
replot

# 同じものをpdfファイルにも出力
set terminal pdfcairo enhanced color font "Hiragino Mincho ProN,25"
set output "_two_peaks.pdf"
replot
