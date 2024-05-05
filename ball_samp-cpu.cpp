#include <iostream>
#include <vector>
#include <random>
#include <cmath>
#include <fstream>

using namespace std;

int main(){
    const int D = 16;
    const int samples = 2000000;
    const int bins = 100;
    random_device rd;
    mt19937 gen(rd());
    uniform_real_distribution<> dis(-1, 1);

    vector<double> histogram(bins, 0);
    //using matplot to display data
    ofstream outFile("histogram_data.txt");

    for(int d = 2; d <= D; ++d){
        fill(histogram.begin(), histogram.end(), 0);
        int count = 0;
        for(int i = 0; i < samples; ++i){
            double sum = 0;
            vector<double> point(d);
            for(int j = 0; j < d; ++j){
                point[j] = dis(gen);
                sum += point[j] * point[j];
            }
            if(sum <= 1){
                count++;
                double distance = 1-sqrt(sum);
                int bin = min(static_cast<int>(distance * bins), bins - 1);
                histogram[bin]++;
            }
        }
        outFile << d;
        for(auto h : histogram){
            outFile << " " << h / count;
        }
        outFile << endl;
    }
    outFile.close();
    return 0;
}
