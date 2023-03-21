function q = quatXYZ(alpha,axis)
% quatXYZ
%   Construct quaternion for a one axis rotation.
%
%   Author: Tomoki Koike
%   contact: tkoike3@gatech.edu
%
%   Copyright Tomoki Koike 2023
%   Last modified 17:26:57 UTC Thursday, March 9, 2023

    arguments (Input)
        alpha (1,1) {mustBeNumeric,mustBeReal}
        axis (1,1) char {mustBeMember(axis,{'X','Y','Z'})}
    end
    
    arguments (Output)
        q (4,1) double
    end
  
    if axis == 'X'
        q = [cos(alpha/2); sin(alpha/2); 0; 0];
    elseif axis == 'Y'
        q = [cos(alpha/2); 0; sin(alpha/2); 0];
    else
        q = [cos(alpha/2); 0; 0; sin(alpha/2)];
    end
end