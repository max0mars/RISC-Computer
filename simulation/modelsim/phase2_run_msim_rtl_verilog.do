transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/20mbm14/Desktop/RISC-Computer/ALU_Operations {C:/Users/20mbm14/Desktop/RISC-Computer/ALU_Operations/subtract_bits.v}
vlog -vlog01compat -work work +incdir+C:/Users/20mbm14/Desktop/RISC-Computer/ALU_Operations {C:/Users/20mbm14/Desktop/RISC-Computer/ALU_Operations/rotate_right_bits.v}
vlog -vlog01compat -work work +incdir+C:/Users/20mbm14/Desktop/RISC-Computer/ALU_Operations {C:/Users/20mbm14/Desktop/RISC-Computer/ALU_Operations/rotate_left_bits.v}
vlog -vlog01compat -work work +incdir+C:/Users/20mbm14/Desktop/RISC-Computer/ALU_Operations {C:/Users/20mbm14/Desktop/RISC-Computer/ALU_Operations/or_bits.v}
vlog -vlog01compat -work work +incdir+C:/Users/20mbm14/Desktop/RISC-Computer/ALU_Operations {C:/Users/20mbm14/Desktop/RISC-Computer/ALU_Operations/not_bits.v}
vlog -vlog01compat -work work +incdir+C:/Users/20mbm14/Desktop/RISC-Computer/ALU_Operations {C:/Users/20mbm14/Desktop/RISC-Computer/ALU_Operations/negate_bits.v}
vlog -vlog01compat -work work +incdir+C:/Users/20mbm14/Desktop/RISC-Computer/ALU_Operations {C:/Users/20mbm14/Desktop/RISC-Computer/ALU_Operations/mul_bits.v}
vlog -vlog01compat -work work +incdir+C:/Users/20mbm14/Desktop/RISC-Computer/ALU_Operations {C:/Users/20mbm14/Desktop/RISC-Computer/ALU_Operations/logical_shift_right_bits.v}
vlog -vlog01compat -work work +incdir+C:/Users/20mbm14/Desktop/RISC-Computer/ALU_Operations {C:/Users/20mbm14/Desktop/RISC-Computer/ALU_Operations/logical_shift_left_bits.v}
vlog -vlog01compat -work work +incdir+C:/Users/20mbm14/Desktop/RISC-Computer/ALU_Operations {C:/Users/20mbm14/Desktop/RISC-Computer/ALU_Operations/div_bits.v}
vlog -vlog01compat -work work +incdir+C:/Users/20mbm14/Desktop/RISC-Computer/ALU_Operations {C:/Users/20mbm14/Desktop/RISC-Computer/ALU_Operations/arithmetic_shift_right_bits.v}
vlog -vlog01compat -work work +incdir+C:/Users/20mbm14/Desktop/RISC-Computer/ALU_Operations {C:/Users/20mbm14/Desktop/RISC-Computer/ALU_Operations/Andbits.v}
vlog -vlog01compat -work work +incdir+C:/Users/20mbm14/Desktop/RISC-Computer/ALU_Operations {C:/Users/20mbm14/Desktop/RISC-Computer/ALU_Operations/add_bits.v}
vlog -vlog01compat -work work +incdir+C:/Users/20mbm14/Desktop/RISC-Computer {C:/Users/20mbm14/Desktop/RISC-Computer/Zregister.v}
vlog -vlog01compat -work work +incdir+C:/Users/20mbm14/Desktop/RISC-Computer {C:/Users/20mbm14/Desktop/RISC-Computer/register.v}
vlog -vlog01compat -work work +incdir+C:/Users/20mbm14/Desktop/RISC-Computer {C:/Users/20mbm14/Desktop/RISC-Computer/MDR.v}
vlog -vlog01compat -work work +incdir+C:/Users/20mbm14/Desktop/RISC-Computer {C:/Users/20mbm14/Desktop/RISC-Computer/Encoder32.v}
vlog -vlog01compat -work work +incdir+C:/Users/20mbm14/Desktop/RISC-Computer {C:/Users/20mbm14/Desktop/RISC-Computer/DataPath.v}
vlog -vlog01compat -work work +incdir+C:/Users/20mbm14/Desktop/RISC-Computer {C:/Users/20mbm14/Desktop/RISC-Computer/Bus.v}
vlog -vlog01compat -work work +incdir+C:/Users/20mbm14/Desktop/RISC-Computer {C:/Users/20mbm14/Desktop/RISC-Computer/ALU.v}
vlog -vlog01compat -work work +incdir+C:/Users/20mbm14/Desktop/RISC-Computer {C:/Users/20mbm14/Desktop/RISC-Computer/RAM.v}
vlog -vlog01compat -work work +incdir+C:/Users/20mbm14/Desktop/RISC-Computer {C:/Users/20mbm14/Desktop/RISC-Computer/Inport_Reg.v}
vlog -vlog01compat -work work +incdir+C:/Users/20mbm14/Desktop/RISC-Computer {C:/Users/20mbm14/Desktop/RISC-Computer/select_and_encode.v}
vlog -vlog01compat -work work +incdir+C:/Users/20mbm14/Desktop/RISC-Computer {C:/Users/20mbm14/Desktop/RISC-Computer/r0_Register.v}
vlog -vlog01compat -work work +incdir+C:/Users/20mbm14/Desktop/RISC-Computer {C:/Users/20mbm14/Desktop/RISC-Computer/CON_FF.v}

vlog -vlog01compat -work work +incdir+C:/Users/20mbm14/Desktop/RISC-Computer {C:/Users/20mbm14/Desktop/RISC-Computer/DEMO_ld2.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  DEMO_ld2

add wave *
view structure
view signals
run 500 ns
