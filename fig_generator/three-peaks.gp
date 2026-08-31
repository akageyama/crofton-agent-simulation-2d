#

a  = 0.4
b  = 0.2
tc = 1.0

# Fortran の field(x, timespan_center) に対応

field1(x,t) = x**2/a**2 \
            + (t - tc + tc/2.0)**2/b**2 - 1.0

xp(x) = (x >= 0.0) ? x - tc/2.0 : -x - tc/2.0

field2(x,t) = xp(x)**2/a**2 \
            + (t - tc - tc/2.0)**2/b**2 - 1.0

field(x,t) = (t < tc) ? field1(x,t) : field2(x,t)

set xrange [-1:1]
set yrange [0:2]

set xlabel "x"
set ylabel "t"

set size ratio -1


set contour base
unset surface
set view map

# set cntrparam levels discrete 0.0

set samples 300
set isosamples 300

# splot field(x,y)


# 等高線を一旦ファイルに出力する
set table "positive.dat"
set cntrparam levels discrete 0.2,0.4,0.6,0.8,1.0,1.2,1.4,1.6,1.8
splot field(x,y)
unset table

set table "negative.dat"
set cntrparam levels discrete -1.0,-0.8,-0.6,-0.4,-0.2
splot field(x,y)
unset table

set table "zero.dat"
set cntrparam levels discrete 0.0
splot field(x,y)
unset table


# 正：灰色実線
# 負：灰色点線
plot "positive.dat" w l lc rgb "gray" lw 1.5 dt 1 notitle, \
     "negative.dat" w l lc rgb "gray" lw 1.5 dt 2 notitle, \
     "zero.dat"     w l lc rgb "blue" lw 2.0 dt 1 notitle


pause -1
