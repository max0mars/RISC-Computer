module CON_FF (            
    input wire CONin,             // enable signal for condition evaluation
    input wire [31:0] busIn,      
    input wire [1:0] IR_bits,     // condition field from (IR<22..19>)
    output reg CON_out            // condition flag output (to control unit)
);

// conditional branch intsructions = brzr , brnz, brmi, brpl 
	initial CON_out = 0;
    //  condition eval
    wire isZero;      // busIn = zero
    wire isNotZero;   // busIn = non-zero
    wire isPositive;  // busIn = positive
    wire isNegative;  // busIn = negative

    assign isZero      = (busIn == 32'b0);
    assign isNotZero   = ~isZero;
    assign isPositive  = (busIn[31] == 1'b0);  // MSB 0 = non-negative
    assign isNegative  = (busIn[31] == 1'b1);  // MSB 1 =negative

    // 2-to-4 decoder to determine branch condition
    reg [3:0] decoderOut;

	 wire branchFlag;
    assign branchFlag = (decoderOut[0] & isZero) |
                      (decoderOut[1] & isNotZero) |
                      (decoderOut[2] & isPositive) |
                      (decoderOut[3] & isNegative);
	 
    always @(*) begin
        case (IR_bits)
            2'b00: decoderOut = 4'b0001;  // Branch if Zero
            2'b01: decoderOut = 4'b0010;  // Branch if Not Zero
            2'b10: decoderOut = 4'b0100;  // Branch if Positive
            2'b11: decoderOut = 4'b1000;  // Branch if Negative
            default: decoderOut = 4'b0000; // Should not happen
        endcase
		  if (CONin) CON_out <= branchFlag;
		  //else CON_out <= 1'b0;
    end

    // calculating final condition flag
	 


endmodule