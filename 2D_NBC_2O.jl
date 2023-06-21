#Solving the PDE  uxx = f(x,y) in 2 Dimensions, 2nd Order
# Neumann Boundary condition -> x=0, du/dx=0
# Dirichlet Boundary condition = 0 on all the other sides
# You can modify the known function to test other functions (1)
# and N->the number of points to get more or less accuracy (2)
# You can also set the boundaries (3.1)(3.2)

using SparseArrays, LinearAlgebra, PyPlot



#known function
function f(x,y)
    return 1 #<--------------------------------------------------------------- (1)
end


# Parameters 
N = 500 #<--------------------------------------------------------------- (2)
h = 1/N # uniform mesh size
x = 0:h:1
y = 0:h:1
X,Y = repeat(x',N+1,1),repeat(y,1,N+1)


# Solution array
u = zeros(N+1,N+1)

# Boundary conditions
# u(x,0)=sin(2πx),     0≤x≤1, lower
# u(x,1)=sin(2πx),     0≤x≤1, upper
# u(0,y)=2sin(2πy),     0≤y≤1, left
# u(1,y)=2sin(2πy),     0≤y≤1, right
for i in 1:N #<--------------------------------------------------------------- (3.1)
    u[i,1]=0 #Left
    u[i,N+1]=0 #Right
    u[1,i]=0 #Top
    u[N+1,i]=0 #Bottom
end




# A matrix, Au=B
N2 = (N-1)^2 # Nb of unknown points
#supper diagonal
spd = fill(1/h^2,(N2)-N+1)
spd_add = fill(2/h^2,N-1) # Neumann BC
spd = vcat(spd_add,spd)

#sub diagonal
sbd = fill(1/h^2,(N2)-N+1)
sbd_add = fill(1/h^2,N-1) # Neumann BC
sbd = vcat(sbd_add,sbd)

#upper diagonal
ud = fill(1/h^2,N2-1)
for i in N-1:N-1:N2-1
    ud[i]=0; # to take in count boundary condition
end
ud_add = fill(1/h^2,N-1) # Neumann BC
ud_add[N-1]=0
ud = vcat(ud_add,ud)
#lower diagonal
ld = ud
#diagonal
d = fill(-4/h^2,N2)
d_add = fill(-4/h^2,N-1) # Neumann BC
d = vcat(d_add,d)
A = spdiagm(-(N-1)=>sbd,-1=>ld,0=>d,1=>ud,N-1=>spd)


# Right side, Know Function(kf) - Boundaries(bound)
kf = zeros((N-1)^2)

for i in 1:N-1, j in 1:N-1
    # compute the value at this point and fill the array
    kf[i+(N-1)*(j-1)] = f(x[i+1],y[j+1]) 
end

# Show Known Function
kf_show = reshape(kf,N-1,N-1)
kf_show = reverse(kf_show,dims=1)
fig4 = figure()
plot_surface(h:h:1-h,h:h:1-h,kf_show)
title("Known Function f(x,y)",fontsize=24)
xlabel("x")
ylabel("y")
zlabel("z")


bound = zeros((N-1)^2)

for i in 1:N-1 #<--------------------------------------------------------------- (3.2)
    bound[i] += 0 #bottom
    bound[i+(N-1)*(N-2)] += 0 #top

    bound[1+(i-1)*(N-1)] +=  0 #left 
    bound[(N-1)*i] += 0 #right
end
bc_bound = 0 #<-- This value represents the Neumann BC x=0, du/dx = value
bc_bound = fill(bc_bound,N-1)

bound = vcat(bc_bound,bound) # adding on top of the boudary array

kf = vcat(fill(0,N-1),kf) # adapting dimension
# Right side
B = kf-bound

#Solution
u_solution = -A\B 

#adding the solution to the boundaries
u[2:N,1:N] = reshape(u_solution,N-1,N)


#Show Solution
fig5 = figure()
cm = get_cmap(:plasma)
plot_surface(x,y,u,cmap=cm)
xlabel("x")
ylabel("y")
zlabel("z")
title("Numerical Approximation of Poisson's Equation",fontsize=24)



#display all graphs
show()


