#include <iostream>
#include <vector>
#include <random>
#include <cmath>

using namespace std;

int main(){
    const int D = 16;
    const int samples = 1000000;
    const int bins = 100; //0.01, 0.02 --> 0.98, 0.99
    //use random generator for points
    random_device rd;
    mt19937 gen(rd());
    uniform_real_distribution<> dis(-1, 1);

    vector<double> histogram(bins, 0);

    for(int d = 2; d <= D; ++d){
        fill(histogram.begin(), histogram.end(), 0); //fill with 0s
        int count = 0;
    }

}