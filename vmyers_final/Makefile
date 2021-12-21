# -Wall turns on all warnings
# -g2012 selects the 2012 version of iVerilog
IVERILOG=iverilog -Wall -g2012 -y ./ -I ./
VVP=vvp
VIVADO=vivado -mode batch -source

.PHONY: submission clean

DSMODULES=register.sv triangle_generator.sv

test_delta_sigma: test_delta_sigma.sv delta_sigma.sv $(DSMODULES)
	${IVERILOG} $^ -o test_delta_sigma.bin && ${VVP} test_delta_sigma.bin

test_triangle_generator: test_triangle_generator.sv triangle_generator.sv register.sv
	${IVERILOG} $^ -o test_triangle_generator.bin && ${VVP} test_triangle_generator.bin ${VVP_POST}


# Call this to generate your submission zip file.
submission:
	zip submission.zip Makefile *.sv README.md

# Remove generated files
clean:
	rm -f *.bin *.vcd