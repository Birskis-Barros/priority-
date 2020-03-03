##### Code to understand how the percentage of mutualism in the pool affects
#the number of possible states in the local community

  perc_mutualism = repeat([0.1:0.01:1;],10);
  #perc_mutualism = [0.1:0.01:1;]
  result_mutualism = zeros(Float64,length(perc_mutualism));

  for a=1:length(result_mutualism)

      S = 10;
      probs = (
      p_n=   perc_mutualism[a],
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



  result_mutualism[a] = length(possiblestates)

  end

mutualism = [result_mutualism, perc_mutualism];


R"""
library(ggplot2)
data_mutualism = as.data.frame($mutualism)
ggplot(data=data_mutualism, aes(x=data_mutualism[,2], y=data_mutualism[,1]))+
geom_point(alpha = 0.3, size=5) +
theme_classic() +
labs(x = "% of need interactions", y="number of states")
"""
