% Inap-Ik model
% Coded by Vignayanandam R. Muddapu (IIT-Madras)
% On 13th April 2020

clear;clear;
close all;

% Iext=0.001; %stable fixed point
Iext=40; %Limit cycle
Nrn=1;

dur=1000;
dt=0.1;
tspan=dt:dt:dur;
Ttime=numel(tspan);

% Parameters
gl=8;
gna=20;
gk=10;
El=-78;
Ena=60;
Ek=-90;
tau_v=1;
tau_n=1;

v=zeros(Nrn,1);
n=zeros(Nrn,1);
dv=zeros(Nrn,Ttime);
dn=zeros(Nrn,Ttime);

for k=1:Ttime
    
    m_inf = 1./(1+exp((-20-v)./15));
    n_inf = 1./(1+exp((-45-v)./5));
    
    v_nxt = v+((Iext-gl.*(v-El)-gna.*m_inf.*(v-Ena)-gk.*n.*(v-Ek))./tau_v)*dt;
    n_nxt = n+((n_inf-n)./tau_n)*dt;
    
    v = v_nxt;
    n = n_nxt;
    
    dv(:,k)=v;
    dn(:,k)=n;
    
    disp(k*dt)
    
end

sec=0.001;
subplot(211)
plot(sec*dt*(1:Ttime),dv)
xlim([0 sec*dt*Ttime])
% ylim([-90 20])
tit=strcat('Iext = ',num2str(Iext));
title(tit)
% xlabel('Time (sec)')
ylabel('V (mV)')
subplot(212)
plot(sec*dt*(1:Ttime),dn)
xlim([0 sec*dt*Ttime])
% ylim([-90 20])
xlabel('Time (sec)')
ylabel('n')

% Nullclines
figure(2)
vnull=-90:1:20;
n_v_null=(Iext-gl.*(vnull-El)-gna.*(1./(1+exp((-20-vnull)./15))).*(vnull-Ena))./(gk.*(vnull-Ek));
n_n_null=1./(1+exp((-45-vnull)./5));
plot(vnull,n_v_null,vnull,n_n_null)
legend('V-null','N-null')
ylim([0 1])

%Computing FFT of V
fs=1000;
F1.ststn=dv;
L1=length(F1.ststn);
f1=(0:L1-1)*fs/L1;
F1.stn=abs(fft(F1.ststn,L1));
F1.stn=F1.stn/max(F1.stn);
F1.s_spkdc = mean(F1.ststn)*ones(1,L1);
F1.stndc=abs(fft(F1.s_spkdc,L1));
F1.stndc=F1.stndc./max(F1.stndc);
figure(3)
plot(f1,(F1.stn-F1.stndc),'b','DisplayName','V');
title('FFT of V')
axis([0 100 0 1]);
