all: ball_samp-cpu

ball_samp-cpu: ball_samp-cpu.o
	g++ -Wall -Wextra -pedantic ball_samp-cpu.o -o ball_samp-cpu
	
ball_samp-cpu.o: ball_samp-cpu.cpp
	g++ -Wall -Wextra -pedantic -c ball_samp-cpu.cpp

clean: 
	rm -f *.o ball_samp-cpu

#running cuda
#module load cuda/12.0
#nvcc -arch=sm_70 -o ball_samp-cuda ball_samp-cuda.cu
#srun --partition=gpu --pty bash
#./ball_samp-cuda
#exit