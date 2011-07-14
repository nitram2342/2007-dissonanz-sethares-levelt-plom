function l = loudness(amplitudes)
    
    l = [];
    Pref = 20e-6;
    for i=1:length(amplitudes)
        Pe = amplitudes(i) / sqrt(2);
        Lp = 20 * log10(Pe / Pref);
        curr_loudness = 1/16 * 2^(Lp/10);
        if(curr_loudness < 0)
            curr_loudness = 0;
        end
        l = [l curr_loudness];
    end
    
    