module state_sel(
    output reg [2:0] current_state,
    input [1:0] KEY,
    input [9:0] SW,
    inout clock_led,
    output [7:0] HEX5,
    output [9:0] LEDR
);

reg [2:0] state_idle = 3'b000;
reg [2:0] state_reset = 0;
reg [2:0] state_hazard = 3'b001;
reg [2:0] state_blinkl = 3'b010;
reg [2:0] state_blinkr = 3'b011;
reg [2:0] state_blinkertog = 3'b000;
reg [2:0] next_state = 3'b000;
reg reset_n = 0;
reg enable=1;
wire [2:0] memout;
reg [9:0] count;
reg start=1;

always @ (posedge clock_led)
begin
	//current_state = 3'b000;
    if (SW[9]==0)
    begin
        enable<=1;
        start<=1;
    end
    else if (SW[9]==1)
    begin
        enable<=0;
        if(start==1)
        begin
        current_state<=state_idle;
        start<=0;
        end
    end
	if(enable==1) //used to be while
	begin
		if (KEY[0]==0) //check reset
			reset_n<=0;
		else
			reset_n<=1;
		if (reset_n==0) //reset commands
		begin
			current_state<=state_idle;
			state_reset<=1;
		end
		else if (reset_n==1) //no reset
		begin
			state_reset<=0;

			if (KEY[1]==0) //blink left 
				state_blinkertog<=state_blinkl;
			else if (KEY[1]==1) //blink right
				state_blinkertog<=state_blinkr;

			if (SW[0]==1) //check hazard switch
				next_state<=state_hazard;
			else if (SW[1]==1) //check blinker switch
				next_state<=state_blinkertog;
			else //no switches active = idle
				next_state<=state_idle;

			current_state<=next_state; //move to next state
		end
	end
    if(enable==0)
    begin
        if(count==25) //10 hz clock, for 5 seconds
        begin
            if(current_state!=3'b011)
            begin
                current_state<=current_state+1;
                count<=0;
            end
            else
            begin
                current_state<=3'b000;
                count<=0;
            end
        end
    else
    count<=count+1;
    end
end

/*while (enable==0)
begin

end*/

state_exe U0 (clock_led, current_state, LEDR);
sevenseg U1 (current_state, state_reset, HEX5);
mem U2 (current_state, clock_led, memout);

endmodule