% clear console, figure and workspace
clear;
clc;
clf(gcf);

% Define a scale by a set of frequencies. Here it is a C major
c_major_frequencies = [ 
    264, %	C1
    297, % 	D1
    330, % 	E1
    352, % 	F1
    396, % 	G1
    440, % 	A1
    495  % 	H1
];

% Convert frequencies into ratios to the base frequency (C1). 

c_major_scale = c_major_frequencies(1:length(c_major_frequencies)) / ...
    c_major_frequencies(1);

% Intervalls to play.
intervalls = ...
        [  c_major_scale(1) c_major_scale(3);
           c_major_scale(2) c_major_scale(4);
           c_major_scale(3) c_major_scale(5);
           c_major_scale(4) c_major_scale(6);
           c_major_scale(5) c_major_scale(7);
           
           c_major_scale(1) c_major_scale(4);
           c_major_scale(2) c_major_scale(5);
           c_major_scale(3) c_major_scale(6);
           c_major_scale(4) c_major_scale(7);
           
           c_major_scale(1) c_major_scale(5);
           c_major_scale(2) c_major_scale(6);
           c_major_scale(3) c_major_scale(7);
           
           c_major_scale(1) c_major_scale(6);
           c_major_scale(2) c_major_scale(7);
           
           c_major_scale(1) c_major_scale(7);
                          1                2];
    
% We search for sound within this frequency range:
min_freq = 50;
max_freq = 1200;

% The population size. Value must be even.
max_N = 40; % 

% Number of parital tones ( >= 1)
max_partials = 8;

% stop searching after (whatever happens first)
max_generation = 1e6;
max_time = 3600; % seconds

test_play_intervall = 50;
graph_update_intervall = 5;

% Parameter for the selection process: constrain selection to sounds with
% a certain sum of amplitude values
min_ampl = 0.3 * (1/max_partials);

if max_partials < 3
    max_ampl = 1;
else
    max_ampl = 0.5;
end


sample_rate = 8000;
freq_shift = 10;            % join frequencies in a range of delta f

population = [];            % the population
generation = 0;             % generation counter
pop_fitness = 1000;         % variable to store 
pop_fitness_series = [];    % population fitness over time
best_ind_fitness_series=[]; % best fitness over time
worst_ind_fitness_series=[];% best fitness over time
pop_ampl_sum = [];          % used for debugging of decreasing amplitudes
best_ampl_sum = [];         %
num_immigrants_added = [];  % number of added individuals over time
best_fitness_ever = 1e6;
best_individual_ever = zeros(max_partials * 2, 1);
start_time = clock;         % a clock to measure processing time
heros = [];                 % list of best evaluated individuals over time

while (generation < max_generation) &&  ...
    (etime(clock, start_time) < max_time)

    % If we dropped too much individuals in the selection process, we need
    % to add new individuals to prevent population extinction.
    % Please note, that if you add too many indviduals in each generation,
    % then the search process becomes completly random and it will not
    % converge.
    pop_size = size(population, 2);
    
    num_needed = 0;
    if pop_size < max_N
        num_needed = max_N - pop_size;
    end
    if mod(num_needed + pop_size, 2) == 1
        num_needed = num_needed + 1;
    end
    
    needed_immigrants = create_population( num_needed, ...
        max_partials, min_freq, max_freq, 1);
    needed_immigrants = normalize_amplitudes(needed_immigrants);
    population = [population needed_immigrants];
        
    % for the statistics
    num_immigrants_added = [num_immigrants_added num_needed];
           
    % Crossover individuals
    
    n_children_per_generation = 2;
    next_generation = [];
    for child_i = 0 : n_children_per_generation        
        children = crossover_population(population, ...
            'crossover_individuals_at_single_pos');
        next_generation = [next_generation children];
    end
    
    population = [population next_generation];
    
    % If you loose too much individuals per generation, you can
    % - generate more children (increas n_children_per_generation)
    % - re-add "heros" to the pop
    %
    % population = [population next_generation heros];
    
    % Mutate individuals
    population = mutate_population(population, 'mutate_individual', ...
        [min_freq, max_freq, freq_shift]);
        
    % Cleanup 
    population = cleanup_individuals(population, ...
        min_freq, max_freq, freq_shift/2);
    
    % Normalize amplitudes  
    population = normalize_amplitudes(population);
 
    % Evaluate the fitness for each individual. Lower value is better
    % fitness.
    fitness = evaluate_fitness(population, ...
        'measure_intervall_dissonance', c_major_scale);

    
    % Select best individuals.
    population = select_individuals(population, max_N, fitness, ...
        'check_constraints', [max_partials min_ampl max_ampl]);


    pop_size = size(population, 2);
 
        
    % 
    % for the statistics
    %
    if pop_size > 0
        fitness = evaluate_fitness(population, ...
            'measure_intervall_dissonance', c_major_scale);
        pop_fitness = sum(fitness) / pop_size; % average
        pop_fitness_series = [pop_fitness_series pop_fitness];

        [sorted_fitness, idx_list] = sort(fitness);
        
        best_ind_fitness_series = [best_ind_fitness_series sorted_fitness(1)];
        worst_ind_fitness_series = [worst_ind_fitness_series sorted_fitness(pop_size)];
        best_individual = population(:,idx_list(1));
        best_ampl_sum = [best_ampl_sum sum(best_individual(max_partials+1:2*max_partials))];    
        pop_ampl_sum = [pop_ampl_sum sum(sum(population(max_partials+1:2*max_partials,:)))] / pop_size;

    
        if sorted_fitness(1) <= best_fitness_ever
            best_fitness_ever = sorted_fitness(1);
            best_individual_ever = best_individual;        
            heros = [heros best_individual_ever];
        end
        
    else
        pop_fitness_series = [pop_fitness_series NaN];
        best_ind_fitness_series = [best_ind_fitness_series NaN];
        worst_ind_fitness_series = [worst_ind_fitness_series NaN];
        best_individual = [];
        best_ampl_sum = [best_ampl_sum NaN];
        pop_ampl_sum = [pop_ampl_sum NaN];
        
    end

    if mod(generation, test_play_intervall) == 0
        enable_playing = true;
    else
        enable_playing = false;
    end
    
    % Present results on between.
    if mod(generation, graph_update_intervall) == 0 && generation > 0
        plot_and_play([best_individual_ever population], ...
            best_ind_fitness_series, worst_ind_fitness_series, ...
            pop_fitness_series, num_immigrants_added, ...
            max_N, c_major_scale, intervalls, max_partials, ...
            enable_playing, enable_playing, sample_rate);
    end

    generation = generation + 1;    
    
end

disp('****************************');
disp('FINISHED');
disp('****************************');

if length(best_individual) == 0
    error('error: algorithm''s parameters were not carefully choosen');
    return;
end

% Final presentation of results
plot_and_play([best_individual_ever population], ...
        best_ind_fitness_series, worst_ind_fitness_series, ...
        pop_fitness_series, num_immigrants_added, ...
        max_N, c_major_scale, intervalls, max_partials, false, true, sample_rate);

% Save best individual as wav-file.
wavwrite(generate_tone(sample_rate, 1, best_individual_ever, 1), ...
    sample_rate, 16, 'best_individual_ever.wav');

disp('Partial frequencies and their amplitudes:');
best_individual_ever
