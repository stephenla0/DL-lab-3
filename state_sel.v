module state_sel(
    output reg [2:0] current_state
    input [1:0] KEY,
    input [9] SW,
    input [1:0] SW,
    input [23:0] clock_led
);

reg [2:0] state_idle = 3'b000;
reg [2:0] state_hazard = 3'b111;
reg [2:0] state_blinkl = 3'b100;
reg [2:0] state_blinkr = 3'b001;
reg [2:0] state_blinkertog =3'b000;
reg [2:0] next_state = 3'b000;
reg reset_n = 0;

always @ (posedge clock_led)
begin
    if (KEY[0]==0)
        reset_n<=!reset_n;
    if (reset_n==0)
        current_state<=state_idle;
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
