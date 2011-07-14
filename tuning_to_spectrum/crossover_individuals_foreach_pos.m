
function new_individual = crossover_individuals(individual_A, individual_B)
    
    
    % splice individual into frequency and aplitude "sub-vector"
    num_partials = length(individual_A) / 2;
    
    new_individual = [];
   
    for i = 1 : num_partials
        if rand(1,1) >= 0.5            
            new_individual(i) = individual_A(i);
            new_individual(i+num_partials) = individual_A(i+num_partials);
        else
            new_individual(i) = individual_B(i);
            new_individual(i+num_partials) = individual_B(i+num_partials);
        end        
    end
    
    new_individual = new_individual';