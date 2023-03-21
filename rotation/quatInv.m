function qinv = quatInv(q)
% quatInv
%   Invert a quaternion.
%
%   Author: Tomoki Koike
%   contact: tkoike3@gatech.edu
%
%   Copyright Tomoki Koike 2023
%   Last modified 17:26:57 UTC Thursday, March 9, 2023

    % This quaternion is defined as 
    % q = [q0 Q]^T
    % where q0 is the scalar component and Q is the vector.
    arguments (Input)
        q (4,1) double
    end
    
    arguments (Output)
        qinv (4,1) double
    end
    
    q0 = q(1);
    Q = reshape(q(2:4),[3,1]);
    qinv =  [q0; -Q] / quatNorm(q);
end