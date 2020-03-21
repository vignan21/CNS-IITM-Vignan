function Itemp=monophasic(amp,dur,niter,f)

%% CREDITS
% Created by
% Vignayanandam R. Muddapu (Ph.D. scholar)
% C/o Prof. V. Srinivasa Chakravarthy
% Indian Institute of Technology Madras
% India

% Creates monophasic waveform

%% INPUTS
% a = amplitude (pA)
% dur = pulse duration (usec)
% niter = no. of iteration
% f = frequency

%% OUTPUTS
% Itemp = array length equal to 'niter' with minimum value '0' and
% maximum value '+a with frequency of 'f' and pulse width 'dur'

%% CODE
count=1;m=1;dt=.1;%usec
max_m=dur./dt;
j=1;
T=round(10000/f);
while j<=niter
%     amp=a+(100*randn); % random amplitude
if count<=T
if m<=max_m
Itemp(j)=abs(amp);
m=m+1;count=count+1;
j=j+1;
else
Itemp(j)=0;
m=m+1;count=count+1;
j=j+1;
end 
else
count=1;
m=1;
end
end
% figure(2)
% plot(Itemp)
% axis([0 numel(Itemp) -2*amp 2*amp]);
end