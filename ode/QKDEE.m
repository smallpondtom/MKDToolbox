function Xdot = QKDEE(t,X,params)
% QKDEE
%   Quaternion kinematical and dynamical differential equations for an cuboid 
%   cuboid object.
%
%   Author: Tomoki Koike
%   contact: tkoike3@gatech.edu
%
%   Copyright Tomoki Koike 2023
%   Last modified 17:26:57 UTC Thursday, March 9, 2023

    % Quaternion Kinematical & Dynamical Differential Equation
    % Unpack parameters
    Ix = params.I(1,1);
    Iy = params.I(2,2);
    Iz = params.I(3,3);

    % Unpack the variables
    P = X(5);
    Q = X(6);
    R = X(7);

    % Preallocate the derivative vector
    Xdot = zeros(7,1);

    % ODE
    M = [0 -P -Q -R;
         P  0  R -Q;
         Q -R  0  P;
         R  Q -P  0];
    Xdot(1:4) = 0.5 * M * X(1:4);
    Xdot(5) = (Iy - Iz) / Ix * Q * R;
    Xdot(6) = (Iz - Ix) / Iy * R * P;
    Xdot(7) = (Ix - Iy) / Iz * P * Q;
end