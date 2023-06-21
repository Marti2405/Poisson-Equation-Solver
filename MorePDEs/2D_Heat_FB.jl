# Solving the PDE  ut = D^2(uxx+uyy) in 2 Dimensions, Fixed Boundary Condition
# Modify the Initial function to test other functions (1)
# Modify N->the mesh size, Diffusion Constant D, Nb of frames for the video, fps, time step dt (2)
# Modify the fixed Boundaries (3.1)(3.2)

using SparseArrays, Plots


# Initial Condition f(x,0)
function f(x,y)
    return x^2+y^2 #<--------------------------------------------------------------- (1)
end



# Parameters  #<--------------------------------------------------------------- (2)
D = 0.025 #Diffusion Constant
N = 50 # Mesh size 
h = 1/N
frames = 2000 #<-----Increase this value to have more frames
frames_per_second = 60 
dt = 0.1 #<-time step
x = 0:h:1
y = 0:h:1
const_diff = D^2*dt/h^2

# Check if const_diff<=1/2 to have convergence
if const_diff>0.5
    println("The diffusion constant is to high! With the parameters given it has to be smaller than : ",sqrt(0.5*h^2/dt))
    exit()
end


# Current points array
u = zeros(N+1,N+1)
u = [f(xi,yi) for xi in x, yi in y]
println(size(u))
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



# A matrix 
N2 = (N-1)^2 # Nb of unknown points
#supper diagonal
spd = fill(1*const_diff,(N2)-N+1)
#sub diagonal
sbd = fill(1*const_diff,(N2)-N+1)

#upper diagonal #lower diagonal
ud = fill(1*const_diff,N2-1)
ld = fill(1*const_diff,N2-1)
for i in N-1:N-1:N2-1
    ud[i]=0 # to take in count boundary condition
    ld[i]=0 # to take in count boundary condition
end


#diagonal
d = fill(1-4*const_diff,N2)

A = spdiagm(-(N-1)=>sbd,-1=>ld,0=>d,1=>ud,N-1=>spd)


# Boundary
bound = zeros((N-1)^2)

for i in 1:N-1 #<--------------------------------------------------------------- (3.2)
    bound[i] += sin(2*pi*x[i+1])/h^2 #bottom
    bound[i+(N-1)*(N-2)] += sin(2*pi*x[i+1])/h^2 #top

    bound[1+(i-1)*(N-1)] +=  2*sin(2*pi*y[i+1])/h^2 #left
    bound[(N-1)*i] += 2*sin(2*pi*y[i+1])/h^2 #right
end


# Creation of animation in function of the time
println("Creating animation...")
anim = @animate for i in 1:frames
    global x,y,u
    heatmap(x,y,u,xaxis=("x",(0,1)),yaxis=("y",(0,1)),zaxis=("z",(0,1)),c=:thermal) #update plot
    u[2:N,2:N] = A*u[2:N,2:N][:]+const_diff.*bound #update array of current points
    
end

#save animation
gif(anim,"2D_Heat_FB_Anim.mp4",fps=frames_per_second)


