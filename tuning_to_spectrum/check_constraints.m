
function fits = check_constraints(individual, params)
  
    min_partials = params(1);
    min_ampl = params(2);
    max_ampl = params(3);
        
    num_partials = int32(length(individual) / 2);

    count = 0;
    for i = num_partials + 1 : 2*num_partials        
        if individual(i) >= min_ampl && individual(i) <= max_ampl
            count = count + 1;
        end
    end
    
    if count < min_partials        
        fits = false;
    else
        fits = true;
    end
    

