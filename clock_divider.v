module clock_divider(input [23:0] clock_source,
                    output reg clock_led);
parameter clock_divider=5_000_000; //clock divider factor
reg[23:0] divide_counter;

always @(posedge clock_source)//divides clock
begin
    if(divide_counter==clock_divider-1)
    begin
    divide_counter<=0;
    clock_bcd<=~clock_bcd;
    end
    else
    divide_counter<=divide_counter+1;
end

endmodule