% create a population
%
% returns a (m,n)-matrix with m = max_partials and n = num_individuals
% This means each column represents the partials for an individual.

function pop = create_population(num_individuals, ...
    max_partials, min_freq, max_freq, max_amplitude)
    
    pop = [];

    for i = 1 : num_individuals
        
        % build up a new column
        new_individual = [];
        for p = 1 : max_partials
            new_partial = rand(1,1)*(max_freq - min_freq) + min_freq;
            new_individual = [new_individual; new_partial];
        end
        
        % randomly create amplitude values
        amplitudes = max_amplitude * rand(size(new_individual));
                
        % join data to form an individual
        new_individual = [new_individual; amplitudes];
        
        % store new individual in result matrix
        pop = [pop new_individual];
    end
    