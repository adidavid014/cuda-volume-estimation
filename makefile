all: ball_samp-cpu

ball_samp-cpu: ball_samp-cpu.o
	g++ -Wall -Wextra -pedantic ball_samp-cpu.o -o ball_samp-cpu
	
ball_samp-cpu.o: ball_samp-cpu.cpp
	g++ -Wall -Wextra -pedantic -c ball_samp-cpu.cpp

clean: 
	rm -f *.o ball_samp-cpu

#running cuda
#nvcc -arch=sm_70 -o test test.cu
#srun --partition=gpu --pty bash
#module load cudo/12.0
#./test
#exit