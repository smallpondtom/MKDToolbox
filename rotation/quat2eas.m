function ang = quat2eas(q,seq,unit)
% quat2eas
%   Convert quaternion to Euler angle sequence.
%
%   Author: Tomoki Koike
%   contact: tkoike3@gatech.edu
%
%   Copyright Tomoki Koike 2023
%   Last modified 17:26:57 UTC Thursday, March 9, 2023

    % Quaternion to Euler angle sequence
    arguments (Input)
        q (4,1) double
        seq (1,3) char {mustBeMember(seq,{'ZXZ','ZYX'})} = 'ZYX'
        unit (1,1) string {mustBeMember(unit,["rad","deg"])} = "rad"
    end

    arguments (Output)
        ang (3,1) double
    end
    
    % Unpack quaternions
    q0 = q(1);
    q1 = q(2);
    q2 = q(3);
    q3 = q(4);

    switch seq
        case 'ZYX'
            aSinInput = -2*(q1.*q3 - q0.*q2);
            mask1 = aSinInput >= 1 - 10*eps(class(q0));
            mask2 = aSinInput <= -1 + 10*eps(class(q0));
            mask = mask1 | mask2;
            
            if mask1
                aSinInput = 1;
            elseif mask2
                aSinInput = -1;
            end
            
            ang = [ atan2( 2*(q2.*q3+q0.*q1), q0.^2 - q1.^2 - q2.^2 + q3.^2 ), ...
                asin( aSinInput ), ...
                atan2( 2*(q1.*q2+q0.*q3), q0.^2 + q1.^2 - q2.^2 - q3.^2 )];
        
            if mask
                ang(1) = -sign(aSinInput).* 2 .* atan2(q1, q0);
                ang(3) = 0;
            end

        case 'ZXZ'
            R = quat2rot(q);
            ang = rot2eas(R,'ZXZ');
    end
    
    if unit == "deg"
        ang = rad2deg(ang);
    end
end