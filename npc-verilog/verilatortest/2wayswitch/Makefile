build:
	verilator --cc --exe --build -j 0 -Wall sim_main.cpp top.v

run:
	obj_dir/Vtop

clear:
	rm -r obj_dir

.PHONY: build run clear
