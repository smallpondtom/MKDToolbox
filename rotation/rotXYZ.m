function R = rotXYZ(alpha,axis,unit)
% rotXYZ
%   Construct rotation matrix for a one axis rotation.
%
%   Author: Tomoki Koike
%   contact: tkoike3@gatech.edu
%
%   Copyright Tomoki Koike 2023
%   Last modified 17:26:57 UTC Thursday, March 9, 2023

    arguments (Input)
        alpha (1,1) {mustBeNumeric,mustBeReal}
        axis (1,1) char {mustBeMember(axis,{'X','Y','Z'})}
        unit (1,1) string {mustBeMember(unit,["rad","deg"])} = "rad"
    end
    
    arguments (Output)
        R (3,3) double
    end
  
    if axis == 'X'
        if unit == "rad"
            R = [1 0         0; 
                 0 cos(alpha)  sin(alpha);
                 0 -sin(alpha) cos(alpha)];
        else
            R = [1 0          0; 
                 0 cosd(alpha)  sind(alpha);
                 0 -sind(alpha) cosd(alpha)];
        end
    elseif axis == 'Y'
        if unit == "rad"
            R = [cos(alpha) 0 -sin(alpha); 
                 0          1 0;
                 sin(alpha) 0 cos(alpha)];
        else
            R = [cosd(alpha) 0 -sind(alpha); 
                 0           1 0;
                 sind(alpha) 0 cosd(alpha)];
        end
    else
        if unit == "rad"
            R = [cos(alpha)  sin(alpha) 0;
                 -sin(alpha) cos(alpha) 0
                 0         0        1];
        else
            R = [cosd(alpha)  sind(alpha) 0;
                 -sind(alpha) cosd(alpha) 0
                 0         0          1];
        end
    end
end