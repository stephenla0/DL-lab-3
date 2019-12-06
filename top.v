module top(
    output [7:0] HEX5,
    output [7:0] HEX4,
    output [7:0] HEX3,
    output [7:0] HEX2,
    output [7:0] HEX1,
    output [7:0] HEX0,
    output [9:0] LEDR,
    input [1:0] KEY,
    input [9] SW,
    input [1:0] SW,
    output [23:0] clock_source,
    inout clock_led,
);

