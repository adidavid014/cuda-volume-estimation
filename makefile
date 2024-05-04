all: ball_samp-cpu

ball_samp-cpu: ball_samp-cpu.o
	g++ -Wall -Wextra -pedantic ball_samp-cpu.o -o ball_samp-cpu
	
ball_samp-cpu.o: ball_samp-cpu.cpp
	g++ -Wall -Wextra -pedantic -c ball_samp-cpu.cpp

clean: 
	rm -f *.o ball_samp-cpu

#nvcc -std=c++11 -Xcompiler -Wall test.cu -o test