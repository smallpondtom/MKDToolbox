function R = eul2rot(mu,n,unit)
% eul2rot
%   Convert one axis Euler angle rotation to rotation matrix.
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
        R (3,3) double
    end
    
    n = reshape(n,[3,1]);
    Sn = skewSym3(n);
    I = eye(3);
    
    if unit=="rad"
        R = cos(mu)*I - sin(mu)*Sn + (1-cos(mu))*(n * n');
    else
        R = cosd(mu)*I - sind(mu)*Sn + (1-cosd(mu))*(n * n');
    end
end