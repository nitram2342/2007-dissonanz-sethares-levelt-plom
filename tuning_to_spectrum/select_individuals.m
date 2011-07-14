function new_pop = select_individuals(population, N, fitness, ...
    contraint_match_function, contraint_match_function_params)    
    
    new_pop = [];
    
    [sorted_fitness, idx_list] = sort(fitness); % sort ascending by fitness     
        
    for i = 1:length(idx_list)
        
        individual = population(:, idx_list(i));
        if size(individual, 2) > 1
            errordlg('select_individuals(): invalid individual');
        end
    
        exec_str = [contraint_match_function, ...
            '(individual, contraint_match_function_params)'];
        
        ok = eval(exec_str);
        if ok == true
            new_pop = [new_pop individual];
            if size(new_pop, 2) == N
                return
            end
        end
        
    end
