module top(
    output [7:0] HEX5,
    output [9:0] LEDR,
    input [1:0] KEY,
    input [9] SW,
    input [1:0] SW,
    output [23:0] clock_source,
    inout clock_led,
    input ADC_CLK_10,
);
assign clock_source[23:0]=ADC_CLK_10;

