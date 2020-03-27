% Izhikevich neuronal model
% VIGNAYANANDAM R. MUDDAPU (IIT-MADRAS)


% The Izhikevich Model:
% (1) dv/dt = (k*(v - vr)*(v - vt)-u + I)/C
% (2) du/dt = a*(b*(v-vr)-u)
% (3) if v = vPeak, then: v <- c; u <- u+d
% where v = membrane potential, u = recovery variable,
% a = time scale of recovery, b = sensitivity of recovery to subthreshold oscillations
% c = after-spike reset value of v, d = after-spike reset increment of u
% vPeak = % spike cutoff  (mV)
% vr = membrane resting potential; vt = instantaneous threshold potential;

clear;clc;

Sstep = 100;          % step height for input stimulus (in pA)
S1 = 0.1; S2 = 0.9;  % percentages for step input ON and OFF
dt = 0.1;
NT = 1000;   % simulation time (in milliseconds)

C = 100; % (pF) <-- Capcitance of the neuron can be changed for initial latency
vr = -60; % (mV)
vt = -40; % (mV)
k = 0.7; % (pA/mV)
a = 0.03; % (1/ms)
b = -2; % (pA/mV)
c = -50; % (mV)
d = 100; % (pA)
vPeak = -5; % (mV)

% SETUP   ----------------------------------------------------------------
t = 0:dt:(NT);   % time steps
NTT = numel(t);  % number of time steps

v = -63*ones(1,NTT); u = 0*v; % initial values
S = zeros(1,NTT);            % stimulus

S(round(S1*NTT):round(S2*NTT)) =  Sstep ;   % step functon

% SOLVE DE: forward Euler Method =========================================

for m = 1:NTT-1
    v(m+1) = v(m) + (dt  * (k*(v(m) - vr)*(v(m) - vt)-u(m) + S(m))/C)+wgn(1,1,1,0.01); % wgn - Added white noise for background activity
    u(m+1) = u(m) + dt * a*(b*(v(m+1)-vr)-u(m));
    if v(m+1)>= vPeak % a spike is fired!
        v(m)   = vPeak; % padding the spike amplitude
        v(m+1) = c; % membrane voltage reset
        u(m+1) = u(m+1) + d; % recovery variable update
    end % if
end

% GRAPHICS   =============================================================


figure(2)
fs = 12;
set(gcf,'units','normalized');
set(gcf,'position',[0.23, 0.40 0.2 0.25]);
plot(t, u,'lineWidth',2);
xlabel('time  t  [ms]','fontsize',fs);
ylabel('u  [pA]','fontsize',fs);
grid on
set(gca,'fontsize',fs);

figure(3)
fs = 12;
set(gcf,'units','normalized');
set(gcf,'position',[0.44, 0.40 0.2 0.25]);
plot(v, u,'lineWidth',2);
xlabel('v [mV]','fontsize',fs);
ylabel('u  [pA]','fontsize',fs);
grid on
set(gca,'fontsize',fs);

figure(4)
subplot(211)
fs = 12;
%    set(gcf,'units','normalized');
%    set(gcf,'position',[0.02 0.40 0.2 0.25]);
plot(t, v,'lineWidth',2);
xlabel('time  t  [ms]','fontsize',fs);
ylabel('v  [mV]','fontsize',fs);
grid on
set(gca,'fontsize',fs);
% axis([0 1.01*max(t) 1.1*min(v) 1.2*max(v)])
tit=strcat('C = ',num2str(C),'pF');
title(tit)
subplot(212)
fs = 12;
%    set(gcf,'units','normalized');
%    set(gcf,'position',[0.65, 0.40 0.2 0.25]);
plot(t, S, 'r','lineWidth',2);
xlabel('t  [ms]','fontsize',fs);
ylabel('S  [pA]','fontsize',fs);
grid on
set(gca,'fontsize',fs);
