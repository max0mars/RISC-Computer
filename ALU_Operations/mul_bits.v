module mul_bits (

    input signed [31:0] RA, RB,  // ra = multiplicand, rb = multiplier
    output reg [63:0] RZ          // product (64 bits) 
	 
	 
);

    // booth encoding w bit pairs :
	 
	 // 00 -> 0 do nothign,  // 001 , 010 ->  + Multiplicand
	 // 01 -> + Multiplicand, // 011 -> + 2 * Multiplicand
	 // 10 -> - multiplicand, // 100 -> - 2 * multiplicand
	 // 11 -> 0 no operation  // 101, 110 -> - multiplicand
	 
	 reg [2:0] encoding[(32 / 2) - 1:0];   // bit pair  codes
	 
    reg [32:0] pp[(32 / 2) - 1:0];  // partial product
    reg [63:0] signed_val[(32 / 2) - 1:0]; 
   
    reg [63:0] product; // product (64 bits for max) 
	 
    integer i, j;

    wire [32:0] neg_RA; // neg ra with sign extension 
    
	 assign neg_RA = { ~RA[31], ~RA} + 1;// flip sign bit (negating ra) and add one for 2's complement, for when need to sub  

    
	//booth encoding for RB
	 always @ (RA or RB or neg_RA) begin
	 
        
        encoding[0] = {RB[1], RB[0], 1'b0}; // first - look at first 2 bits in rb plus 0 
        // loop to fill rest of array (3 bits)
		  for (j = 1; j < 16; j = j+1) 
            encoding[j] = {RB[2*j+1], RB[2*j], RB[2*j-1]};
       
        //make partial products for each section 
        for (j = 0; j < 16; j = j+1) begin
            
				case(encoding[j])
               
					3'b001, 3'b010: pp[j] = {RA[31], RA};      // add rA
                3'b011:         pp[j] = {RA, 1'b0};       //add 2*rA
                3'b100:         pp[j] = {neg_RA[31:0], 1'b0}; // - 2*rA
                3'b101, 3'b110: pp[j] = neg_RA;           // - rA
                
					 default:        pp[j] = 0; // nothing for 000 or 111
            endcase
            
				signed_val[j] = $signed(pp[j]); // convert pp to a signed value 

            // shiftign partial products 
            for (i = 0; i < j; i = i + 1)
				
                signed_val[j] = signed_val[j] << 2; //each has to shuft pp by 2 bits
        end

        //add partial products together
        product = signed_val[0];
        for (j = 1; j < 16; j = j+1)
		  
            product = product + signed_val[j];

     //pass to rz to output
        RZ = product;
    end

endmodule