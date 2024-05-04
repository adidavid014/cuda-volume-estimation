all: ball_samp_cpu

ball_samp_cpu: ball_samp_cpu.o
	g++ -Wall -Wextra -pedantic ball_samp_cpu.o -o ball_samp_cpu
	
ball_samp_cpu.o: ball_samp_cpu.cpp
	g++ -Wall -Wextra -pedantic -c ball_samp_cpu.cpp

clean: 
	rm -f *.o ball_samp_cpu

#nvcc -o ball_samp-cuda ball_samp_cuda.cu -lcurand