function dissonance_plot(best_individual, scale, enable_labels)

    inc=0.005;
    max_partials = int32(length(best_individual) / 2);
    
    diss=[];
    x_values = scale(1):inc:scale(length(scale));
    instrument_partial_freqs = best_individual(1:max_partials);
    instrument_partial_ampl = best_individual(max_partials+1:2*max_partials);
    for alpha = scale(1):inc:scale(length(scale))
        f = [instrument_partial_freqs; alpha*instrument_partial_freqs];
        a = [instrument_partial_ampl; instrument_partial_ampl];        
        d = dissmeasure( f, a);
        diss = [diss d];
    end
    
    scale_step_values = [];
    for i=1:length(scale)
        f = [instrument_partial_freqs; scale(i)*instrument_partial_freqs];
        a = [instrument_partial_ampl; instrument_partial_ampl];        
        d = dissmeasure( f, a);
        scale_step_values = [scale_step_values d];
    end
    
    plot(x_values, diss, '-k', ...
        scale, scale_step_values, 'ko', 'MarkerFaceColor','k');

    if enable_labels
        xlabel('Frequency ratio (x:1)');
        ylabel('Dissonance');
        title('Dissonance plot for best individual');
    end