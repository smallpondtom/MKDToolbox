function pqr = angdot2pqr(ang,ang_dot,seq,unit)
% angdot2pqr
%   Convert attitude roll, pitch, and yaw rates to angular velocity.
%
%   Author: Tomoki Koike
%   contact: tkoike3@gatech.edu
%
%   Copyright Tomoki Koike 2023
%   Last modified 18:58:44 UTC Sunday, March 12, 2023

    arguments (Input)
        ang (3,1) double {mustBeNumeric,mustBeReal}
        ang_dot (3,1) double {mustBeNumeric,mustBeReal}
        seq (1,3) char {mustBeMember(seq,{'ZXZ','ZYX'})} = 'ZYX'
        unit (1,1) string {mustBeMember(unit,["rad","deg"])} = "rad"
    end

    arguments (Output)
        pqr (3,1) double {mustBeNumeric,mustBeReal}
    end

    phi = ang(1);
    theta = ang(2);
        
    switch seq
        case 'ZYX'
            if unit == "rad"
                R = [1 0 -sin(theta);
                     0 cos(phi) sin(phi)*cos(theta);
                     0 -sin(phi) cos(phi)*cos(theta)];
            else
                R = [1 0 -sind(theta);
                     0 cosd(phi) sind(phi)*cosd(theta);
                     0 -sind(phi) cosd(phi)*cosd(theta)];
            end
            pqr = R * ang_dot;
        case 'ZXZ'
            if unit == "rad"
                R = [0 cos(phi) sin(theta)*sin(phi);
                     0 -sin(phi) sin(theta)*cos(phi);
                     1 0 cos(theta)];
            else
                R = [0 cosd(phi) sind(theta)*sind(phi);
                     0 -sind(phi) sind(theta)*cosd(phi);
                     1 0 cosd(theta)];
            end
            pqr = R * ang_dot;
    end

end