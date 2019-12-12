module top(
    output [7:0] HEX5,
    output [9:0] LEDR,
    input [1:0] KEY,
    input [9:0] SW,
    inout clock_led,
    input ADC_CLK_10,
    output [2:0] current_state,
    output clock_source
);
assign clock_source=ADC_CLK_10;
clock_divider U0 (clock_source, clock_led);
state_sel U1 (current_state, KEY, SW, clock_led, HEX5, LEDR);

endmodule