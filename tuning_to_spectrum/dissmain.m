% define the scale from frequencies
c_major_frequencies = [ 
    264, %	C1
    297, % 	D1
    330, % 	E1
    352, % 	F1
    396, % 	G1
    440, % 	A1
    495, % 	H1
    528  % 	C2
];

c_major_names = {'C1' 'D1' 'E1' 'F1' 'G1' 'A1' 'H1' 'C2'};
% derive scale ratios and fundamental frequency
c_major_fundamental_freq = c_major_frequencies(1);
c_major_scale = c_major_frequencies / c_major_fundamental_freq;

% define the instrument
instrument_partial_freqs = 500*[1 2 3 4 5 6 7];   % vector with frequencies
instrument_partial_ampl = ones(size(instrument_partial_freqs)); % vector with amplitudes

instrument_partial_freqs = [instrument_partial_freqs (501:999)];
instrument_partial_ampl =  [instrument_partial_ampl 0*(501:999)+0.001];

inc=0.0001;
diss=[];                  % initial zero from the original source removed                         

x_values = c_major_scale(1):inc:c_major_scale(length(c_major_scale)); 

for alpha=x_values,
  f=[instrument_partial_freqs alpha*instrument_partial_freqs];
  a=[instrument_partial_ampl, instrument_partial_ampl];
  d=dissmeasure(f, a);
  diss=[diss d];
end


scale_step_values = [];
for i=1:length(c_major_scale)
    n = dissmeasure(...
        [instrument_partial_freqs c_major_scale(i)*instrument_partial_freqs], ...
        [instrument_partial_ampl, instrument_partial_ampl]);
    scale_step_values = [scale_step_values n];
end

plot(x_values, diss, '-k', ...
    c_major_scale, scale_step_values, 'ko', 'MarkerFaceColor','k');

xlabel('Frequency ratio (x:1)');
ylabel('Sensory dissonance');

for i=1:length(c_major_scale)    
    text(c_major_scale(i), scale_step_values(i), sprintf('  %s', c_major_names{i}));
end

saveas(gcf, 'dissonance_curve_ideal_sample.pdf', 'pdf');