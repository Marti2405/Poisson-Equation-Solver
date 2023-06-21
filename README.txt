
# Numerical Solutions for Poisson's Equation in 1D, 2D, 3D using the Finite Difference Method

This repository contains the code to solve numerically and visualise Poisson's Equation in 1D, 2D and 3D with Dirichlet and Neumann Boundary Conditions.

The solving method used is the Finite Difference method. https://en.wikipedia.org/wiki/Finite_difference_method

The programming language used is Julia.




## Files

1D_BF.jl : Numerical Approximation in 1D with Fixed Boundary Condition

1D_NBC_2O.jl : Numerical Approximation in 1D with Neumann Boundary Condition, 2nd Order

2D_BF.jl : Numerical Approximation in 2D with Fixed Boundary Condition

2D_NBC_2O.jl : Numerical Approximation in 2D with Neumann Boundary Condition, 2nd Order

3D_BF.jl : Numerical Approximation in 3D with Fixed Boundary Condition

MorePDEs : Some other Numerical Approximation of PDEs (Heat equation, Wave equation)

## Dependecies

To run this code you will need Julia installed in your pc. You can download it here : https://julialang.org/downloads/

This code uses 4 Julia packages : SparseArrays, LinearAlgebra, PyPlot and PlotlyJS. 

To install this packages run this commands in the Julia terminal :

```Julia
  using Pkg
  Pkg.add("SparseArrays")
  Pkg.add("LinearAlgebra")
  Pkg.add("PyPlot")
  Pkg.add("PlotlyJS")
```

## Run the code

To run any file use this command in terminal :

```Cmd
  julia /path/to/file.jl
```

## Author
Marti JIMENEZ : [@Marti2405](https://github.com/Marti2405)

Date : 06/2023



