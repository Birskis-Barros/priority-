#RUN REMOTELY
if homedir() == "/home/z840"
    loadfunc = include("$(homedir())/2018_discrete_enigma/model/src/loadfuncs.jl");
else
    loadfunc = include("$(homedir())/Dropbox/PostDoc/2018_discrete_enigma/model/src/loadfuncs.jl");
end


# RUN LOCALLY
using Distributed
@everywhere using Combinatorics
@everywhere using LinearAlgebra
# @everywhere using Distributed
@everywhere using SharedArrays
@everywhere using SparseArrays
@everywhere using Distributions
@everywhere using SpecialFunctions
@everywhere using LightGraphs
@everywhere using RCall
# @everywhere using HDF5
@everywhere using JLD

S = 15;

# S = 400;
pr = (
p_n=0.1,
p_a=0.3
# p_n = 0.02,
# p_a = 0.02
);
#expected objects per species
lambda = 0.0;


reps = 20;
#length of connected states
lcs = SharedArray{Int64}(reps);
#length of starting states
lss = SharedArray{Int64}(reps);
#length of final states
lfs = SharedArray{Int64}(reps);
#connectance
conn = SharedArray{Float64}(reps);

@sync @distributed for r = 1:reps
    int_m,transmconnected,connectedstates,possiblestates = assemblystate(S,pr,lambda);
    g = DiGraph(transmconnected);
    startingstates = connectedstates[findall(iszero,indegree(g))];
    finalstates = connectedstates[findall(iszero,outdegree(g))];
    lcs[r] = length(connectedstates);
    lss[r] = length(startingstates);
    lfs[r] = length(finalstates);
    conn[r] = length(findall(x->x=='a',int_m))/(S^2);
end


R"""
library(igraph)
library(RColorBrewer)
#pdf($namespace,width=6,height=5)
pal <- brewer.pal(3,"Set1")
fw_g <- graph.adjacency($(Array(transmconnected)));
coords <- layout_(fw_g, with_kk())
plot(fw_g,layout=coords,vertex.size=2,edge.arrow.size=0.5,edge.color='#6495ED',vertex.label=$connectedstates,vertex.frame.color=NA) 
#dev.off()
"""



R"""
g = graph.adjacency($(Array(transm)));
plot(g,layout=layout_as_tree(g,circular=TRUE))
"""

,vertex.size=2,edge.arrow.size=0.25,edge.color='#6495ED',vertex.label=NA,vertex.frame.color=NA