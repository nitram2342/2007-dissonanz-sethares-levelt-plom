function dissonance = measure_intervall_dissonance(individual, scale)
    
    num_partials = length(individual) / 2;
    freqs = individual(1:num_partials);
    ampls = individual(num_partials+1:length(individual));
    
    dissonance = 0;

    new_f = [];
    new_a = [];

    for i = 1 : length(scale)
        new_f = [new_f; scale(i) * freqs];
        new_a = [new_a; ampls];
    end
    
    
    dissonance = dissmeasure(new_f, new_a);%/(num_partials * length(scale));
        