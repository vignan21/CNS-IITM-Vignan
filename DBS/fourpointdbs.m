function Idbs=fourpointdbs(Idbs,tempdbs,radius,k)

%% CREDITS
% Created by
% Vignayanandam R. Muddapu (Ph.D. scholar)
% C/o Prof. V. Srinivasa Chakravarthy
% Indian Institute of Technology Madras
% India

% Creates four contact point DBS current

%% INPUTS
% Idbs = initial Idbs (with NxN size) of zeros
% tempdbs = output of biphasic or monophasic function
% radius = radius of gaussian neighborhood
% k = iteration number

%% OUTPUTS
% Idbs = modified Idbs (with NxN size) of nonzeros

%% CODE
% position
estart=9;
estop=25;

% radius=2.5;

wdbs1 = gauss2d(Idbs, tempdbs(1,k), radius,[estart estart]);
wdbs2 = gauss2d(Idbs, tempdbs(2,k), radius,[estart estop]);
wdbs3 = gauss2d(Idbs, tempdbs(3,k), radius,[estop estop]);
wdbs4 = gauss2d(Idbs, tempdbs(4,k), radius,[estop estart]);

Idbs=wdbs1+wdbs2+wdbs3+wdbs4;

% imagesc(Idbs);colorbar

end