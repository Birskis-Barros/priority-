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
include("$(homedir())/Dropbox/PhD/ENIgMA/model/intmatrixv3.jl")

#Community dynamics
include("$(homedir())/Dropbox/PhD/ENIgMA/model/preamble_defs.jl")
include("$(homedir())/Dropbox/PhD/ENIgMA/model/assembly.jl")

#Analysis Calculations
include("$(homedir())/Dropbox/PhD/ENIgMA/model/structure.jl")
include("$(homedir())/Dropbox/PhD/ENIgMA/model/dynstructure.jl")

#Analysis functions
include("$(homedir())/Dropbox/PhD/ENIgMA/model/trophicalc2.jl")
include("$(homedir())/Dropbox/PhD/ENIgMA/model/roverlap.jl")
include("$(homedir())/Dropbox/PhD/ENIgMA/model/potcol.jl")
