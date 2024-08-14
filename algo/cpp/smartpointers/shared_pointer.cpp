#include <memory>
#include <vector>
#include <array>
#include <iostream>

namespace shared_pointer_sample {

template <typename T>
void printvalue(T value)
{
    std::cout << value << std::endl;
}
//void printvalue<int>(int value);

template <typename T>
void printarray(int n, T value_array)
{
    for(int i=0;i<n;i++) {
        std::cout << value_array->at(i) << ",";
    }
    std::cout << std::endl;
}

class someclass {
public:
    int value1;
    int incr(int value);
};
int someclass::incr(int value)
{
    return value+1;
}

std::shared_ptr<someclass> someclassFactory() {
    auto obj = std::make_shared<someclass>();
    obj->value1 = 20;
    return obj;
}

template <typename T>
std::shared_ptr<std::vector<T>> vectorFactory(size_t size) {
    auto vec = std::make_shared<std::vector<T>>(size);
    return vec;
}


void make_shared_sample()
{
    //////////////////////////////////
    ///  pure c array
    //////////////////////////////////
    // auto array1 = std::make_unique<int[]>(3);  // compile error in C++17

    //////////////////////////////////
    ///  std::vector
    //////////////////////////////////
    //auto array1 = std::make_shared<int[]>(3); // compile error

    // bad code
    //auto& vec0 = *std::make_shared<std::vector<int>>(2);
    //vec0[0] = 1;
    //vec0[1] = 2;

    auto vec1 = std::make_shared<std::vector<int>>(2);
    vec1->at(0) = 1;
    (*vec1)[1] = 2;
    vec1->push_back(3);
    std::cout << "vector size: " << vec1->size() << std::endl;
    //std::cout << "setarray:" << vec1[0] << std::endl; // compile error
    std::cout << "setarray:" << vec1->at(0) << std::endl;

    auto vec2 = vec1;               // copy
    //auto vec2 = std::move(vec1); // just move

    std::cout << "copied from vec1 to vec2" << std::endl;

    printvalue(vec2->at(0));
    std::cout << "printed vec2->at(0)" << std::endl;
    printvalue((*vec2)[0]);
    std::cout << "printed (*vec2)[0]" << std::endl;

    printvalue(vec1->at(0)); // nullpointer ? but no compile error
    std::cout << "printed value1" << std::endl;

    printarray(3, vec2);
    std::cout << "printed vec2" << std::endl;

    printarray(3, vec2.get()); // int *value
    std::cout << "printed vec2.get()" << std::endl;

    int* vec2raw = vec2->data();
    for(int i=0;i<vec2->size();i++) {
        std::cout << vec2raw[i] << ","; 
    }
    std::cout << std::endl;
    std::cout << "printed vec2raw" << std::endl;

    for(const auto& value : *vec2) {
        std::cout << value << ","; 
    }
    std::cout << std::endl;
    std::cout << "printed for(v : *vec2)" << std::endl;

    for(auto i=vec2->begin();i!=vec2->end();i++) {
        std::cout << *i << ","; 
    }
    std::cout << std::endl;
    std::cout << "printed for(vec2->begin();end();i++)" << std::endl;

    auto arr3 = std::make_shared<std::vector<int>>();
    arr3->push_back(1);
    std::cout << "pushed arr2" << std::endl;
    std::cout << arr3->at(0) << std::endl;
    std::cout << "printed arr3->at(0)" << std::endl;

    //////////////////////////////////
    ///  user class
    //////////////////////////////////
    auto obj1 = std::make_shared<someclass>();
    std::cout << "made obj1" << std::endl;
    obj1->value1 = 10;
    std::cout << "set to obj1" << std::endl;
    printvalue(obj1->incr(obj1->value1));
    std::cout << "called method in obj1" << std::endl;

    auto obj2 = someclassFactory(); // move to obj2 from factory
    std::cout << "made obj2 by factory" << std::endl;
    printvalue(obj2->incr(obj2->value1));
    std::cout << "called method in obj2" << std::endl;

    //////////////////////////////////
    ///  std::array
    //////////////////////////////////
    auto arr1 = std::make_shared<std::array<int,3>>();
    arr1->at(0) = 1;
    (*arr1)[1] = 2;
    arr1.get()->at(2) = 3;
    std::cout << "setarray:" << arr1->at(0) << std::endl;

    // compile error
    auto arr2 = arr1;         // you can NOT copy
    //auto arr2 = std::move(arr1); // just move
    std::cout << "copy from arr1 to arr2" << std::endl;

    printvalue(arr2->at(0));
    std::cout << "printed arr2" << std::endl;
    printvalue(arr2.get()->at(0));
    std::cout << "printed arr2.get()->at(0)" << std::endl;

    printvalue(arr1->at(0));
    std::cout << "printed value1" << std::endl;

    printarray(3, arr2);
    std::cout << "printed arr2" << std::endl;

    //////////////////////////////////
    ///  vector factory
    //////////////////////////////////
    auto vec4 = vectorFactory<int>(3);
    vec4->at(0) = 1;
    vec4->at(1) = 2;
    vec4->at(2) = 3;
}
}

void main()
{
    shared_pointer_sample::make_shared_sample();
}

