module state_sel(
    output[2:0] state_select
    input [1:0] KEY,
    input [9] SW,
    input [1:0] SW
);

reg [3:0] state_idle= 3'b000;
reg [3:0] state_hazard = 3'b111;
reg [3:0] state_blinkl = 3'b100;
reg [3:0] state_blinkr = 3'b001;