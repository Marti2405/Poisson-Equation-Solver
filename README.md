
# Numerical Solutions for Poisson's Equation in 1D, 2D, 3D using the Finite Difference Method

This repository contains the code to solve numerically and visualise Poisson's Equation in 1D, 2D and 3D with Dirichlet and Neumann Boundary Conditions.

The solving method used is the Finite Difference method. https://en.wikipedia.org/wiki/Finite_difference_method

The programming language used is Julia.




## Files

1D_BF.jl : Numerical Approximation in 1D with Fixed Boundary Condition

1D_NBC_1O.jl : Numerical Approximation in 1D with Neumann Boundary Condition, 1st Order

2D_BF.jl : Numerical Approximation in 2D with Fixed Boundary Condition

2D_NBC_1O.jl : Numerical Approximation in 2D with Neumann Boundary Condition, 1st Order

3D_BF.jl : Numerical Approximation in 3D with Fixed Boundary Condition

## Dependecies

To run this code you will need Julia installed in your pc. You can download it here : https://julialang.org/downloads/

This code uses 3 Julia packages : SparseArrays, LinearAlgebra and PyPlot. 

To install this packages run this commands in the Julia terminal :

```Julia
  using Pkg
  Pkg.add("SparseArrays")
  Pkg.add("LinearAlgebra")
  Pkg.add("PyPlot")
```

## Run the code

To run any file use this command in terminal :

```Cmd
  julia /path/to/file.jl
```

## Author
Marti JIMENEZ : [@Marti2405](https://github.com/Marti2405)

Date : 06/2023



