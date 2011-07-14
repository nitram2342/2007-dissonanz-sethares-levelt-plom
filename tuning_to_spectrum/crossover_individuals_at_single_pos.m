
function new_individual = crossover_individuals_at_single_pos(individual_A, individual_B)
    
    
    % splice individual into frequency and aplitude "sub-vector"
    num_partials = int32(length(individual_A) / 2);
    
    new_individual = []';
    take_A = false;
    if rand(1,1) >= 0.5
        take_A = true;
    end
    
    % new individual is A or B ...
    if take_A
        new_individual = individual_A;
    else
        new_individual = individual_B;
    end

    % with a single crossover at a random index
    idx = round(rand(1,1) * (num_partials-1) + 1);

    if take_A
        new_individual(idx) = individual_B(idx);
    else
        new_individual(idx) = individual_A(idx);
    end
    