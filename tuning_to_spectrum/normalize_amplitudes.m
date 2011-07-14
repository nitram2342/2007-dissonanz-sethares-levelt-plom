function new_pop = normalize_amplitudes(population)       
    
    pop_size = size(population, 2);
    num_partials = int32(size(population, 1) / 2);
    
    new_pop = [];
        
    for i = 1 : pop_size
        individual = population(:, i);
        sum_ampls = sum(individual(num_partials+1:2*num_partials));
        
        if sum_ampls > 0
            for j = 1 : num_partials
                individual(num_partials+j) = ...
                    individual(num_partials+j) / sum_ampls;
            end
        
            new_pop = [new_pop individual];
        end
        
    end
