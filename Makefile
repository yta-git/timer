###
### Makefile
###

ALL: axusb.rbf

synplify/axusb.vqm: hdl/axusb.sv
	env LM_LICENSE_FILE=1700@vdec-cad1:1700@vdec-cad2:1700@vdec-cad3 /home/share/Synopsys/fpga/fpga_962/bin/synplify_pro -batch script/synplify.prj

synplify/axusb.rbf: synplify/axusb.vqm
	cd synplify; /home/share/Altera/9.0/quartus/bin/quartus_cmd -f ../script/quartus.tcl; cd ..

axusb.rbf: synplify/axusb.rbf
	mv synplify/axusb.rbf .

clean:
	rm -rf synplify stdout.log axusb.rbf
