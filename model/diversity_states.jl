
S = 20;
probs = (
p_n=0.05,
p_a=0.3
# p_n = 0.02,
# p_a = 0.02
);
#expected objects per species
lambda = 0.0  ;

MaxN = convert(Int64,floor(S + S*lambda));

int_m, tp_m, tind_m, mp_m, mind_m = intmatrixv3(S,lambda,probs);

a_b,
n_b,
i_b,
m_b,
n_b0,
sp_v,
int_id = preamble_defs(int_m);

N = size(int_m)[1];

#Define all possible states
states = collect(combinations(collect(1:N))); #todas as combinacoes de S (análise combinatória)
states = states[N+1:length(states)]; #retirando espécies sozinhas (sem sol)
states = states[in.(1,states)];#retirando todos os conjuntos que não tem sol
#how many states
nstates = length(states);

#Determine impossible states
passtest = zeros(Int64,nstates) .+ 1; #tem que cumprir algumas regras
keepstates = Array{Int64}(undef,0);
needs = Array{Int64}(undef,0);

for i=1:nstates
    speciesobjects = states[i];
    adjacencymatrix = a_b[speciesobjects,speciesobjects] .+ m_b[speciesobjects,speciesobjects]';
    g = DiGraph(adjacencymatrix');
    paths = gdistances(g,1) #qual o numero de passos até o sol?
    if maximum(paths) < N+1;#se a distancia é "infinita", então quer dizer que não estão conectados
        passtest[i] *= 1;
    else
        passtest[i] *= 0;
    end

    #NOTE: take out states without complete set of species/object pairs
    observedspecies = speciesobjects[speciesobjects .<= S]; #se for maior que S é pq é objeto
    expectedobjects = findall(!iszero,vec(sum(m_b[observedspecies,:],dims=1)));

    observedobjects = setdiff(speciesobjects,observedspecies);
    expectedspecies = findall(!iszero,vec(sum(m_b[:,observedobjects],dims=2)));

    if observedspecies == expectedspecies || observedobjects == expectedobjects
        passtest[i] *= 1;
    else
        passtest[i] *= 0;
    end

  #NOTE: I need to check the needs interactions too:
       poolneeds = sum(n_b0[speciesobjects,:],dims=2)
       comneeds = sum(n_b0[speciesobjects,speciesobjects],dims=2)
       if poolneeds == comneeds
       passtest[i] *= 1;
       else
       passtest[i] *= 0;
       end

end

possiblestates = states[findall(!iszero,passtest)];
statespace = sum(passtest)/nstates
lstate = length(possiblestates);

# SparseArray
transm = spzeros(lstate,lstate);
for i=1:lstate
    # print(string(i,'_'))
    statei = copy(possiblestates[i]);
    deleteat!(statei,1)
    colonizers = potcol(sp_v,int_id,statei,a_b,n_b0,0,1);
    # newstates = Array{Array}(undef,length(colonizers));
    newstatesloc = Array{Int64}(undef,length(colonizers));
      for j=1:length(colonizers)
        newstates = sort([1;statei;colonizers[j]]);
        newstatesloc[j] = findall(x->x == newstates,possiblestates)[1];
        end
    transm[i,newstatesloc] .= 1.0;
end

primarystates = findall(x->x==2,length.(possiblestates));
transg = DiGraph(transm);
trimlist = zeros(Int64,lstate,length(primarystates));
for i=1:length(primarystates)
    paths = gdistances(transg,primarystates[i]);
    tokeep = findall(x->x<(S+1),paths);
    trimlist[tokeep,i] .= 1;
end

connectedstates = findall(!iszero,vec(sum(trimlist,dims=2)));
transmconnected = transm[connectedstates,connectedstates];
lstateconnected = length(connectedstates);

number_species = spzeros(length(possiblestates))
for i=1:length(possiblestates)
  number_species[i] = length(possiblestates[i])
  end

number_sps_state = zeros(Int64,length(unique(number_species)));
for i=1:length(unique(number_species))
  number_sps_state[i] = length(findall(x->x==unique(number_species)[i],number_species))
  end

  R"""
  richness_states = data.frame($number_sps_state)
  richness_states$number_species = unique($number_species)
  library(ggplot2)
  ggplot(data=richness_states, aes(x=richness_states[,2], y=richness_states[,1]))+
geom_point(alpha = 0.3, size=5) +
theme_classic() +
 labs(x = "number of species in the state", y="number of states")
  """
