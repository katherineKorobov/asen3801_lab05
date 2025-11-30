function elevator_cmd = doublet_time_adjustor(time, elevator_trim,doublet_size,doublet_time)

%doublet_size = 15 * pi/180; %Rads
%doublet_time = 0.25; %seconds

    if time <= doublet_time
        elevator_cmd = elevator_trim + doublet_size;
    
    elseif time > doublet_time && time <= 2*doublet_time
        elevator_cmd = elevator_trim - doublet_size;
    
    elseif time > 2*doublet_time
        elevator_cmd = elevator_trim;
    end

end