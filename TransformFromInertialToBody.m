function wind_body = TransformFromInertialToBody(wind_inertial, euler_angles)
%Idk why this wasnt provided since its used insite the AeroForcesAndMoments
%function

    phi   = euler_angles(1);
    theta = euler_angles(2);
    psi   = euler_angles(3);

    % Body to inertial
    C_EB = [cos(theta)*cos(psi),                             cos(theta)*sin(psi),                           -sin(theta);
        sin(phi)*sin(theta)*cos(psi)-cos(phi)*sin(psi),  sin(phi)*sin(theta)*sin(psi)+cos(phi)*cos(psi), sin(phi)*cos(theta);
        cos(phi)*sin(theta)*cos(psi)+sin(phi)*sin(psi),  cos(phi)*sin(theta)*sin(psi)-sin(phi)*cos(psi), cos(phi)*cos(theta) ];

    % Inertial to Body
    C_BE = C_EB.'; 

    wind_body = C_BE * wind_inertial;
end