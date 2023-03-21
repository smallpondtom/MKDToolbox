function r = quatMul(p,q)
% quatMul
%   Multiply two quaternions.
%
%   Author: Tomoki Koike
%   contact: tkoike3@gatech.edu
%
%   Copyright Tomoki Koike 2023
%   Last modified 17:26:57 UTC Thursday, March 9, 2023

    arguments (Input)
        p (4,1) double
        q (4,1) double {mustBeEqualSize(p,q)}
    end
    
    arguments (Output)
        r (4,1) double
    end
    
    r = zeros(4,1);
    p0 = p(1); q0 = q(1);
    P = p(2:4); Q = q(2:4);
    
    r(1) = p0*q0 - dot(P,Q);
    r(2:4) = p0*Q + q0*P + cross(P,Q);
end
    
% Custom validation function
function mustBeEqualSize(a,b)
    % Test for equal size
    if ~isequal(size(a),size(b))
        eid = 'Size:notEqual';
        msg = 'Size of first input must equal size of second input.';
        throwAsCaller(MException(eid,msg))
    end
end