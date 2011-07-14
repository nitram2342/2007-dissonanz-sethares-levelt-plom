function snd = generate_tone(sample_rate, duration, individual, scaling)

    num_partials = length(individual)/2;
    %assert(num_partials >= 1);
    %assert(sample_rate > 0);
    %assert(duration > 0);
    
    snd = zeros(1, round(sample_rate * duration));
    
    for i = 1 : num_partials
       freq = scaling * individual(i);
       
       if freq > 0
           ampl = individual(i+num_partials);

           snd_new = (0 : round(sample_rate * duration) - 1);
           snd_new = ampl * sin(2 * pi * freq/sample_rate  * snd_new);
       
           snd = snd + snd_new;
       end
    end
    
    % ampitude is <= 1
    
    % In case we want sth. like fade in/out
    %snd = snd .* hamming(length(snd))';
