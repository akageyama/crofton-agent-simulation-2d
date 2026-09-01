reset

mymax(a,b) = (a > b) ? a : b

#---------------------------
# peak positions
#---------------------------
x1 = -0.5
t1 =  0.5

x2 = -0.5
t2 =  1.5

x3 =  0.5
t3 =  1.5

# branching point
xj = -0.1
tj =  1.0

# longitudinal / transverse widths
L = 0.38
W = 0.09


#---------------------------
# directions of the three arms
#---------------------------

# incoming arm: peak 1 -> junction
vx1 = xj-x1
vt1 = tj-t1
r1  = sqrt(vx1**2 + vt1**2)

# upper-left arm: junction -> peak 2
vx2 = x2-xj
vt2 = t2-tj
r2  = sqrt(vx2**2 + vt2**2)

# upper-right arm: junction -> peak 3
vx3 = x3-xj
vt3 = t3-tj
r3  = sqrt(vx3**2 + vt3**2)


#---------------------------
# coordinates parallel and perpendicular
# to each arm
#---------------------------

s1(x,t) = ( vx1*(x-x1) + vt1*(t-t1))/r1
n1(x,t) = (-vt1*(x-x1) + vx1*(t-t1))/r1

s2(x,t) = ( vx2*(x-x2) + vt2*(t-t2))/r2
n2(x,t) = (-vt2*(x-x2) + vx2*(t-t2))/r2

s3(x,t) = ( vx3*(x-x3) + vt3*(t-t3))/r3
n3(x,t) = (-vt3*(x-x3) + vx3*(t-t3))/r3


#---------------------------
# elongated Gaussian peaks
#---------------------------

f1(x,t) = exp( -s1(x,t)**2/(2*L**2) \
               -n1(x,t)**2/(2*W**2) )

f2(x,t) = exp( -s2(x,t)**2/(2*L**2) \
               -n2(x,t)**2/(2*W**2) )

f3(x,t) = exp( -s3(x,t)**2/(2*L**2) \
               -n3(x,t)**2/(2*W**2) )


# IMPORTANT:
# sumではなくmaximumを取る
# f(x,t) = mymax(f1(x,t), mymax(f2(x,t),f3(x,t)))
f(x,t) = f1(x,t) + f2(x,t) + f3(x,t)


#---------------------------
# contour plot
#---------------------------

set xrange [-1:1]
set yrange [0:2]

set xlabel "x"
set ylabel "t"

set size ratio -1

set samples 400
set isosamples 400

set contour base
unset surface

set cntrparam levels auto 30

set table "contour.dat"
splot f(x,y)
unset table

plot "contour.dat" using 1:2 \
     with lines lc rgb "#aaaaaa" lw 1.0 notitle

pause -1
