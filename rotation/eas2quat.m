function [q,all_q] = eas2quat(ang,seq,options)
% eas2quat
%   Convert Euler angle sequence to quaternions.
%
%   Author: Tomoki Koike
%   contact: tkoike3@gatech.edu
%
%   Copyright Tomoki Koike 2023
%   Last modified 17:26:57 UTC Thursday, March 9, 2023

    arguments (Input)
        ang (3,1) double {mustBeNumeric,mustBeReal}
        seq (1,3) char {mustBeMember(seq,{'XYX','XYZ','XZX','XZY','YXY', ...
          'YXZ','YZX','YZY','ZXY','ZXZ','ZYX','ZYZ'})} = 'ZYX'
        options.type (1,1) string {mustBeMember(options.type,["intrinsic", ...
          "extrinsic","body","space"])} = "intrinsic"
        options.unit (1,1) string {mustBeMember(options.unit,["rad","deg"])} = "rad"
    end

    arguments (Output)
        q (4,1) double
        all_q (3,1) cell
    end
  
    all_q = cell(3,1);
    q = [1; 0; 0; 0];
    if (options.type=="intrinsic") || (options.type=="body")
        for i = 1:3
            qi = quatXYZ(ang(i),seq(i));
            all_q{i} = qi;
            q = quatMul(q, qi);  % Lbv * Vv = q^(-1) * Vv * q
        end        
    else
        Lambda = eye(3);
        choose_axis = dictionary(["X","Y","Z"],[1,2,3]);
        for i = 1:3
            Ri = eul2rot(ang(i),Lambda(:,choose_axis(seq(i))),options.unit);
            qi = eul2quat(ang(i),Lambda(:,choose_axis(seq(i))),options.unit);
            all_q{i} = qi;
            q = quatMul(q, qi);
            Lambda = Ri * Lambda;
        end
    end
end
