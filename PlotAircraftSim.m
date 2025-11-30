% Contributors: Christopher Westerlund, Teddy Klein, Katherine Korobov
% Course number: ASEN 3801
% File name: PlotAircraftSim.m
% Purpose: File containing PlotAircraftSim.m.

function PlotAircraftSim(time, aircraft_state_array, control_input_array, fig, col)
%{
    Inputs:
        aircraft_state_array - 12xn array of aircraft states
        control_input_array - 4xn array of control inputs
        fig - numbers for figures, 6x1 array of figure #s
        col - colour for plotting, ex 'b-'
    Outputs:
        Figure 1 - Plot of Inertial Position over time (x,y,z)
        Figure 2 - Plot of Euler Angles over time (phi,theta,psi)
        Figure 3 - Plot of Inertial Velocity in Body Frame over time (u,v,w)
        Figure 4 - Plot of Angular Velocity over time (p,q,r)
        Figure 5 - Plot of Controls over time
        Figure 6 - 3D plot of inertial path over time (green --> red over time)
%}

    %% 6 Plots, 4 with 3 subplots, 1 with subplot of 4 control forces, 1
    aircraft_state_array = aircraft_state_array';

    %% Figure 1, Inertial Position
    figure(fig(1));
    % X Inertial Position
    subplot(3,1,1);
    plot(time, aircraft_state_array(1,:),col, LineWidth=1.2)
	hold on
    xlabel("Time [s]", FontSize=14);
    ylabel("X Position [m]", FontSize=14);
    title("X Inertial Position vs Time", FontSize=18);

    % Y Inertial Position
    subplot(3,1,2);
    plot(time, aircraft_state_array(2,:), col, LineWidth=1.2)
	hold on
    xlabel("Time [s]",FontSize=14);
    ylabel("Y Position [m]",FontSize=14);
    title("Y Inertial Position vs Time",FontSize=18);

    % Z Inertial Position
    ax3 = subplot(3,1,3);
    plot(time, aircraft_state_array(3,:), col, LineWidth=1.2)
	hold on
    xlabel("Time [s]",FontSize=14);
    ylabel("Z Position [m]",FontSize=14);
    title("Z Inertial Position vs Time",FontSize=18);
    
    sgtitle("Inertial Positions vs Time",FontSize=18);
	set(ax3,'YDir','reverse');

    %% Figure 2, Euler Angles
    figure(fig(2));
    % Euler Angle 1, Phi, Roll
    subplot(3,1,1);
    plot(time, aircraft_state_array(4,:), col, LineWidth=1.2)
	hold on
    xlabel("Time [s]",FontSize=14);
    ylabel("Phi Angle [rad]",FontSize=14);
    title("Phi Angle vs Time",FontSize=18);

    % Euler Angle 2, Theta, Pitch
    subplot(3,1,2);
    plot(time, aircraft_state_array(5,:), col, LineWidth=1.2)
	hold on
    xlabel("Time [s]",FontSize=14);
    ylabel("Theta Angle [rad]",FontSize=14);
    title("Theta Angle vs Time",FontSize=18);

    % Euler Angle 3, Psi, Yaw
    subplot(3,1,3);
    plot(time, aircraft_state_array(6,:), col, LineWidth=1.2)
	hold on
    xlabel("Time [s]",FontSize=14);
    ylabel("Psi Angle [rad]",FontSize=14);
    title("Psi Angle vs Time",FontSize=18);

    sgtitle("Euler Angles vs Time",FontSize=18);

    %% Figure 3, Inertal Velocity in Body Frame
    figure(fig(3));
    % X Velocity Body Frame
    subplot(3,1,1);
    plot(time, aircraft_state_array(7,:), col, LineWidth=1.2)
	hold on
    xlabel("Time [s]",FontSize=14);
    ylabel({"Velocity (u)"; "Body Frame [m/s]"},FontSize=14);
    title("Velocity (u) in Body Frame vs Time",FontSize=18);

    % Y Velocity Body Frame
    subplot(3,1,2);
    plot(time, aircraft_state_array(8,:), col, LineWidth=1.2)
	hold on
    xlabel("Time [s]",FontSize=14);
    ylabel({"Velocity (v)"; "Body Frame [m/s]"},FontSize=14);
    title("Velocity (v) in Body Frame vs Time",FontSize=18);

    % Z Velocity Body Frame
    subplot(3,1,3);
    plot(time, aircraft_state_array(9,:), col, LineWidth=1.2)
	hold on
    xlabel("Time [s]",FontSize=14);
    ylabel({"Velocity (w)"; "Body Frame [m/s]"}, FontSize=14);
    title("Velocity (w) in Body Frame vs Time", FontSize=18);

    sgtitle("Inertial Velocity in Body Frame vs Time", FontSize=18)

    %% Figure 4, Angular Velocity
    figure(fig(4));
    % P Angular Velocity
    subplot(3,1,1);
    plot(time, aircraft_state_array(10,:), col, LineWidth=1.2)
	hold on
    xlabel("Time [s]",FontSize=14);
    ylabel({"Roll Rate (p)"; "[rad/s]"},FontSize=14);
    title("Roll Rate vs Time",FontSize=18);

    % Q Angular Velocity
    subplot(3,1,2);
    plot(time, aircraft_state_array(11,:), col, LineWidth=1.2)
	hold on
    xlabel("Time [s]",FontSize=14);
    ylabel({"Pitch Rate (q)"; "[rad/s]"},FontSize=14);
    title("Pitch Rate vs Time",FontSize=18);

    % R Angular Velocity
    subplot(3,1,3);
    plot(time, aircraft_state_array(12,:), col, LineWidth=1.2)
	hold on
    xlabel("Time [s]",FontSize=14);
    ylabel({"Yaw Rate (r)"; "[rad/s]"},FontSize=14);
    title("Yaw Rate vs Time",FontSize=18);

    sgtitle( "Angular Velocity vs Time",FontSize=18);

    %% Figure 5, Control Input Variables
    figure(fig(5));
    % elevator deflection [deg]
    subplot(4,1,1);
    plot(time, control_input_array(1,:), col, LineWidth=1.2)
	hold on
    xlabel("Time [s]",FontSize=14);
    ylabel({"Elevator Deflection"; "[deg]"},FontSize=14);
    title("Elevator Deflection vs Time",FontSize=18);

    % aileron deflection [deg]
    subplot(4,1,2);
    plot(time, control_input_array(2,:), col, LineWidth=1.2)
	hold on
    xlabel("Time [s]",FontSize=14);
    ylabel({"Aileron Deflection"; "[deg]"},FontSize=14);
    title("Aileron Deflection vs Time",FontSize=18);

    % rudder deflection [deg]
    subplot(4,1,3);
    plot(time, control_input_array(3,:), col, LineWidth=1.2)
	hold on
    xlabel("Time [s]",FontSize=14);
    ylabel({"Rudder Deflection"; "[deg]"},FontSize=14);
    title("Rudder Deflection vs Time",FontSize=18);

    % throttle [normalized]
    subplot(4,1,4);
    plot(time, control_input_array(4,:), col, LineWidth=1.2)
	hold on
    xlabel("Time [s]",FontSize=14);
    ylabel({"Throttle Control"; "[non-dim]"},FontSize=14);
    title("Throttle Control vs Time",FontSize=18);

    sgtitle("Control Input Variables vs Time",FontSize=18);

    %% Figure 6, 3D Path
    figure(fig(6));
	grid on
    scatter3(aircraft_state_array(1,:),aircraft_state_array(2,:),aircraft_state_array(3,:),30,time,"filled")
    hold on
    % Create a colormap with 256 colors that goes from green to red.
    m = 256; % Number of Colours
    cMap = interp1([0;1], [0 1 0; 1 0 0], linspace(0,1,m)); % Start Green End Red
    colormap(cMap);
    cMap = colorbar;
    xlabel("X Position (North +) [m]",FontSize=14);
    ylabel("Y Position (East +) [m]",FontSize=14);
    zlabel("Z Position (Up -) [m]",FontSize=14);
    title("3D Visualization of Inertial Position",FontSize=18);
    cMap.Title.String = "Time [s]";
	%zlim([-1800 0])
	set(gca,'YDir','reverse');
	set(gca,'ZDir','reverse');
end