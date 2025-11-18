function xdot = AircraftEOM(time, aircraft_state, aircraft_surfaces, wind_inertial,aircraft_parameters)

%State Vector
x = aircraft_state(1);y = aircraft_state(2);z = aircraft_state(3);
phi = aircraft_state(4); theta = aircraft_state(5); psi = aircraft_state(6);
u = aircraft_state(7); v = aircraft_state(8); w = aircraft_state(9);
p = aircraft_state(10); q = aircraft_state(11); r = aircraft_state(12);

%Aircraft Parameters
m = aircraft_parameters.m;
g = aircraft_parameters.g;
Ix = aircraft_parameters.Ix; %[kg m^2]
Iy = aircraft_parameters.Iy; %[kg m^2]
Iz = aircraft_parameters.Iz; %[kg m^2]
Ixz = aircraft_parameters.Ixz; %[kg m^2]

%Gammas
Gamma = Ix*Iz-Ixz^2;
Gamma1 = Ixz*(Ix-Iy+Iz)/Gamma; Gamma2 = (Iz*(Iz-Iy)+Ixz^2)/Gamma; Gamma3 = Iz/Gamma;
Gamma4 = Ixz/Gamma; Gamma5 = (Iz-Ix)/Iy; Gamma6 = Ixz/Iy; Gamma7 = (Ix*(Ix-Iy)+Ixz^2)/Gamma; Gamma8 = Ix/Gamma;

%Density
[~,~,~,density] = atmosisa(-z); %The function they told us to use doesnt work

%Aero Forces and Moments
[aero_forces, aero_moments] = AeroForcesAndMoments(aircraft_state, aircraft_surfaces, wind_inertial, density, aircraft_parameters);
X = aero_forces(1); Y = aero_forces(2); Z = aero_forces(3);
L = aero_moments(1); M = aero_moments(2); N = aero_moments(3);

%New State Vector
x_dot = (cos(theta)*cos(psi))*u + (sin(phi)*sin(theta)*cos(psi)-cos(phi)*sin(psi))*v + (cos(phi)*sin(theta)*cos(psi)+sin(phi)*sin(psi))*w;
y_dot = (cos(theta)*sin(psi))*u + (sin(phi)*sin(theta)*sin(psi)+cos(phi)*cos(psi))*v + (cos(phi)*sin(theta)*sin(psi)-sin(phi)*cos(psi))*w;
z_dot = -sin(theta)*u + sin(phi)*cos(theta)*v + cos(phi)*cos(theta)*w;

phi_dot = p+sin(phi)*tan(theta)*q + cos(phi)*tan(theta)*r;
theta_dot = cos(phi)*q -sin(phi)*r;
psi_dot = sin(phi)*sec(theta)*q + cos(phi)*sec(theta)*r;

u_dot = (r*v-q*w) - g*sin(theta) + X/m;
v_dot = (p*w-r*u) + g*cos(theta)*sin(phi) + Y/m;
w_dot = (q*u-p*v) + g*cos(theta)*cos(phi) + Z/m;

p_dot = (Gamma1*p*q-Gamma2*q*r) + (Gamma3*L + Gamma4*N);
q_dot = (Gamma5*p*r-Gamma6*(p^2-r^2)) + (M/Iy);
r_dot = (Gamma7*p*q-Gamma1*q*r) + (Gamma4*L+Gamma8*N);

xdot = [x_dot; y_dot; z_dot; phi_dot; theta_dot; psi_dot; u_dot; v_dot; w_dot; p_dot; q_dot; r_dot];