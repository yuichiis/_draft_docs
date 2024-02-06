#include <numeric>
#include <iostream>
#include <array>

void iota_sample(void)
{
    std::cout << "==== iota ====" << std::endl;

    // pure c array
    std::cout << "pure c array: ";
    int range[10];
    // Range: Random missile launch codes

    std::iota(std::begin(range), std::end(range), 0);
    // Range: { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 }

    for(const auto&v : range) {
        std::cout << v << ",";
    }
    std::cout << std::endl;

    // std array 
    std::cout << "std::array  : ";
    std::array<int,10> array;

    std::iota(array.begin(), array.end(), 0);

    for(const auto&v : array) {
        std::cout << v << ",";
    }
    std::cout << std::endl;
}

void partial_sum_sample()
{
    std::cout << "==== partial_sum ====" << std::endl;
    int array[10]   = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
    int results[10] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

    std::partial_sum(std::begin(array), std::end(array), std::begin(results));
    // array[0] = sum(array)

    std::cout << "array:   ";
    for(const auto&v : array) {
        std::cout << v << ",";
    }
    std::cout << std::endl;
    std::cout << "results: ";
    for(const auto&v : results) {
        std::cout << v << ",";
    }
    std::cout << std::endl;
}

void accumulate_sample()
{
    std::cout << "====accumulate====" << std::endl;
    std::array<int,4> array = { 1, 2, 3, 4 };
    std::cout << "array:   ";
    for(const auto&v : array) {
        std::cout << v << ",";
    }
    std::cout << std::endl;

    int sum = std::accumulate(array.begin(), array.end(), 0);
    std::cout << "sum: " << sum << std::endl;

    // multiplies in <functional> header
    int mul = std::accumulate(array.begin(), array.end(), 1, std::multiplies<int>());
    std::cout << "multiplies: " << mul << std::endl;

    // greater in <functional> header
    // The max value does not appear. Because the value of "greator" is 0 or 1.
    int greater = std::accumulate(array.begin(), array.end(), array.front(), std::greater<int>());
    std::cout << "greater: " << greater << std::endl;

    // less in <functional> header
    // Does not behave as expected for the same reason as "greator"
    int less = std::accumulate(array.begin(), array.end(), array.front(), std::less<int>());
    std::cout << "less: " << less << std::endl;

    // max in <algorithm> header
    // Using std::max as is will result in a compilation error. Type inference must be used in a fixed manner.
    int const & (*max_func) (int const &, int const &) = std::max<int>;
    int max = std::accumulate(array.begin(), array.end(), array.front(), max_func);
    std::cout << "max: " << max << std::endl;

    // max in <algorithm> header
    // Or you have no choice but to use a lambda function.
    int max2 = std::accumulate(array.begin(), array.end(), array.front(), [&] (int a, int b) { return std::max(a,b);});
    std::cout << "max2: " << max2 << std::endl;
}

int main()
{
    iota_sample();
    partial_sum_sample();
    accumulate_sample();
}