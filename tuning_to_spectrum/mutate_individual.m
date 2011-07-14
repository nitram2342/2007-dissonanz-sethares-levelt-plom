
function modified_individual = mutate_individual(individual, params)
    
    min_freq = params(1);
    max_freq = params(2);
    freq_shift = params(3);      

    % splice individual into frequency and aplitude "sub-vector"
    num_partials = int32(length(individual) / 2);
    freqs = individual(1:num_partials);
    ampls = individual(num_partials+1:length(individual));
    
    % random index selection
    
    for pos = (1:round(num_partials/2))
        idx = round(rand(1,1) * (num_partials-1) + 1);
    
        if rand(1,1) - 0.5 >=0
            factor = 1;
        else
            factor = -1;
        end
        
        freqs(idx) = freqs(idx) + factor * freq_shift;

        if freqs(idx) > max_freq
            freqs(idx) = max_freq;
        end;

        if freqs(idx) < min_freq
            freqs(idx) = min_freq;
        end

        direction = 2 * (randint() - 0.5);
        ampls(idx) = ampls(idx) +.1 * direction * rand(1,1);
    
        if ampls(idx) < 0
            ampls(idx) = 0;
        end

    end
    modified_individual = [freqs; ampls];
    