# Solving the PDE  ut = D^2uxx in 1 Dimension, Neumann Boundary Condition x=0 and x=N, du/dx=0
# Modify the Initial function to test other functions (1)
# Modify N->the number of points, Diffusion Constant D, Nb of frames for the video, fps, time step dt (2)
# Modify the Neuman Boundaries (3)

using SparseArrays, Plots


# Initial Condition f(x,0)
function f(x)
    return x^2 #<--------------------------------------------------------------- (1)
end



# Parameters  #<--------------------------------------------------------------- (2)
D = 0.023 #Diffusion Constant
N = 50 #Number of points
frames = 800 #<-----Increase this value to have more frames
frames_per_second = 60 
dx = 1/N
dt = 0.3 #<-time step
x = 0:dx:1
const_diff = D^2*dt/dx^2



# Check if const_diff<=1/2 to have convergence
if const_diff>0.5
    println("The diffusion constant is to high! With the parameters given it has to be smaller than : ",sqrt(0.5*dx^2/dt))
    exit()
end


# Boundary Condition
du0 = 0 #Left #<--------------------------------------------------------------- (3)
duN = 0 #Right

bound = zeros(N+1)
bound[1]=du0*2*dx 
bound[end]=duN*2*dx

# Array of current points n=k
u = f.(x)


# A matrix, 

#upper diagonal
ud = fill(1*const_diff,N)
#lower diagonal
ld = fill(1*const_diff,N)
#Boudary Conditions
ud[1]=2*const_diff
ld[end]=2*const_diff
#diagonal
d = fill(1-2*const_diff,N+1)

A = spdiagm(-1=>ld,0=>d,1=>ud)

# Creation of animation in function of the time
println("Creating animation...")
anim = @animate for i in 1:frames
    global x,u
    plot(x,u,xaxis=("x",(0,1)),yaxis=("y",(0,1))) #update plot
    u = A*u - bound #update array of current points
end

#save animation
gif(anim,"1D_Heat_NBC_Anim.mp4",fps=frames_per_second)


