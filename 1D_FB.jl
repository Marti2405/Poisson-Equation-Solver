# Solving the PDE  uxx = f(x) in 1 Dimension, Fixed Boundary Condition
# You can modify the known function to test other functions (1)
# and N->the number of points to get more or less accuracy (2)
# You can also set the fixed Boundaries (3)

using SparseArrays, LinearAlgebra, PyPlot


#knonw function f
function f(x) 
    return x^2+100 #<--------------------------------------------------------------- (1)
end


#parameters
N = 200 #<--------------------------------------------------------------- (2)
h = 1/N
x = 0:h:1


# Solution array
u = zeros(N+1)

#Boundary conditions u0 and uN
u0 = 2 #<--------------------------------------------------------------- (3)
uN = 7 #<--------------------------------------------------------------- (3)
u[1]+=u0
u[N+1]+=uN

# Show boundaries
fig1 = figure()
plot([x[1],x[end]],[u[1],u[end]],"ro")
title("Boundary Conditions",fontsize=24)
xlabel("x")
ylabel("y")



# A Matrix, Au=B
N2 = N-1 # nb of unknown points

# Main diagonal
md = fill(-2/h^2, N2)

# Upper diagonal
ud = fill(1/h^2, N2-1)

# Lower diagonal
ld = fill(1/h^2, N2-1)

#Building the matrix
A = spdiagm(-1=>ld,0=>md,1=>ud)



# Right side, Know Function(kf) - Boundaries(bound)
kf = zeros(N2)

for i in 2:N
    kf[i-1] = f(x[i])
end

# show known function
fig2 = figure()
plot(x[2:N],kf,"go-")
title("Known function f(x)",fontsize=24)
xlabel("x")
ylabel("y")


bound = zeros(N2)
bound[1]=u0/h^2
bound[N-1]=uN/h^2


# B Matrix, Au=b
B = kf-bound


# Solution
u_solution = A\B

u[2:N] = u_solution #adding the approximated points to the full solution array

# Show solution
fig3 = figure()
plot(x,u,"bo-")
title("Numerical Approximation of Poisson's Equation",fontsize=24)
xlabel("x")
ylabel("y")



# Display all figures
show()


