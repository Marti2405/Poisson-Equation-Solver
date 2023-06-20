#Solving the PDE  uxx = f(x,y) in 3 Dimensions, 2nd Order
# Fixed Boundary Condition
# You can modify the known function to test other functions (1)
# and N->the number of points to get more or less accuracy (2)
# You can also set the boundaries (3.1)(3.2)

using SparseArrays, LinearAlgebra, PyPlot
import PlotlyJS


#known function
function f(x,y,z)
    return x^2+0.4 #<--------------------------------------------------------------- (1)
end




# Parameters 
N = 5 #<--------------------------------------------------------------- (2)
h = 1/N
x = 0:h:1
y = 0:h:1
z = 0:h:1

# Show Known function

X, Y, Z = PlotlyJS.mgrid(x, y, z)

values = f.(X,Y,Z)

p = PlotlyJS.plot(PlotlyJS.volume(
    x=X[:],
    y=Y[:],
    z=Z[:],
    value=values[:],
    isomin=0.1,
    isomax=1.1,
    opacity=0.1, # needs to be small to see through all surfaces
    surface_count=17, # needs to be a large number for good volume rendering
))
display(p)
display(values)


# Solution array
u = zeros(N+1,N+1,N+1)


# Boundary conditions
# u(x,0)=sin(2πx),     0≤x≤1, lower
# u(x,1)=sin(2πx),     0≤x≤1, upper
# u(0,y)=2sin(2πy),     0≤y≤1, left
# u(1,y)=2sin(2πy),     0≤y≤1, right
for i in 2:N, j in 2:N #<--------------------------------------------------------------- (3.1)
    u[i,1,j]=   0 #Left
    u[i,N+1,j]= 0 #Right
    u[1,i,j]=   0 #Top
    u[N+1,i,j]= 0 #Bottom
    u[i,j,1]=   0 #Front
    u[i,j,N+1]= 0 #Back
end
# Edges
for i in 1:N+1
    # Front
    u[1,i,1] =     0
    u[i,1,1] =     0
    u[N+1,i,1] =   0
    u[i,N+1,1] =   0
    # Sides
    u[1,1,i] =     0
    u[1,N+1,i] =   0
    u[N+1,1,i] =   0
    u[N+1,N+1,i] = 0
    # Back
    u[1,i,N+1] =   0
    u[N+1,i,N+1] = 0
    u[i,N+1,N+1]=  0
    u[i,1,N+1] =   0
end
#corners
u[1,1,1]=       0
u[N+1,1,1]=     0
u[1,N+1,1]=     0
u[1,1,N+1]=     0 
u[N+1,N+1,1]=   0
u[N+1,1,N+1]=   0
u[1,N+1,N+1]=   0
u[N+1,N+1,N+1]= 0


# Number of unknown
N2 = (N-1)^3



# A matrix, Au=B

#supper upper diagonal
spud = fill(1/h^2,(N2)-(N-1)^2)
#sub low diagonal
sbld = fill(1/h^2,(N2)-(N-1)^2)

#supper diagonal
spd = fill(1/h^2,(N2)-(N-1))
#sub diagonal
sbd = fill(1/h^2,(N2)-(N-1))

#upper diagonal
ud = fill(1/h^2,N2-1)
for i in N-1:N-1:N2-1
    ud[i]=0 # to take in count boundary condition
end
#lower diagonal
ld = ud
#diagonal
d = fill(-4/h^2,N2)

A = spdiagm(-(N-1)^2=>sbld,-(N-1)=>sbd,-1=>ld,0=>d,1=>ud,N-1=>spd,(N-1)^2=>spud)

# Show Matrix
fig3 = figure()
imshow(A)
colorbar(label="Matrix elements values")
title("Matrix A",fontsize=24)



# Right side, Know Function(kf) - Boundaries(bound)
kf = zeros((N-1)^3)

for i in 1:N-1, j in 1:N-1 , p in 1:N-1
    # compute the value at this point and fill the array
    kf[i+(N-1)*(j-1)+(N-1)^2*(p-1)] = f(x[i+1],y[j+1],z[p+1]) 
end


bound = zeros((N-1)^3)

count = 0

for i in 1:N-1, j in 1:N-1 #<--------------------------------------------------------------- (3.2)
    global count+=1 
    bound[i+(N-1)^2*(j-1)] += 0 #bottom
    bound[(N-1)*(N-2)+i+(j-1)*(N-1)*(N-1)] += 0 #top

    bound[i+(N-1)*(j-1)] += 2 #left
    bound[i+(N-1)*(j-1)+(N-1)^3-(N-1)^2] +=   0 #right
    
    bound[(count-1)*(N-1)+1] += 0 #front
    bound[(count-1)*(N-1)+(N-1)] += 0 #back
       
end

# Right side
B = kf-bound

#Solution
u_solution = -A\B 

count = 0
# reshape the solution to 3D matrix right : x, up : y, in : z and adding it to the full 3D array
for i in 1:N-1, j in 1:N-1, p in 1:N-1
    global count+=1
    u[(N)-j%N+1,(i)%(N)+1,p%(N)+1] = u_solution[count]
end

display(u)




# Show solution



p = PlotlyJS.plot(PlotlyJS.volume(
    x=X[:],
    y=Y[:],
    z=Z[:],
    value=u[:],
    isomin=-0.6,
    isomax=0.6,
    opacity=0.3, # needs to be small to see through all surfaces
    surface_count=17, # needs to be a large number for good volume rendering
))
sleep(2)
display(p)
sleep(2)
readline()


