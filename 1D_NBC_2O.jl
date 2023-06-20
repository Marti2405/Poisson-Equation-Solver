# Solving the PDE  uxx = f(x) in 1 Dimension, Neumann Boundary Condition (Du.n=0), 2nd Order
# You can modify the known function to test other functions (1)
# and N->the number of points to get more or less accuracy (2)
# You can also set the Boundaries (3)

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
u = []

#Boundary conditions u0 and uN
Du0 = 0 #<--------------------------------------------------------------- (3)
DuN = 0 #<--------------------------------------------------------------- (3)




# A Matrix, Au=B

# Main diagonal
md = fill(-2/h^2, N+1)

# Upper diagonal
ud = fill(1/h^2, N)
ud[1] = -2/h^2 # Boundary condition

# Lower diagonal
ld = fill(1/h^2, N)
ld[end]= -2/h^2 # Boundary condition


#Building the matrix
A = spdiagm(-1=>ld,0=>md,1=>ud)



# Right side, Know Function(kf) - Boundaries(bound)
kf = zeros(N-1)

for i in 2:N
    kf[i-1] = f(x[i])
end

kf = vcat(fill(0,1),kf,fill(0,1))

# show known function
fig2 = figure()
plot(x[2:N],kf[2:N],"go-")
title("Known function f(x)",fontsize=24)
xlabel("x")
ylabel("y")


bound = zeros(N+1) 
bound[1]=2*Du0/h
bound[end]=2*DuN/h


# B Matrix, Au=b
B = kf-bound



# Solution
u_solution = A\B



u = u_solution #adding the approximated points to the full solution array


# Show solution
fig3 = figure()
plot(x,u,"bo-")
title("Numerical Approximation of Poisson's Equation",fontsize=24)
xlabel("x")
ylabel("y")



# Display all figures
show()


