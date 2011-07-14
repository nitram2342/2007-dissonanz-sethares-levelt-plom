function new_pop = cleanup_individuals(population, min_freq, max_freq, ...
    merge_delta_freq)
    
    pop_size = size(population, 2);
    num_partials = int32(size(population, 1) / 2);
    new_pop = [];
        
    for i = 1 : pop_size
        new_individual = sort_frequencies(population(:, i));        
        
        % remove values, if values are out of range
        last_freq_index = 1;
        
        for j = 1 : num_partials
            if (new_individual(j) < min_freq) || (new_individual(j) > max_freq)
                new_individual(j) = 0;
                new_individual(num_partials+j) = 0;
            end
            

            if last_freq_index < j && ...                    
                abs(new_individual(j) - new_individual(last_freq_index)) <= merge_delta_freq

                new_individual(last_freq_index+num_partials) = new_individual(last_freq_index+num_partials) + new_individual(j+num_partials);
                new_individual(j+num_partials) = 0;
                new_individual(j) = 0;
            else
               last_freq_index = j;
            end
    
        end        
        
        new_individual = sort_frequencies(new_individual);        
        new_pop = [new_pop new_individual];        
    end
