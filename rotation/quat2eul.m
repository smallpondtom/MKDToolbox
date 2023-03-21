function [mu, n] = quat2eul(q,unit)
% quat2eul
%   Convert quaternion to one axis Euler angle rotation.
%
%   Author: Tomoki Koike
%   contact: tkoike3@gatech.edu
%
%   Copyright Tomoki Koike 2023
%   Last modified 17:26:57 UTC Thursday, March 9, 2023

    arguments (Input)
        q (4,1) double
        unit (1,1) string {mustBeMember(unit,["rad","deg"])} = "rad"
    end
    
    arguments (Output)
        mu (1,1) double
        n (3,1) double
    end
    
    q0 = q(1);
    Q = q(2:4);
    
    % Find the vector
    Qnorm = norm(Q);
    n = Q / Qnorm;
    
    % Find the angle
    mu = 2 * atan2(Qnorm, q0);
    
    if unit=="deg"
        mu = rad2deg(mu);
    end
end