
# Numerical Solutions for Heat and Wave Equations in 1D using the Finite Difference Method

This folder contains the code to solve numerically and visualise Heat and Wave Equations in 1D with Dirichlet and Neumann Boundary Conditions.

The solving method used is the Finite Difference method. https://en.wikipedia.org/wiki/Finite_difference_method

The programming language used is Julia.




## Files

1D_Heat_FB.jl : Numerical Approximation of the Heat equation in 1D with Fixed Boundary Condition

1D_Heat_NBC.jl : Numerical Approximation of the Heat equation in 1D with Neumann Boundary Condition

2D_Heat_FB.jl : Numerical Approximation of the Heat equation in 2D with Fixed Boundary Condition

1D_Wave_FB.jl : Numerical Approximation of Wave equation in 1D


## Dependecies

To run this code you will need Julia installed in your pc. You can download it here : https://julialang.org/downloads/

This code uses 2 Julia packages : SparseArrays and PyPlot. 

To install this packages run this commands in the Julia terminal :

```Julia
  using Pkg
  Pkg.add("SparseArrays")
  Pkg.add("PyPlot")
```

## Run the code

To run any file use this command in terminal :

```Cmd
  julia /path/to/file.jl
```

All the Numerical Solution animations will be saved in mp4 format to the directory containinf the julia files.

## Author
Marti JIMENEZ : [@Marti2405](https://github.com/Marti2405)

Date : 06/2023



