function q = eul2quat(mu,n,unit)
% eul2quat
%   Convert one axis Euler angle rotation to quaternion.
%
%   Author: Tomoki Koike
%   contact: tkoike3@gatech.edu
%
%   Copyright Tomoki Koike 2023
%   Last modified 17:26:57 UTC Thursday, March 9, 2023

    arguments (Input)
        mu (1,1) double
        n (3,1) double
        unit (1,1) string {mustBeMember(unit,["rad","deg"])} = "rad"
    end
    
    arguments (Output)
        q (4,1) double
    end
    
    delta = mu / 2;
    if unit=="rad"
        q0 = cos(delta);
        Q = reshape(n,[3,1]) * sin(delta);
        q = [q0; Q];
    else
        q0 = cosd(delta);
        Q = reshape(n,[3,1]) * sind(delta);
        q = [q0; Q];    
    end
end