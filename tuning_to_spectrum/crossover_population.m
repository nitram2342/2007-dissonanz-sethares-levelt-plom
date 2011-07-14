% crossover between two parents

function crossed_pop = crossover_population(population, crossover_func)
    
    pop_size = size(population, 2);

    %permutated_pop = population;
    
    % permutate the individuals
    new_world_order = randperm(pop_size);
    permutated_pop = [];
    for i = 1 : length(new_world_order)
        idx = new_world_order(i);
        permutated_pop = [permutated_pop population(:, idx)];
    end
        
    crossed_pop = [];
    
    for i = 1 : 2 : pop_size
        individual_A = permutated_pop(:,i);
        individual_B = permutated_pop(:,i+1);
        
        exec_str = [crossover_func, '(individual_A, individual_B)'];
        children = eval(exec_str);
        
        crossed_pop = [crossed_pop children];
    end