module clock_divider(
	input clock_source,
    output reg clock_led
);

parameter clock_divider=1_000_000; //clock divider factor 10 hz clock
reg[23:0] divide_counter;

always @(posedge clock_source)//divides clock
begin
    if(divide_counter==clock_divider-1)
    begin
    divide_counter<=0;
    clock_led<=~clock_led;
    end
    else
    divide_counter<=divide_counter+1;
end

endmodule