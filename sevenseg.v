module sevenseg(
    input [2:0] state,
    input reset,
    output reg [7:0] display
);

always @ (state)
   begin
      case({state, reset})
         {3'b000, 1'b1}: display = 8'b11_00_00_00; //0
		 {3'b001, 1'b1}: display = 8'b11_00_00_00; //0
		 {3'b010, 1'b1}: display = 8'b11_00_00_00; //0
		 {3'b011, 1'b1}: display = 8'b11_00_00_00; //0
         {3'b000, 1'b0}: display = 8'b11_11_10_01; //1
         {3'b001, 1'b0}: display = 8'b10_10_01_00; //2
         {3'b010, 1'b0}: display = 8'b10_11_00_00; //3
         {3'b011, 1'b0}: display = 8'b10_01_10_01; //4
         default: display = 8'b11_11_11_11; //blank
      endcase
   end
endmodule