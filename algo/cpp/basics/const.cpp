#include <iostream>

const size_t somemax = 4;

class Some
{
public:
    const size_t max = 4;
    // int a[max];   // error
    int a[somemax];

    Some()
    {
        for(int i=0;i<max;i++) {
            a[i] = i+1;
        }
    }

    int get(size_t index) const
    {
        if(index>=max) {
            throw std::out_of_range("index out of range");
        }
        std::cout << "[get() const]";
        return a[index];
    }

    void set(size_t index, int value) // without const
    {
        if(index>=max) {
            throw std::out_of_range("index out of range");
        }
        std::cout << "[set()]";
        a[index] = value;
    }

    int& at(size_t index) // if with const, then error
    {
        if(index>=max) {
            throw std::out_of_range("index out of range");
        }
        std::cout << "[at()]";
        return a[index];
    }

    const int& at(size_t index) const
    {
        if(index>=max) {
            throw std::out_of_range("index out of range");
        }
        std::cout << "[at() const]";
        return a[index];
    }
};

void main()
{
    // const value
    const Some a;
    for(int i=0;i<somemax;++i) {
        std::cout << a.get(i);
    }
    std::cout << std::endl;
    // a.set(1,9); // error
    for(int i=0;i<somemax;++i) {
        std::cout << a.at(i);
    }
    std::cout << std::endl;


    // without const value
    Some b;
    for(int i=0;i<somemax;++i) {
        std::cout << b.get(i);
    }
    std::cout << std::endl;
    b.set(3,9);
    for(int i=0;i<somemax;++i) {
        std::cout << b.get(i);
    }
    std::cout << std::endl;

    b.at(2) = 8;
    for(int i=0;i<somemax;++i) {
        std::cout << b.at(i);
    }
    std::cout << std::endl;

    const int bv = b.at(1);
    std::cout << bv << std::endl;
}