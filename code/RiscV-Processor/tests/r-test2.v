`timescale 1ns/100ps

`include "../cpu/cpu.v"
`include "../supportive_modules/supportive_modules/clock_cycle_counter.v"

module cpuTestbench02; 

    reg CLK, RESET;
    //reg [31:0] TRIGGER;

    wire [31:0] reg0_output, reg1_output, reg2_output, reg3_output, reg4_output, reg5_output, reg6_output, pc, debug_ins, COUNTER;
    cpu mycpu(CLK,RESET,reg0_output,reg1_output,reg2_output,reg3_output,reg4_output,reg5_output,reg6_output,pc,debug_ins);
    //ClockCycleCounter myClock(CLK,RESET,reg6_output,COUNTER);

    always
        #5 CLK = ~CLK;

    initial
    begin
    
        // generate files needed to plot the waveform using GTKWave
        $dumpfile("cpuwave2.vcd");
		$dumpvars(0, cpuTestbench02);
		
        
        CLK = 1'b0;
        RESET = 1'b0;
        
        // TODO: Reset the CPU (by giving a pulse to RESET signal) to start the program execution
		// RESET = 1'b1;
		#2
		RESET = 1'b1;
		#4
		RESET = 1'b0;
		// #4
		// RESET = 1'b0;
        
        // finish simulation after some time
        #6000
        $finish;
        
    end
        

endmodule