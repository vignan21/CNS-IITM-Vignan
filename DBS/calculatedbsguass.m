function w = calculatedbsguass(nlat, sig, rad)

%% CREDITS
% Created by
% Vignayanandam R. Muddapu (Ph.D. scholar)
% C/o Prof. V. Srinivasa Chakravarthy
% Indian Institute of Technology Madras
% India

%% INPUTS
% nlat = size of the window. It must be an odd number.
% sig = max strength of the connections
% rad = radius of neighborhood

%% OUTPUTS
% w = weighted gaussian kernel

%% CODE
w = zeros(nlat, nlat);
ic = (nlat+1)/2;
jc = (nlat+1)/2;

for i = 1:nlat,
   for j = 1:nlat,
        dis = (i-ic)*(i-ic) + (j-jc)*(j-jc);
        w(i, j) = sig*exp(-dis/(rad*rad)) ; 
%         if(i==j)
%             w(i,j)=0;
%         end
   end
%    mesh(w);
end