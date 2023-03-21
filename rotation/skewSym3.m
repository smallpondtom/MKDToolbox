function S = skewSym3(vec)
% skewSym3
%   Construct a skew symmetric matrix for a 3d vector.
%
%   Author: Tomoki Koike
%   contact: tkoike3@gatech.edu
%
%   Copyright Tomoki Koike 2023
%   Last modified 17:26:57 UTC Thursday, March 9, 2023

  arguments (Input)
    vec (3,1) double {mustBeVector}
  end
  
  arguments (Output)
    S (3,3) double
  end

  v1 = vec(1);
  v2 = vec(2);
  v3 = vec(3);

  S = [  0 -v3  v2;
        v3   0 -v1;
       -v2  v1   0];
end