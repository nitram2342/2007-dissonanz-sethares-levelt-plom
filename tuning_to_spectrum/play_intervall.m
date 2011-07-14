function play_intervall(sample_rate, duration, individual, scale)

    disp('playing major seconds -- should sound somehow strange');
    pause(duration);
    play_tone(sample_rate, duration, individual, [scale(1) scale(2)]);
    play_tone(sample_rate, duration, individual, [scale(2) scale(3)]);
    play_tone(sample_rate, duration, individual, [scale(3) scale(4)]);
    play_tone(sample_rate, duration, individual, [scale(4) scale(5)]);
    play_tone(sample_rate, duration, individual, [scale(5) scale(6)]);
    play_tone(sample_rate, duration, individual, [scale(6) scale(7)]);

    disp('playing major thirds');
    pause(duration);
    play_tone(sample_rate, duration, individual, [scale(1) scale(3)]);
    play_tone(sample_rate, duration, individual, [scale(2) scale(4)]);
    play_tone(sample_rate, duration, individual, [scale(3) scale(5)]);
    play_tone(sample_rate, duration, individual, [scale(4) scale(6)]);
    play_tone(sample_rate, duration, individual, [scale(5) scale(7)]);

    disp('playing perfect fourth');
    pause(duration);    
    play_tone(sample_rate, duration, individual, [scale(1) scale(4)]);
    play_tone(sample_rate, duration, individual, [scale(2) scale(5)]);
    play_tone(sample_rate, duration, individual, [scale(3) scale(6)]);
    play_tone(sample_rate, duration, individual, [scale(4) scale(7)]);

    disp('playing perfect fifth');
    pause(duration);    
    play_tone(sample_rate, duration, individual, [scale(1) scale(5)]);
    play_tone(sample_rate, duration, individual, [scale(2) scale(6)]);
    play_tone(sample_rate, duration, individual, [scale(3) scale(7)]);

    disp('playing major sixth');
    pause(duration);    
    play_tone(sample_rate, duration, individual, [scale(1) scale(6)]);
    play_tone(sample_rate, duration, individual, [scale(2) scale(7)]);

    disp('playing major seventh');
    pause(duration);
    play_tone(sample_rate, duration, individual, [scale(1) scale(7)]);

    disp('playing octave');
    pause(duration);
    play_tone(sample_rate, duration, individual, [      1  2]);

