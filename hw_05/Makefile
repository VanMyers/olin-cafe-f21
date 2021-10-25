# -Wall turns on all warnings
# -g2012 selects the 2012 version of iVerilog
IVERILOG=iverilog -Wall -g2012 -y ./ -I ./
VVP=vvp
VIVADO=vivado -mode batch -source

.PHONY: submission clean

test_slt: test_slt.sv slt.sv addern.sv adder_1.sv
	${IVERILOG} $^ -o test_slt.bin && ${VVP} test_slt.bin


# Call this to generate your submission zip file.
submission:
	zip submission.zip Makefile *.sv README.md diagram.png

# Remove generated files
clean:
	rm -f *.bin *.vcd