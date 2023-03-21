function qq = quatNorm(q)
% quatNorm
%   Take the norm of a quaterion.
%
%   Author: Tomoki Koike
%   contact: tkoike3@gatech.edu
%
%   Copyright Tomoki Koike 2023
%   Last modified 17:26:57 UTC Thursday, March 9, 2023

    arguments (Input)
        q (4,1) double
    end
    
    arguments (Output)
        qq (1,1) double
    end
    
    qq = q(1)^2 + q(2)^2 + q(3)^2 + q(4)^2;
end