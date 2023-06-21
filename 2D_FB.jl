#Solving the PDE  uxx = f(x,y) in 2 Dimensions, Fixed Boundary Conditions
# You can modify the known function to test other functions (1)
# and N->the number of points to get more or less accuracy (2)
# You can also set the fixed boundaries (3.1)(3.2)

using SparseArrays, LinearAlgebra, PyPlot


#known function
function f(x,y)
    return 10*(x^2+y^2) #<--------------------------------------------------------------- (1)
end


# Parameters 
N = 500 #<--------------------------------------------------------------- (2)
h = 1/N
x = 0:h:1
y = 0:h:1


# Solution array
u = zeros(N+1,N+1)

# Boundary conditions
# u(x,0)=sin(2πx),     0≤x≤1, lower
# u(x,1)=sin(2πx),     0≤x≤1, upper
# u(0,y)=2sin(2πy),     0≤y≤1, left
# u(1,y)=2sin(2πy),     0≤y≤1, right
for i in 1:N #<--------------------------------------------------------------- (3.1)
    u[i,1]=sin(2*pi*x[i]) #Left
    u[i,N+1]=sin(2*pi*x[i]) #Right
    u[1,i]=2*sin(2*pi*y[i]) #Top
    u[N+1,i]=2*sin(2*pi*y[i]) #Bottom
end

# Show boundaries
fig2 = figure()
cm = get_cmap(:plasma)
plot_wireframe(x,y,u,cmap=cm)
xlabel("x")
ylabel("y")
zlabel("z")
title("Boundary Values", fontsize=24, y=1.08)




# A matrix, Au=B
N2 = (N-1)^2 # Nb of unknown points
#supper diagonal
spd = fill(1/h^2,(N2)-N+1)
#sub diagonal
sbd = fill(1/h^2,(N2)-N+1)

#upper diagonal
ud = fill(1/h^2,N2-1)
for i in N-1:N-1:N2-1
    ud[i]=0 # to take in count boundary condition
end
#lower diagonal
ld = ud
#diagonal
d = fill(-4/h^2,N2)

A = spdiagm(-(N-1)=>sbd,-1=>ld,0=>d,1=>ud,N-1=>spd)


# # Show Matrix
# fig3 = figure()
# imshow(A)
# colorbar(label="Matrix elements values")
# title("Matrix A",fontsize=24)

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
    bound[i] += sin(2*pi*x[i+1])/h^2 #bottom
    bound[i+(N-1)*(N-2)] += sin(2*pi*x[i+1])/h^2 #top

    bound[1+(i-1)*(N-1)] +=  2*sin(2*pi*y[i+1])/h^2 #left
    bound[(N-1)*i] += 2*sin(2*pi*y[i+1])/h^2 #right
end

# Right side
B = kf-bound

#Solution
u_solution = A\B 
#adding the solution to the boundaries
u[2:N,2:N] = reshape(u_solution,N-1,N-1)


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



