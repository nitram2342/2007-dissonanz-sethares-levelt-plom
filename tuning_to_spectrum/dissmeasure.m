% calculate dissonace
% input param fvec - list of frequencies
% input param amp  - list of amplitudes
% output is sum of dissonances of each pair of partials (scalar)
function d = dissmeasure(fvec, amp)

  Xstar = 0.24;   % place with maximum dissonance
    
  S1 = 0.0207;    % to fit frequency dependend curves
  S2 = 18.96;     % so max. dissonance occures at 1/4 critical bandwidth
   
  C1 = 5; 
  C2 = -5;
    
  B1 = -3.51;     % derived from model of Levelt & Plomp
  B2 = -5.75; 
    
  N = length(fvec);
    
  [fvec, idx_list] = sort(fvec);  % sort partial frequencies ascending
  amp = amp(idx_list);            % rearrange amplitude values
  %amp = loudness(amp);
  
  D = 0;
    
  for i=2:N
    Fmin = fvec(1 : N-i+1);       % get slice as list of Fmin
    S = Xstar./(S1*Fmin+S2);      % calc list of s-scalings with list of Fmin
    
    % treat vector as tail and head ...
    Fdif = fvec(i:N) - fvec(1:N-i+1);   % build element wise difference
    a = min(amp(i:N), amp(1:N-i+1));    % select element wise a minimum
    Dnew = a .* (C1*exp(B1*S.*Fdif) + C2*exp(B2*S.*Fdif));
        
    D = D + sum(Dnew);              % sum up last D and vector elements 
  end
    
  d=D;
