#include <iostream>
#include <vector>
#include <fstream>
#include <curand_kernel.h>
#include <cmath>

using namespace std;

__global__ void computeHistogram(int d, int samples, int bins, double *histogram, int *count){
    int idx = threadIdx.x + blockIdx.x * blockDim.x;
    if(idx < samples){
        curandState state;
        curand_init(1234, idx, 0, &state);

        double sum = 0;
        for(int j = 0; j < d; ++j){
            double value = curand_uniform_double(&state) * 2 - 1;
            sum += value * value;
        }
        if(sum <= 1){
            atomicAdd(count, 1);
            double distance = 1-sqrt(sum);
            int bin = min(static_cast<int>(distance * bins), bins-1);
            atomicAdd(&histogram[bin], 1.0);
        }
    }
}

int main() {
    const int D = 16;
    const int samples = 2000000;
    const int bins = 100;
    vector<double> histogramHost(bins, 0);
    double *histogramDevice;
    cudaMalloc(&histogramDevice, bins * sizeof(double));
    int countHost = 0;
    int *countDevice;
    cudaMalloc(&countDevice, sizeof(int));
    const int blockSize = 256;
    const int numBlocks = (samples+blockSize-1)/blockSize;

    //adding matplot output
    ofstream outFile("histogram_data.txt");

    for(int d = 2; d <= D; ++d){
        cudaMemset(histogramDevice, 0, bins * sizeof(double));
        cudaMemset(countDevice, 0, sizeof(int));
        computeHistogram<<<numBlocks, blockSize>>>(d, samples, bins, histogramDevice, countDevice);
        cudaDeviceSynchronize();

        //finding driver error 
        cudaError_t error = cudaGetLastError();
        if (error != cudaSuccess) {
            cout << "CUDA error: " << cudaGetErrorString(error) << endl;
            break;
        }
        cudaMemcpy(&countHost, countDevice, sizeof(int), cudaMemcpyDeviceToHost);
        cudaMemcpy(histogramHost.data(), histogramDevice, bins * sizeof(double), cudaMemcpyDeviceToHost);

        if(countHost > 0){
            outFile << d;
            for (auto h : histogramHost) {
                outFile << " " << h / countHost;
            }
            outFile << endl;
        }
    }
    outFile.close();
    cudaFree(histogramDevice);
    cudaFree(countDevice);
    return 0;
}