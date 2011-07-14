
function mutated_pop = mutate_population(population, ...
    mutation_func, mutation_func_params)
    
    mutated_pop = [];
    pop_size = size(population, 2);

    for i = 1 : pop_size
        individual = population(:,i);

        exec_str = [mutation_func, '(individual, mutation_func_params)'];
        mutated_individual = eval(exec_str);
        mutated_pop = [mutated_pop mutated_individual];
    end