using Pkg
Pkg.add("Documenter")
Pkg.instantiate()
include("docs/make.jl")
Pkg.rm("Documenter")
Pkg.gc()