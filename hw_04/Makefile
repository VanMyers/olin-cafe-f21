# -Wall turns on all warnings
# -g2012 selects the 2012 version of iVerilog
IVERILOG=iverilog -Wall -g2012 -y ./ -I ./
VVP=vvp
VIVADO=vivado -mode batch -source

.PHONY: submission clean

test_mux32: test_mux32.sv mux32.sv
	${IVERILOG} $^ -o test_mux32.bin && ${VVP} test_mux32.bin

test_mux32: test_adder32.sv adder32.sv
	${IVERILOG} $^ -o test_adder32.bin && ${VVP} test_adder32.bin


# Call this to generate your submission zip file.
submission:
	zip submission.zip Makefile *.sv README.md

# Remove generated files
clean:
	rm -f *.bin *.vcd