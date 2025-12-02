% Contributors: Chris Westerlund, Teddy Klein, Katherine Korobov
% Course Number: ASEN 3801
% File Name: Main3801Lab5.m
% Created: 11/11/2025

clc;
clear;
close all;

%Aircraft Parameters
aircraft_parameters.g = 9.81;           % Gravitational acceleration [m/s^2]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Aircraft geometry parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
aircraft_parameters.S = 0.6282; %[m^2]
aircraft_parameters.b = 3.067; %[m]
aircraft_parameters.c = 0.208; %[m]
aircraft_parameters.AR = aircraft_parameters.b*aircraft_parameters.b/aircraft_parameters.S;

aircraft_parameters.m = 5.74; %[kg]
aircraft_parameters.W = aircraft_parameters.m*aircraft_parameters.g; %[N]


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inertias from Solidworks model of Tempest
% These need to be validated, especially for Ttwistor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SLUGFT2_TO_KGM2 = 14.5939/(3.2804*3.2804);
aircraft_parameters.Ix = SLUGFT2_TO_KGM2*4106/12^2/32.2; %[kg m^2]
aircraft_parameters.Iy = SLUGFT2_TO_KGM2*3186/12^2/32.2; %[kg m^2]
aircraft_parameters.Iz = SLUGFT2_TO_KGM2*7089/12^2/32.2; %[kg m^2]
aircraft_parameters.Ixz = SLUGFT2_TO_KGM2*323.5/12^2/32.2; %[kg m^2]


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Drag terms determined by curve fit to CFD analysis performed by Roger
% Laurence. Assumes general aircraft drag model
%       CD = CDmin + K(CL-CLmin)^2
% or equivalently
%       CD = CD0 + K1*CL + K*CL^2
% where
%       CD0 = CDmin + K*CLmin^2
%       K1  = -2K*CLmin
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
aircraft_parameters.CDmin = 0.0240;
aircraft_parameters.CLmin = 0.2052;
aircraft_parameters.K = 0.0549;
aircraft_parameters.e = 1/(aircraft_parameters.K*aircraft_parameters.AR*pi);

aircraft_parameters.CD0 = aircraft_parameters.CDmin+aircraft_parameters.K*aircraft_parameters.CLmin*aircraft_parameters.CLmin;
aircraft_parameters.K1 = -2*aircraft_parameters.K*aircraft_parameters.CLmin;
aircraft_parameters.CDpa = aircraft_parameters.CD0;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Engine parameters, assuming model from Beard and Mclain that gives zero
% thrust for zero throttle
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
aircraft_parameters.Sprop = 0.0707;
aircraft_parameters.Cprop = 1;
aircraft_parameters.kmotor = 30;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Zero angle of attack aerodynamic forces and moments
% - some sources (like text used for ASEN 3128) define the body
%   coordinate system as the one that gives zero total lift at 
%   zero angle of attack
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
aircraft_parameters.CL0 = 0.2219;
aircraft_parameters.Cm0 = 0.0519;

aircraft_parameters.CY0 = 0;
aircraft_parameters.Cl0 = 0;
aircraft_parameters.Cn0 = 0;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Longtidunal nondimensional stability derivatives from AVL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
aircraft_parameters.CLalpha = 6.196683; 
aircraft_parameters.Cmalpha = -1.634010; 
aircraft_parameters.CLq = 10.137584; 
aircraft_parameters.Cmq = -24.376066;

% Neglected parameters, check units below if incorporated later
aircraft_parameters.CLalphadot = 0; 
aircraft_parameters.Cmalphadot = 0; 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Lateral-directional nondimensional stability derivatives from AVL
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
aircraft_parameters.CYbeta = -0.367231; 
aircraft_parameters.Clbeta = -0.080738; 
aircraft_parameters.Cnbeta = 0.080613; 
aircraft_parameters.CYp = -0.064992;
aircraft_parameters.Clp = -0.686618;
aircraft_parameters.Cnp = -0.039384;
aircraft_parameters.Clr = 0.119718;
aircraft_parameters.Cnr = -0.052324;
aircraft_parameters.CYr = 0.213412;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Control surface deflection parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  % Elevator
  aircraft_parameters.CLde =   0.006776;
  aircraft_parameters.Cmde =  -0.06; 

  % Aileron
  aircraft_parameters.CYda =  -0.000754;
  aircraft_parameters.Clda =  -0.02; 
  aircraft_parameters.Cnda =  -0.000078;
 
  % Rudder
  aircraft_parameters.CYdr =   0.003056;
  aircraft_parameters.Cldr =   0.000157;
  aircraft_parameters.Cndr =  -0.000856;

time= 200;

%Toggle 
prob_2_1 = 0;
prob_2_2 = 0;
prob_2_3 = 0;
prob_3 = 1;

%% Problem 2

aircraft_state_1 = [0;0;-1608.34;0;0;0;21;0;0;0;0;0];
aircraft_surfaces_1 = [0;0;0;0];
wind_inertial = [0;0;0];

aircraft_state_2 = [0;0;-1800;0;0.02780;0;20.99;0;0.5837;0;0;0];
aircraft_surfaces_2 = [0.1079;0;0;0.3182];

aircraft_state_3 = [0;0;-1800;15*pi/180;-12*pi/180;270*pi/180;19;3;-2;0.08*pi/180;-0.2*pi/180;0];
aircraft_surfaces_3 = [5*pi/180;2*pi/180;-13*pi/180;0.3];

odefun1 = @(time,aircraft_state) AircraftEOM(time, aircraft_state, aircraft_surfaces_1, wind_inertial,aircraft_parameters);
[t1,X1] = ode45(odefun1,[0,time],aircraft_state_1);
U1 = zeros(4,length(X1));

odefun2 = @(time,aircraft_state) AircraftEOM(time, aircraft_state, aircraft_surfaces_2, wind_inertial,aircraft_parameters);
[t2,X2] = ode45(odefun2,[0,time],aircraft_state_2);
U2 = zeros(4,length(X2));

odefun3 = @(time,aircraft_state) AircraftEOM(time, aircraft_state, aircraft_surfaces_3, wind_inertial,aircraft_parameters);
[t3,X3] = ode45(odefun3,[0,time],aircraft_state_3);
U3 = zeros(4,length(X3));

if prob_2_1
    PlotAircraftSim(t1, X1, U1, [1,2,3,4,5,6], 'b');
end

if prob_2_2
    PlotAircraftSim(t2, X2, U2, [7,8,9,10,11,12], 'b');
end

if prob_2_3
    PlotAircraftSim(t3, X3, U3, [13,14,15,16,17,18], 'b');
end

%% Problem 3
time_4 = 10; %[s]
doublet_size = 15 * pi/180; %Rads
doublet_time = 0.25; %seconds

aircraft_state_4 = [0;0;-1800;0;0.02780;0;20.99;0;0.5837;0;0;0];
aircraft_surfaces_4 = [0.1079;0;0;0.3182];

odefun4=@(time,aircraft_state) AircraftEOMDoublet(time, aircraft_state, aircraft_surfaces_4, doublet_size, doublet_time, wind_inertial, aircraft_parameters);
[t4,X4] = ode45(odefun4, [0,time_4],aircraft_state_4);
U4 = zeros(4,length(X4));

for i = 1:length(t4)
    U4(1,i) = doublet_time_adjustor(t4(i), aircraft_surfaces_4(1), doublet_size, doublet_time);
end

if prob_3
    PlotAircraftSim(t4, X4, U4, [19,20,21,22,23,24], 'b')
end