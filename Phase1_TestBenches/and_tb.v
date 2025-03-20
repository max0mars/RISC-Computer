`timescale 1ns/10ps

// Testbench module
module and_bits_tb();

    // Control signals
    reg clock, clear;
    reg [3:0] present_state;

    // Inputs and Outputs
    reg [31:0] RA, RB;         // Inputs
    reg [31:0] RZ;      // Output

    // Instantiate the AND module
    and_bits uut (
        RA,
		  RB,
		  RZ
    );

    // Define states
    parameter init = 4'd0, T0 = 4'd1, T1 = 4'd2, T2 = 4'd3, T3 = 4'd4;

    // Initialize clock and state
    initial begin
        clock = 0;
        present_state = init;
    end

    // Generate clock signal
    always #10 clock = ~clock;

    // State transitions on negative clock edge
    always @ (negedge clock)
        present_state = present_state + 1;



// State-based behavior
    always @(present_state) begin
        case (present_state)
            init: begin
                clear <= 1;
                RA <= 0; RB <= 0; // Reset Inputs
                #15 clear <= 0;
            end
            T0: begin
                RA <= 32'hFFFFFFFF; RB <= 32'h00000000; // AND two values
            end
            T1: begin
                RA <= 32'h12345678; RB <= 32'h87654321; // Random test case
            end
            T2: begin
                RA <= 32'hF0F0F0F0; RB <= 32'h0F0F0F0F; // Patterned bits
            end
            T3: begin
				
				//uh
            end
        endcase
    end

endmodule

//// Define states
//    parameter init = 4'd0, T0 = 4'd1, T1 = 4'd2;
//
//    // Initialize clock and state
//    initial begin
//        clock = 0;
//        present_state = init;
//    end
//
//    // Generate clock signal
//    always #10 clock = ~clock;
//
//    // State transitions on negative clock edge
//    always @ (negedge clock)
//        present_state = present_state + 1;
//
//    // State-based behavior (only one AND operation)
//    always @(present_state) begin
//        case (present_state)
//            init: begin
//                clear <= 1;
//                RA <= 0; RB <= 0; // Reset Inputs
//                #15 clear <= 0;
//            end
//            T0: begin
//                RA <= 32'hFFFFFFFF; // All 1s
//                RB <= 32'h00000000; // All 0s
//                // Expected RZ = 0x00000000
//            end
//            T1: begin
//                $finish; // End simulation
//            end
//        endcase
//    end
//
//endmodule
