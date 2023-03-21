function ang = rot2eas(R,seq,unit)
% rot2eas
%   Convert rotation matrix to Euler angle sequence.
%
%   Author: Tomoki Koike
%   contact: tkoike3@gatech.edu
%
%   Copyright Tomoki Koike 2023
%   Last modified 17:26:57 UTC Thursday, March 9, 2023

    % Rotation matrix to Euler Angle Sequence (phi, theta, psi)
    arguments (Input)
        R (3,3) double
        seq (1,3) char {mustBeMember(seq,{'ZXZ','ZYX'})} = 'ZYX'
        unit (1,1) string {mustBeMember(unit,["rad","deg"])} = "rad"
    end
    
    arguments (Output)
        ang (3,1) double
    end
    
    switch seq
        case 'ZYX'
            phi = atan2(R(2,3),R(3,3));
            theta = -asin(R(1,3));
            psi = atan2(R(1,2),R(1,1));
            ang = [phi; theta; psi];
        case 'ZXZ'
            phi = -atan2(R(3,1),R(3,2));
            theta = acos(R(3,3));
            psi = atan2(R(1,3),R(2,3));
            ang = [phi; theta; psi];
        otherwise
            error("Incorrect sequence.");
    end
    
    if unit == "deg"
        ang = rad2deg(ang);
    end
end