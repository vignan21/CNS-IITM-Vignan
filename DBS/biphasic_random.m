function [Itemp1]=biphasic_random(a,dur,niter,f)

%% CREDITS
% Created by
% Vignayanandam R. Muddapu (Ph.D. scholar)
% C/o Prof. V. Srinivasa Chakravarthy
% Indian Institute of Technology Madras
% India

% Creates random biphasic waveform

%% INPUTS
% a = amplitude (pA)
% dur = pulse duration (usec)
% niter = no. of iteration
% f = frequency

%% OUTPUTS
% Itemp = array length equal to 'niter' with minimum value '-a' and
% maximum value '+a' with frequency of 'f' and pulse width 'dur'

%% CODE
count=1;dt=.1;% in usec
max_m=dur./dt;
m=1;% j=1;
j=round((1000-1).*rand(1,1) + 1);
% jj=j;
T=round(10000/f);
% Itemp=zeros(1,niter);
while j<=niter
%     amp=a+(100*randn); % random amplitude
amp=a;
if count<=T
if m<=max_m && m+1<=max_m
Itemp(j)=abs(amp);
Itemp(j+1)=-abs(amp);
j=j+2;
m=m+1;count=count+1;
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
Itemp1=Itemp(1,1:niter);
% figure(2)
% plot(dt*(1:niter),Itemp)
% axis([0 dt*niter -10*amp 10*amp]);
% saveas(figure(2),['biphasic_constamp_inhieci_frequency=','_amp=',num2str(a)],'tiff');
end