module state_sel(
    output reg [2:0] current_state,
    input [1:0] KEY,
    input [9:0] SW,
    inout [23:0] clock_led,
    output [7:0] HEX5,
    output [9:0] LEDR
);

reg [2:0] state_idle = 3'b000;
reg [2:0] state_reset = 0;
reg [2:0] state_hazard = 3'b111;
reg [2:0] state_blinkl = 3'b100;
reg [2:0] state_blinkr = 3'b001;
reg [2:0] state_blinkertog = 3'b000;
reg [2:0] next_state = 3'b000;
reg reset_n = 0;
reg enable=1;
current_state=state_idle;

always @ (posedge clock_led)
begin
    if (SW[9]==0)
        enable<=1;
    else if (SW[9]==1)
        enable<=0;
end

while(enable==1)
begin
always @ (posedge clock_led)
begin
    if (KEY[0]==0)
        reset_n<=!reset_n;
    if (reset_n==0)
    begin
        current_state<=state_idle;
        state_reset<=1;
    end
    else if (reset_n==1)
        state_reset<=0;
    if (KEY[1]==0)
        state_blinkertog<=state_blinkl;
    else if (KEY[1]==1)
        state_blinkertog<=state_blinkr;
    else
        current_state<=next_state;
end

always @ (posedge clock_led)
begin
    if (SW[0]==1)
        next_state<=state_hazard;
    else if (SW[1]==1)
        next_state<=state_blinkertog;
end
end

while (enable==0)
begin

end

state_exe U0 (clock_led, current_state, LEDR);
sevenseg U1 (current_state, reset, HEX5);

endmodule