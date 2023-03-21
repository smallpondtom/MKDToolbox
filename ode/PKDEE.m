function Xdot = PKDEE(t,X,params)
% PKDEE
%   Poisson's kinematical and dynamical differential equations for an cuboid 
%   cuboid object.
%
%   Author: Tomoki Koike
%   contact: tkoike3@gatech.edu
%
%   Copyright Tomoki Koike 2023
%   Last modified 17:26:57 UTC Thursday, March 9, 2023

    % Poisson's Kinematical & Dynamical Differential Equation
    % Unpack parameters
    Ix = params.I(1,1);
    Iy = params.I(2,2);
    Iz = params.I(3,3);

    % Unpack the variables
    l11 = X(1);
    l12 = X(2);
    l13 = X(3);
    l21 = X(4);
    l22 = X(5);
    l23 = X(6);
    l31 = X(7);
    l32 = X(8);
    l33 = X(9);
    P = X(10);
    Q = X(11);
    R = X(12);

    % Preallocate the derivative vector
    Xdot = zeros(12,1);

    % ODE
    Xdot(1) = l21 * R - l31 * Q;
    Xdot(2) = l22 * R - l32 * Q;
    Xdot(3) = l23 * R - l33 * Q;
    Xdot(4) = l31 * P - l11 * R;
    Xdot(5) = l32 * P - l12 * R;
    Xdot(6) = l33 * P - l13 * R;
    Xdot(7) = l11 * Q - l21 * P;
    Xdot(8) = l12 * Q - l22 * P;
    Xdot(9) = l13 * Q - l23 * P;
    Xdot(10) = (Iy - Iz) / Ix * Q * R;
    Xdot(11) = (Iz - Ix) / Iy * R * P;
    Xdot(12) = (Ix - Iy) / Iz * P * Q;
end