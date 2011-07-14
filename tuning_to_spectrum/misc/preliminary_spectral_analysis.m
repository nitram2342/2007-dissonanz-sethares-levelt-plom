samples_dir = 'samples';
sample_files = {
    'sin_mix_500-3500.wav'
    'sinus220hz'
    'sinus440hz'
    'sample258acoustic.wav'
    'sample255acoustic.wav'
    'key4_nodisp.wav'
    'FX045_BIGBT_140_X_SC3.wav'
    'SYNTHPAD007_TEKNO_140_A_SC3.wav'
    'SPHERE015_TEKNO_140_A_SC3(L).wav'
    'SYNTHPAD011_TEKNO_140_A_SC3.wav'
    'SYNTH106_TEKNO_140_A_SC3.wav'
    'SYNTHPAD015_TEKNO_140_A_SC3.wav'};

i = 1;

% read a .wav file
[wav_data, sample_freq, bits_per_sample] = wavread(sprintf('%s/%s', samples_dir, sample_files{i}));

% plot wave form
subplot(3,1,1);
t = (0:1:length(wav_data)-1)' / sample_freq;
plot(t, wav_data, '-k', 'LineWidth', 1);
title(sprintf('Waveform of sample %i', i));
xlabel('Time (s)');
ylabel('Amplitude [-1,+1]');

% plot spectrogram
fft_size=1024*2;
max_display_freq=4100;
max_display_idx = int32(fft_size * max_display_freq / (sample_freq/2) /2);

[B, f, t] = specgram(wav_data, fft_size, sample_freq);

f = f(1:max_display_idx);
B2 = [];
for j=1:max_display_idx
    B2 = [B2; B(j,:)];
end

bmin = max(max(abs(B2)))/300; % ampl. value for 50dB below maximum

subplot(3,1,2);
imagesc(t, f, 20*log10(max(abs(B2),bmin)/bmin));

axis xy;
lgrays=zeros(100,3);
for j=1:100 
    lgrays(j,:) = 1 - j/100;
end
colormap(lgrays);
%colorbar;
title(sprintf('Spectrogram of sample %d (FFT-Size %d)', i, fft_size));
xlabel('Time (s)');
ylabel('Frequency (Hz)');

% fft
subplot(3,1,3);
fft_data_complex = fft(wav_data, fft_size);
fft_data_to_plot = abs(fft_data_complex(1:max_display_idx));
stem(f, fft_data_to_plot, 'k', 'filled');

title(sprintf('Spectrum of sample %d (FFT-Size %d)', i, fft_size));
xlabel('Frequenzy (Hz)');
ylabel('Magnitude');

% save data from current figure handle
saveas(gcf, 'testplot.pdf', 'pdf');

% play audio
player = audioplayer(wav_data, sample_freq);
play(player);

