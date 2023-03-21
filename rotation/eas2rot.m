function [R,all_R] = eas2rot(ang,seq,options)
% eas2rot
%   Convert Euler angle sequence to rotation matix.
%
%   Author: Tomoki Koike
%   contact: tkoike3@gatech.edu
%
%   Copyright Tomoki Koike 2023
%   Last modified 17:26:57 UTC Thursday, March 9, 2023

    arguments (Input)
        ang (3,1) double {mustBeNumeric,mustBeReal}
        seq (1,3) char {mustBeMember(seq,{'XYX','XYZ','XZX','XZY','YXY',...
            'YXZ','YZX','YZY','ZXY','ZXZ','ZYX','ZYZ'})} = 'ZYX'
        options.type (1,1) string {mustBeMember(options.type,["intrinsic",...
            "extrinsic","body","space"])} = "intrinsic"
        options.unit (1,1) string {mustBeMember(options.unit,["rad","deg"])} = "rad"
    end
    
    arguments (Output)
        R (3,3) double
        all_R (3,1) cell
    end
  
    all_R = cell(3,1);
    R = eye(3);
    if (options.type=="intrinsic") || (options.type=="body")
        for i = 1:3
            Ri = rotXYZ(ang(i),seq(i),options.unit);
            all_R{i} = Ri;
            R = Ri * R;
        end
    else
        Lambda = eye(3);
        choose_axis = dictionary(["X","Y","Z"],[1,2,3]);
        for i = 1:3
            Ri = eul2rot(ang(i),Lambda(:,choose_axis(seq(i))),options.unit);
            all_R{i} = Ri;
            R = Ri * R;
            Lambda = Ri * Lambda;
        end
    end
end