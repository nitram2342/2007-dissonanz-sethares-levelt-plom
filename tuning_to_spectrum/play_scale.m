function play_scale(sample_rate, duration, individual, scale)

    disp('playing scale');    
    sample_rate
    duration
    individual
    scale
    
    for i = 1 : length(scale)
        play_tone(sample_rate, duration, individual, [scale(i)]);
    end
