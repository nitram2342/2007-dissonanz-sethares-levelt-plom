function plot_and_play(population, ...
    best_ind_fitness_series, worst_ind_fitness_series, ...
    pop_fitness_series, num_immigrants_added, max_N, scale, intervalls, ...
    max_partials, play_scale_enable, play_intervalls_enable, sample_rate)

    fitness = evaluate_fitness(population, ...
        'measure_intervall_dissonance', scale);
    [sorted_fitness, idx_list] = sort(fitness);

    best_individual = population(:, idx_list(1));
    
    draw_m = 4;
    draw_n = 2;
    draw_n_individuals = draw_m - draw_n;
    duration = 0.2;
    
    figure(gcf);
    clf(gcf);

    subplot(draw_m, draw_n, 1);
    semilogx(best_ind_fitness_series, '-k');
    hold on;
    semilogx(best_ind_fitness_series(1) * ones(1,length(best_ind_fitness_series)), ':k');
    hold on;
    semilogx(worst_ind_fitness_series, '-k');
    title('Fitness of best/worst evaluated individual');
    xlabel('Generation');
    ylabel('Fitness ');

    %subplot(draw_m,draw_n,2);
    %semilogx(pop_fitness_series, '-k' );
    %title(sprintf('Average population fitness'));
    %xlabel('Generation');
    %ylabel('Fitness');

    subplot(draw_m, draw_n, 2);
    plot(num_immigrants_added *100/max_N, '-k' );
    title('Individuals added');
    xlabel('Generation');
    ylabel('% pop');


    % frequency and dissonance plot for the best individual
    subplot(draw_m, draw_n, 3);
    stem(best_individual(1:max_partials), ...
        best_individual(max_partials + 1:2*max_partials), '-k');
    title(sprintf('Best individual ever with fitness %.3f', fitness(1)));
    ylim([0 1]);    
            
    subplot(draw_m, draw_n, 4);
    dissonance_plot(best_individual, scale, true);
    if play_scale_enable == true
        play_scale(sample_rate, duration/2, best_individual, scale);
    end
    if play_intervalls_enable == true
        pause(duration);
        play_intervall(sample_rate, duration, best_individual, scale);
    end
    
    
    % frequency and dissonance plot for the other individuals
    
    if length(idx_list) >= draw_n_individuals
        for i = 1 : draw_n_individuals
            if i == draw_n_individuals
                idx = length(population);
            else
                idx = i + 1;
            end
            individual = population(:, idx_list(idx));

            subplot(draw_m, draw_n, 3+(i)*2);
            stem(individual(1:max_partials),individual(max_partials + 1:2*max_partials), '-k');
            if max_partials < 5
                hold on;
                stem(best_individual(1:max_partials),best_individual(max_partials + 1:2*max_partials), ':k');
            end
            ylim([0 1]);
            title(sprintf('Spectrum for the individual %d with fitness %.3f', idx-1, fitness(idx)));

            subplot(draw_m, draw_n, 3+(i)*2+1);
            dissonance_plot(individual, scale, false);
            
            if play_scale_enable == true
                individual
                play_scale(sample_rate, duration/2, individual, scale);
            end
            if play_intervalls_enable == true
                pause(duration);
                play_intervall(sample_rate, duration, individual, scale);
            end
        end
    end
    
    % save data from current figure handle
    saveas(gcf, 'generationplot.pdf', 'pdf');
