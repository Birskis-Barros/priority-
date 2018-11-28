using Distributed
using DataFrames

@everywhere using Combinatorics
@everywhere using LinearAlgebra
# @everywhere using Distributed
@everywhere using SharedArrays
@everywhere using SparseArrays
@everywhere using DataFrames
@everywhere using Distributions
@everywhere using SpecialFunctions
@everywhere using LightGraphs
@everywhere using RCall
# @everywhere using HDF5
@everywhere using JLD

if homedir() == "/home/irinabarros"

#deu certo? 

    #Interaction matrix
    @everywhere include("$(homedir())/Documents/src/intmatrixv3.jl")
    @everywhere include("$(homedir())/Documents/src/preamble_defs.jl")
    @everywhere include("$(homedir())/Documents/src/assemblystate.jl")
    @everywhere include("$(homedir())/Documents/src/potcol.jl")


else


    #Interaction matrix
    @everywhere include("$(homedir())/Dropbox/2018_discrete_enigma/model/src/intmatrixv3.jl")
    @everywhere include("$(homedir())/Dropbox/2018_discrete_enigma/model/src/preamble_defs.jl")
    @everywhere include("$(homedir())/Dropbox/2018_discrete_enigma/model/src/assemblystate.jl")
    @everywhere include("$(homedir())/Dropbox/2018_discrete_enigma/model/src/potcol.jl")
end
