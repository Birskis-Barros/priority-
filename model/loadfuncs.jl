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
include("$(homedir())/Dropbox/PhD/ENIgMA_Code/model/intmatrixv3.jl")

#Community dynamics
include("$(homedir())/Dropbox/PhD/ENIgMA_Code/model/preamble_defs.jl")
include("$(homedir())/Dropbox/PhD/ENIgMA_Code/model/assembly.jl")

#Analysis Calculations
include("$(homedir())/Dropbox/PhD/ENIgMA_Code/model/structure.jl")
include("$(homedir())/Dropbox/PhD/ENIgMA_Code/model/dynstructure.jl")

#Analysis functions
include("$(homedir())/Dropbox/PhD/ENIgMA_Code/model/trophicalc2.jl")
include("$(homedir())/Dropbox/PhD/ENIgMA_Code/model/roverlap.jl")
include("$(homedir())/Dropbox/PhD/ENIgMA_Code/model/potcol.jl")
