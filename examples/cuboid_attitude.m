% Author: Tomoki Koike
% Contact: tkoike@gatech.edu

%% Housekeeping commands
clear; close all; clc;
set(groot, 'defaulttextinterpreter','latex');
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');
sympref('FloatingPointOutput', false);  % fractions in symbolic
addpath("../rotation");   % add function files from utils
addpath("../ode");   % add function files from ode

%% Setup
% Mass and dimensions of the object
m = 1;  % mass
w = 8;  % width
d = 5;  % depth
h = 2;  % height
params.m = m;
params.w = w;
params.d = d;
params.h = h;

% MoI 
Ix = m * (h^2 + d^2) / 12;
Iy = m * (w^2 + h^2) / 12;
Iz = m * (w^2 + d^2) / 12;
params.I = [Ix 0 0; 0 Iy 0; 0 0 Iz];

% Timespan
tspan = 0.0:10e-3:300.0;

% Aircraft and Spacecraft definitions
ACdef = 'ZYX';
SCdef = 'ZXZ';

% Create Cell to store all data
data = {struct(); struct(); struct()};

%% (a)

%%%%%%%%%%%%%%%%%%%%%%%
% Aircraft Definition
%%%%%%%%%%%%%%%%%%%%%%%
eas0 = zeros(3,1);  % initial condition of phi, theta, psi
data{1} = simulate(data{1},eas0,[0.2; 0; 0.002],tspan,params,ACdef);

%%%%%%%%%%%%%%%%%%%%%%%%%
% Spacecraft Definition
%%%%%%%%%%%%%%%%%%%%%%%%%
data{1} = simulate(data{1},eas0,[0.2; 0; 0.002],tspan,params,SCdef);

%% (b)

%%%%%%%%%%%%%%%%%%%%%%%
% Aircraft Definition
%%%%%%%%%%%%%%%%%%%%%%%
data{2} = simulate(data{2},eas0,[0.002; 0; 0.2],tspan,params,ACdef);

%%%%%%%%%%%%%%%%%%%%%%%%%
% Spacecraft Definition
%%%%%%%%%%%%%%%%%%%%%%%%%
data{2} = simulate(data{2},eas0,[0.002; 0; 0.2],tspan,params,SCdef);

%% (c)

%%%%%%%%%%%%%%%%%%%%%%%
% Aircraft Definition
%%%%%%%%%%%%%%%%%%%%%%%
data{3} = simulate(data{3},eas0,[0.0; 0.2; 0.002],tspan,params,ACdef);

%%%%%%%%%%%%%%%%%%%%%%%%%
% Spacecraft Definition
%%%%%%%%%%%%%%%%%%%%%%%%%
data{3} = simulate(data{3},eas0,[0.0; 0.2; 0.002],tspan,params,SCdef);

%% Visualization

%%%%%%%%%%%%%%%%%%%%%%%
% Angular Velocity
%%%%%%%%%%%%%%%%%%%%%%%
fig = figure(Renderer="painters",Position=[60 60 800 930]);
tile = tiledlayout(3,1,TileSpacing="compact",Padding="tight");
for i = 1:3
    nexttile(i);
    plot(data{i}.ac.t,data{i}.ac.omega_p(:,1),DisplayName="$P$")
    hold on; grid on; grid minor; box on; 
    plot(data{i}.ac.t,data{i}.ac.omega_p(:,2),DisplayName="$Q$")
    plot(data{i}.ac.t,data{i}.ac.omega_p(:,3),DisplayName="$R$")
    hold off; legend(FontSize=12); 
end
ylabel(tile,"Angular Velocity [deg/s]",FontSize=12,Interpreter='latex')
xlabel(tile,'$t$ [s]','FontSize',12,'Interpreter','latex')
saveas(fig,"../plots/cuboid_attitude/ang_vel.pdf");

%%%%%%%%%%%%%%%%%%%%%%%%%
% Attitude Angle A/C
%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure(Renderer="painters",Position=[60 60 800 930]);
tile = tiledlayout(3,1,TileSpacing="compact",Padding="tight");
for i = 1:3
    nexttile(i);
    % Poisson
    plot(data{i}.ac.t,data{i}.ac.atd_p(:,1),'r-',DisplayName="$\phi_p$")
    hold on; grid on; grid minor; box on; 
    plot(data{i}.ac.t,data{i}.ac.atd_p(:,2),'r--',DisplayName="$\theta_p$")
    plot(data{i}.ac.t,data{i}.ac.atd_p(:,3),'r:',DisplayName="$\psi_p$")
    % Quaternion
    plot(data{i}.ac.t,data{i}.ac.atd_q(:,1),'b-',DisplayName="$\phi_q$")
    plot(data{i}.ac.t,data{i}.ac.atd_q(:,2),'b--',DisplayName="$\theta_q$")
    plot(data{i}.ac.t,data{i}.ac.atd_q(:,3),'b:',DisplayName="$\psi_q$")
    hold off; legend(FontSize=12);
end
ylabel(tile,"Angular Velocity [deg/s]",FontSize=12,Interpreter='latex')
xlabel(tile,'$t$ [s]','FontSize',12,'Interpreter','latex')
saveas(fig,"../plots/cuboid_attitude/attitude_AC.pdf");

%%%%%%%%%%%%%%%%%%%%%%%%%
% Attitude Angle S/C
%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure(Renderer="painters",Position=[60 60 800 930]);
tile = tiledlayout(3,1,TileSpacing="compact",Padding="tight");
for i = 1:3
    nexttile(i);
    % Poisson
    plot(data{i}.sc.t,data{i}.sc.atd_p(:,1),'r-',DisplayName="$\phi_p$")
    hold on; grid on; grid minor; box on; 
    plot(data{i}.sc.t,data{i}.sc.atd_p(:,2),'r--',DisplayName="$\theta_p$")
    plot(data{i}.sc.t,data{i}.sc.atd_p(:,3),'r:',DisplayName="$\psi_p$")
    % Quaternion
    plot(data{i}.sc.t,data{i}.sc.atd_q(:,1),'b-',DisplayName="$\phi_q$")
    plot(data{i}.sc.t,data{i}.sc.atd_q(:,2),'b--',DisplayName="$\theta_q$")
    plot(data{i}.sc.t,data{i}.sc.atd_q(:,3),'b:',DisplayName="$\psi_q$")
    hold off; legend(FontSize=12);
end
ylabel(tile,"Angular Velocity [deg/s]",FontSize=12,Interpreter='latex')
xlabel(tile,'$t$ [s]','FontSize',12,'Interpreter','latex')
saveas(fig,"../plots/cuboid_attitude/attitude_SC.pdf");


%% Functions
function data = simulate(data, eas0, omega0, tspan, params, def)
    rot0 = eas2rot(eas0,def);  % convert the above into rotation matrix
    quat0 = eas2quat(eas0,def);  % convert the above into quaternions
    
    IC_p = [rot0(:); omega0];  % initial conditions for the Poisson
    IC_q = [quat0; omega0];  % initial conditions for the Quaternion
    
    % Simulate
    [tp,Xp] = ode45(@(t,X) PKDEE(t,X,params), tspan, IC_p);
    [tq,Xq] = ode45(@(t,X) QKDEE(t,X,params), tspan, IC_q);
    t = all(tp == tq) * tp;
    
    % Convert data
    atd_p = zeros(length(t),3);  % phi theta psi (from Poisson)
    atd_q = zeros(length(t),3);  % phi theta psi (from Quaternion)
    for i = 1:length(t)
        atd_p(i,:) = rot2eas(transpose(reshape(Xp(i,1:9),[3,3])),def,"deg");
        atd_q(i,:) = quat2eas(Xq(i,1:4),def,"deg");
    end
    
    % Store results
    switch def
        case 'ZYX'
            data.ac.atd_p = atd_p;
            data.ac.atd_q = atd_q;
            data.ac.t = t;
            data.ac.omega_p = Xp(:,10:12);
            data.ac.omega_q = Xq(:,5:7);
        case 'ZXZ'
            data.sc.atd_p = atd_p;
            data.sc.atd_q = atd_q;
            data.sc.t = t;
            data.sc.omega_p = Xp(:,10:12);
            data.sc.omega_q = Xq(:,5:7);
    end
end
