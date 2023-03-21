function ang_dot = pqr2angdot(ang,omega,seq,unit)
% pqr2angdot
%   Convert angular velocity to attitude roll, pitch, and yaw rates.
%
%   Author: Tomoki Koike
%   contact: tkoike3@gatech.edu
%
%   Copyright Tomoki Koike 2023
%   Last modified 18:58:44 UTC Sunday, March 12, 2023

    arguments (Input)
        ang (3,1) double {mustBeNumeric,mustBeReal}
        omega (3,1) double {mustBeNumeric,mustBeReal}
        seq (1,3) char {mustBeMember(seq,{'ZXZ','ZYX'})} = 'ZYX'
        unit (1,1) string {mustBeMember(unit,["rad","deg"])} = "rad"
    end

    arguments (Output)
        ang_dot (3,1) double {mustBeNumeric,mustBeReal}
    end

    phi = ang(1);
    theta = ang(2);
        
    switch seq
        case 'ZYX'
            if unit == "rad"
                Rinv = [1 sin(phi)*tan(theta) cos(phi)*tan(theta);
                        0 cos(phi) -sin(phi);
                        0 sin(phi)*sec(theta) cos(phi)*sec(theta)];
            else
                Rinv = [1 sind(phi)*tand(theta) cosd(phi)*tand(theta);
                        0 cosd(phi) -sind(phi);
                        0 sind(phi)*secd(theta) cosd(phi)*secd(theta)];  
            end
            ang_dot = Rinv * omega;
        case 'ZXZ'
            if unit == "rad"
                Rinv = [-sin(phi)*tan(theta) -cos(phi)*tan(theta) 1;
                        cos(phi) -sin(phi) 0;
                        sin(phi)*csc(theta) cos(phi)*csc(theta) 0];
            else
                Rinv = [-sind(phi)*tand(theta) -cosd(phi)*tand(theta) 1;
                        cosd(phi) -sind(phi) 0;
                        sind(phi)*cscd(theta) cosd(phi)*cscd(theta) 0];
            end
            ang_dot = Rinv * omega;
    end

end