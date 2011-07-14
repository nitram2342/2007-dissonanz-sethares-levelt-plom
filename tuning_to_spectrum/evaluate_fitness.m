% evaluate the fitness for a population
%
% returns an array with fitness values

function fitness = evaluate_fitness(population, ...
    eval_func, eval_func_params)
    
    fitness = [];
    pop_size = size(population, 2);
    
    for i = 1 : pop_size
        individual = population(:,i);

        exec_str = [ eval_func, '(individual, eval_func_params)'];
        fitness = [fitness eval(exec_str)];
    end
    