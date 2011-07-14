% sort frequency values and their corresponding amplitudes

function new_individual = sort_frequencies(individual)

    if size(individual, 2) > 1
        errordlg('sort_frequncies(): invalid individual');
    end
    
    num_partials = int32(length(individual)/2);

    [sorted_freqs, idx_list] = sort(individual(1:num_partials));
    l = 1;
    new_individual = sorted_freqs;
        
    while l <= length(idx_list)        
        new_individual(num_partials+l,1) = individual(num_partials + idx_list(l),1);
        l = l + 1;
    end
    
    