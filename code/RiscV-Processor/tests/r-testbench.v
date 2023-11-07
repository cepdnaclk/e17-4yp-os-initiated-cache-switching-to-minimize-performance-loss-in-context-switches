`timescale 1ns/100ps

`include "../cpu/cpu.v"

module cpuTestbench; 

    reg CLK, RESET;

    integer k;

    wire [31:0] reg0_output,reg1_output,reg2_output,reg3_output,reg4_output,reg5_output,reg6_output,reg8_output, reg14_output, reg15_output, pc,debug_ins;
    cpu mycpu(CLK,RESET,reg0_output,reg1_output,reg2_output,reg3_output,reg4_output,reg5_output,reg6_output,reg8_output, reg14_output, reg15_output,pc,debug_ins);

    always
        #5 CLK = ~CLK;

    // initial 
    // begin
    //     $dumpfile("cpuwave_memory.vcd");
    //     $dumpvars(0, mycpu);
    //     for (k = 0; k < 32; k = k + 1)
    //         $dumpvars(1, mycpu.mem_access_unit.myCache_controller.my_data_memory.memory_array[k]);
    // end

    initial
    begin
    
        // generate files needed to plot the waveform using GTKWave
        $dumpfile("cpuwave.vcd");
		$dumpvars(0, cpuTestbench);
		
        // for (k = 0; k < 32; k = k + 1)
        //     $dumpvars(1, mycpu.mem_access_unit.myCache_controller.my_data_memory.memory_array[k]);
    
        
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