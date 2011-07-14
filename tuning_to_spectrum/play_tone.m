function play_tone(sample_rate, duration, individual, scalings)

    if length(scalings) > 0
        snd = generate_tone(sample_rate, duration, individual, scalings(1));
    
        for i = 2 : length(scalings)
            snd = snd + generate_tone(sample_rate, duration, individual, ...
                scalings(i));
        end    
        snd = snd / length(scalings);
    
        if max(snd) > 1 || min(snd) < -1
            warn('sound samples will be clipped');
        end
        sound(snd, sample_rate);        
        
        pause(duration);
    end
    