#include <algorithm>
#include <iostream>
#include <vector>


void for_each_sample()
{
    std::cout << "====array====" << std::endl;
    std::vector<int> array = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };

    int plus = 10;
    std::for_each(array.begin(),array.end(),[plus] (int& v) mutable {
        v += plus;
    });

    for(auto v : array) {
        std::cout << v << ",";
    }
    std::cout << std::endl;
}

void main()
{
    for_each_sample();
}
