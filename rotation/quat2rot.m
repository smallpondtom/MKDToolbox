function R = quat2rot(q)
% quat2rot
%   Convert quaternion to rotation matrix.
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
        R (3,3) double
    end
    
    % Extract values
    q0 = q(1);
    q1 = q(2);
    q2 = q(3);
    q3 = q(4);
    
    % Compute rotation matrix with homogeneous expression
    R = zeros(3,3);
    R(1,1) = q0^2 + q1^2 - q2^2 - q3^2;
    R(2,1) = 2 * (q1*q2 - q0*q3);
    R(3,1) = 2 * (q0*q2 + q1*q3);
    R(1,2) = 2 * (q1*q2 + q0*q3);
    R(2,2) = q0^2 - q1^2 + q2^2 - q3^2;
    R(3,2) = 2 * (q2*q3 - q0*q1);
    R(1,3) = 2 * (q1*q3 - q0*q2);
    R(2,3) = 2 * (q0*q1 + q2*q3);
    R(3,3) = q0^2 - q1^2 - q2^2 + q3^2;
end