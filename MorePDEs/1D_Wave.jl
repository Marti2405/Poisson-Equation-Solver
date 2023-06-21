#Solving the PDE  utt = c^2*uxx + f(x,t) in 1 Dimensions
# Fixed Boundary condition of 0 for the x axis
# Neumann Boundary condition for the t axis d(x,0)/dt=0


###################################################
# For this example we take : f(x,t)=0, c=1
# The analytical solution of this equation is u(x,t)=sin(pi*x)*[cos(pi*t)+sin(pi*t)/pi]
#
###################################################
using PyPlot

# Parameters
nx = 100
nt = 300
a = 0
b = 1
t0 = 0
tf = 2

dx = (b-a)/(nx-1)
dt = (tf-t0)/(nt-1)
x = a:dx:b
t = t0:dt:tf

s = dt^2/dx^2
# if s>1 then the error increases exponnentially
if s>1
    println("s value to high (s=dt^2/dx^2). It has to be < 1 and it's : ",s)
    exit()
end

# Analytical solution
uA = zeros(nx,nt) #each column in the matrix represents all the points ux at the time t of the column
for i in 1:nx, j in 1:nt
    uA[i,j]=sin(pi*x[i])*  (cos(pi*t[j]) + sin(pi*t[j])/pi)
end

#Show analytical solution
fig1 = figure()
cm = get_cmap(:plasma)
plot_surface(t,x,uA,cmap=cm)
title("Analytical Solution")
xlabel("t")
ylabel("x")



# Numerical Solution
uN = zeros(nx,nt)

#Initial Conditions and Neumann Boundary condition for time du(x,0)/dt=0
uN[:,1]=sin.(pi*x)
uN[:,2]=sin.(pi*x).*(1+dt)

for j in 2:nt-1, i in 2:nx-1 # i represents x, j represents time
    uN[i,j+1]= s*(uN[i-1,j]-2*uN[i,j]+ uN[i+1,j]) + 2*uN[i,j] - uN[i,j-1] #<-this last term is why we need the Neumann Boudary condition for t
end
# we have fixed boundary condition of 0 for both sides of x so we don't need to update the first or last row of uN


#Show numerical solution
fig2 = figure()
plot_surface(t,x,uN,cmap=cm)
title("Numerical Solution")
xlabel("t")
ylabel("x")



# Error of the numerical solution
uE = abs.(uN-uA)

#Show error
fig3 = figure()
plot_surface(t,x,uE,cmap=cm)
title("Error")
xlabel("t")
ylabel("x")


#Display all
show()
