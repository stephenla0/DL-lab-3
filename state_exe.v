module state_exe(
    input clock_led,
    input[2:0] state_select,
    output reg [9:0] LEDR
);
reg [1:0] counter = 2'b00;
reg hazardToggle = 1'b0;

always@(posedge clock_led)
begin
    if(counter == 2'b11)
        counter <= 2'b0;
    else
        counter <= counter+1;	

    if(state_select == 3'b001) //Hazard
    begin
        hazardToggle = ~hazardToggle;
        LEDR[9] = hazardToggle;
		LEDR[8] = hazardToggle;
		LEDR[7] = hazardToggle;
		LEDR[2] = hazardToggle;
		LEDR[1] = hazardToggle;
		LEDR[0] = hazardToggle;
    end
    else if(state_select == 3'b000) //Idle
    begin
        counter <= 2'b00;
        LEDR[9:0] = 10'b0000000000;
    end
    else if(state_select == 3'b010) //Left
    begin
		LEDR[2] = 0;
        LEDR[1] = 0;
        LEDR[0] = 0;

	    if(counter == 2'b01) //Inner light
		begin			
            LEDR[7] = 1;
			LEDR[8] = 0;
			LEDR[9] = 0;
		end
        if(counter == 2'b10) //Middle light
		begin
            LEDR[7] = 1;
			LEDR[8] = 1;
			LEDR[9] = 0;
		end
        if(counter == 2'b11) //Outer light
		begin
            LEDR[7] = 1;
			LEDR[8] = 1;
			LEDR[9] = 1;
		end
        if(counter == 2'b00) //All lights off
        begin
			LEDR[7] = 0;
            LEDR[8] = 0;
            LEDR[9] = 0;
        end
    end
    else if(state_select == 3'b011) //Right
    begin
		LEDR[7] = 0;
        LEDR[8] = 0;
        LEDR[9] = 0;

		if(counter == 2'b01) //Inner light
		begin
            LEDR[2] = 1;
			LEDR[1] = 0;
			LEDR[0] = 0;
		end
        if(counter == 2'b10) //Middle light
		begin
            LEDR[2] = 1;
			LEDR[1] = 1;
			LEDR[0] = 0;
		end
        if(counter == 2'b11) //Outer light
		begin
            LEDR[2] = 1;
			LEDR[1] = 1;
			LEDR[0] = 1;
		end
        if(counter == 2'b00) //All lights off
        begin
            LEDR[2] = 0;
            LEDR[1] = 0;
            LEDR[0] = 0;
        end
    end   
end

endmodule