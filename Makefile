Final:
	ghdl -s --ieee=synopsys $(target).vhd* 
	ghdl -s --ieee=synopsys $(target)_tb.vhd*;
	ghdl -a --ieee=synopsys $(target).vhd*;
	ghdl -a --ieee=synopsys $(target)_tb.vhd*;
	ghdl -e --ieee=synopsys $(target)_tb;
	ghdl -r --ieee=synopsys $(target)_tb --vcd=$(target).vcd --stop-time=400us --max-stack-alloc=512;
	gtkwave $(target).vcd;