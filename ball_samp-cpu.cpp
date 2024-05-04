#include <iostream>
#include <vector>
#include <random>
#include <cmath>

using namespace std;

int main(){
    const int D = 16;
    const int samples = 2000000;
    const int bins = 100; //0.01, 0.02 --> 0.98, 0.99
    //use random generator for points
    random_device rd;
    mt19937 gen(rd());
    uniform_real_distribution<> dis(-1, 1);

    vector<double> histogram(bins, 0);

    for(int d = 2; d <= D; ++d){
        fill(histogram.begin(), histogram.end(), 0); //fill with 0s
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
                histogram[bin]++; //populate bin within that range, not cumulative
            }
        }
        cout << "Dimension " << d << ":" << endl;
        for(auto& h : histogram){
            cout << h / count << " ";
        }
        cout << endl;
    
    }
    return 0;
}