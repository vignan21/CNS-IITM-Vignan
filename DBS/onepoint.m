function Idbs=onepoint(Idbs,tempdbs,nlat,radius,k) 

%% CREDITS
% Created by
% Vignayanandam R. Muddapu (Ph.D. scholar)
% C/o Prof. V. Srinivasa Chakravarthy
% Indian Institute of Technology Madras
% India

% Creates one contact point DBS current

%% INPUTS
% Idbs = initial Idbs (with NxN size) of zeros
% tempdbs = output of biphasic or monophasic function
% nlat = size of gaussian window
% radius = radius of gaussian neighborhood
% k = iteration number

%% OUTPUTS
% Idbs = modified Idbs (with NxN size) of nonzeros

%% CODE
position1=1;
position2=32;

wdbs = calculatedbsguass(nlat, tempdbs(k), radius);
    Idbs(position1:position2,position1:position2)=wdbs; 
%     figure(1)
%     surf(Idbs);
%     pause(0.01)
end