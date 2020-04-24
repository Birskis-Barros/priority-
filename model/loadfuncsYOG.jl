@everywhere using Distributions
@everywhere using SpecialFunctions
@everywhere using LightGraphs
@everywhere using RCall
@everywhere using HDF5
@everywhere using JLD

#Interaction matrix
@everywhere include("$(homedir())/Dropbox/PhD/ENIgMA/model/intmatrixv3.jl")

#Community dynamics
@everywhere include("$(homedir())/Dropbox/PhD/ENIgMA/model/preamble_defs.jl")
@everywhere include("$(homedir())/Dropbox/PhD/ENIgMA/model/assembly.jl")

#Analysis Calculations
@everywhere include("$(homedir())/Dropbox/PhD/ENIgMA/model/structure.jl")
@everywhere include("$(homedir())/Dropbox/PhD/ENIgMA/model/dynstructure.jl")

#Analysis functions
@everywhere include("$(homedir())/Dropbox/PhD/ENIgMA/model/trophicalc2.jl")
@everywhere include("$(homedir())/Dropbox/PhD/ENIgMA/model/roverlap.jl")
@everywhere include("$(homedir())/Dropbox/PhD/ENIgMA/model/potcol.jl")

@everywhere include("$(homedir())/Dropbox/PhD/ENIgMA/model/assemblystate.jl")
