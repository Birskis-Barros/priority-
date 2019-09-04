using Distributed
using Combinatorics
using LinearAlgebra
using SharedArrays
using Distributions
using SpecialFunctions
using LightGraphs
using RCall
using HDF5
using SparseArrays

#Interaction matrix
include("$(homedir())/Dropbox/PhD/ENIgMA/src/intmatrixv3.jl")

#Community dynamics
include("$(homedir())/Dropbox/PhD/ENIgMA/src/preamble_defs.jl")
include("$(homedir())/Dropbox/PhD/ENIgMA/src/assembly.jl")

#Analysis Calculations
include("$(homedir())/Dropbox/PhD/ENIgMA/src/structure.jl")
include("$(homedir())/Dropbox/PhD/ENIgMA/src/dynstructure.jl")

#Analysis functions
include("$(homedir())/Dropbox/PhD/ENIgMA/src/trophicalc2.jl")
include("$(homedir())/Dropbox/PhD/ENIgMA/src/roverlap.jl")
include("$(homedir())/Dropbox/PhD/ENIgMA/src/potcol.jl")
