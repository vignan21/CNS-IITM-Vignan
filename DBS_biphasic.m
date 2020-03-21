%% CREDITS
% Created by
% Vignayanandam R. Muddapu (Ph.D. scholar)
% C/o Prof. V. Srinivasa Chakravarthy
% Indian Institute of Technology Madras
% India

% Biphasic waveform with different configurations

%% CODE
dur=1000;%msec
dt=0.1;
tspan=dt:dt:dur;
Ttime=numel(tspan);

amp=300;%pA
dc=0.2;%usec
freq=130;%Hz

Mstn=32;Nstn=32;%size of STN network

Idbs=zeros(Mstn,Nstn);

k1=1;DBSon=1;
scp=0;% single contact point
fcp=0;% four contact point
mcp=1;% multiple contact point

if scp==1
    tempdbs=biphasic(amp,dc,Ttime,freq);
end

if fcp==1
    fcp=4;
    tempdbs=zeros(fcp,Ttime+1);
    temp=biphasic_random(amp,dc,Ttime+2000,freq);
    for i=1:fcp
        jj=round((1000-1).*rand(1,1) + 1);
        tempdbs(i,:)=temp(jj:jj+Ttime);
    end
end

if mcp==1
    tempdbs=zeros(Mstn,Nstn,Ttime+1);
    temp=biphasic_random(amp,dc,Ttime+2000,freq);
    for i=1:Mstn
        for j=1:Nstn
            jj=round((1000-1).*rand(1,1) + 1);
            tempdbs(i,j,:)=temp(jj:jj+Ttime);
        end
    end
end

for k = 1:Ttime
    
    %----------------------------------------DBS-----------------------------------------%
    %------------------------------DBS current single point------------------------------%
    if(DBSon==1)
        if scp==1
            nlatdbs=32;
            radiusdbs=5;
            Idbs=onepoint(Idbs,tempdbs,nlatdbs,radiusdbs,k1);
        end
    %------------------------------DBS current four point--------------------------------%
        if fcp==1
            radiusdbs=2;
            Idbs=fourpointdbs_new(Idbs,tempdbs,radiusdbs,k);
        end
    %----------------------------DBS current multiple point------------------------------%  
        if mcp==1 
            Idbs=tempdbs(:,:,k1);
        end
        
        k1=k1+1;
    end
    
    imagesc(Idbs);colorbar;pause(0.1)
    
    Idbs=zeros(Mstn,Nstn);
    
    disp(k*dt)
    
end
