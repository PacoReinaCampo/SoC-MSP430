all: hardware-mpsoc2d software-mpsoc2d

hardware-tile:
	verilator -f soc.vc --trace -Wno-fatal -Wno-lint -Wno-UNOPTFLAT -Wno-COMBDLY -CFLAGS "-std=c++11" -LDFLAGS "-pthread"
	make -f Vsoc_msp430_tile_testbench.mk

hardware-mpsoc2d:
	verilator -f mpsoc2d.vc --trace -Wno-fatal -Wno-lint -Wno-UNOPTFLAT -Wno-COMBDLY -CFLAGS "-std=c++11" -LDFLAGS "-pthread"
	make -f Vsoc_msp430_mpsoc2d_testbench.mk

hardware-mpsoc3d:
	verilator -f mpsoc3d.vc --trace -Wno-fatal -Wno-lint -Wno-UNOPTFLAT -Wno-COMBDLY -CFLAGS "-std=c++11" -LDFLAGS "-pthread"
	make -f Vsoc_msp430_mpsoc3d_testbench.mk

hardware-mpsoc4d:
	verilator -f mpsoc4d.vc --trace -Wno-fatal -Wno-lint -Wno-UNOPTFLAT -Wno-COMBDLY -CFLAGS "-std=c++11" -LDFLAGS "-pthread"
	make -f Vsoc_msp430_mpsoc4d_testbench.mk

software-tile:
	./Vsoc_msp430_tile_testbench --meminit=../../../../software/baremetal/heat_mpsimple/c/heat_mpsimple.vmem
	./Vsoc_msp430_tile_testbench --meminit=../../../../software/baremetal/hello/c/hello.vmem
	./Vsoc_msp430_tile_testbench --meminit=../../../../software/baremetal/hello_mp/c/hello_mp.vmem
	./Vsoc_msp430_tile_testbench --meminit=../../../../software/baremetal/hello_mpsimple/c/hello_mpsimple.vmem

software-mpsoc2d:
	./Vsoc_msp430_mpsoc2d_testbench --meminit=../../../../software/baremetal/hello/c/hello.vmem
	./Vsoc_msp430_mpsoc2d_testbench --meminit=../../../../software/baremetal/hello_mp/c/hello_mp.vmem
	./Vsoc_msp430_mpsoc2d_testbench --meminit=../../../../software/baremetal/hello_mpsimple/c/hello_mpsimple.vmem

software-mpsoc3d:
	./Vsoc_msp430_mpsoc3d_testbench --meminit=../../../../software/baremetal/hello/c/hello.vmem
	./Vsoc_msp430_mpsoc3d_testbench --meminit=../../../../software/baremetal/hello_mp/c/hello_mp.vmem
	./Vsoc_msp430_mpsoc3d_testbench --meminit=../../../../software/baremetal/hello_mpsimple/c/hello_mpsimple.vmem

software-mpsoc4d:
	./Vsoc_msp430_mpsoc4d_testbench --meminit=../../../../software/baremetal/hello/c/hello.vmem
	./Vsoc_msp430_mpsoc4d_testbench --meminit=../../../../software/baremetal/hello_mp/c/hello_mp.vmem
	./Vsoc_msp430_mpsoc4d_testbench --meminit=../../../../software/baremetal/hello_mpsimple/c/hello_mpsimple.vmem

clear:
	rm -rf *.a *.cpp *.d *.dat *.h *.o *.mk

clean:
	rm -rf *.a *.cpp *.d *.dat *.h *.o *.mk Vsoc_msp430_* stdout.*
