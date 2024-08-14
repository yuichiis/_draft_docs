#include <memory>
#include <vector>
#include <array>
#include <iostream>

namespace unique_pointer_sample {

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
        std::cout << value_array[i] << ",";
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

std::unique_ptr<someclass> factory() {
    auto obj = std::make_unique<someclass>();
    obj->value1 = 20;
    return obj;
}

void make_unique_sample()
{
    //////////////////////////////////
    ///  pure c array
    //////////////////////////////////
    auto array1 = std::make_unique<int[]>(3);
    array1[0] = 1;
    array1[1] = 2;
    array1[2] = 3;
    std::cout << "setarray:" << array1[0] << std::endl;

    // compile error
    // auto array2 = array1;         // you can NOT copy
    auto array2 = std::move(array1); // just move
    std::cout << "moved from array1 to array2" << std::endl;

    printvalue(array2[0]);
    std::cout << "printed array2" << std::endl;
    printvalue(array2.get()[0]);
    std::cout << "printed array2.get()[0]" << std::endl;

    //printvalue(array1[0]); // nullpointer ? but no compile error
    //std::cout << "printed value1" << std::endl;
    if(array1.get()==nullptr) {
        std::cout << "value1.get is null" << std::endl;
    }

    // compile error
    // printarray(3, array2);
    printarray(3, array2.get()); // int *value
    std::cout << "printed array2.get()" << std::endl;

    //////////////////////////////////
    ///  user class
    //////////////////////////////////

    auto obj1 = std::make_unique<someclass>();
    std::cout << "made obj1" << std::endl;
    obj1->value1 = 10;
    std::cout << "set to obj1" << std::endl;
    printvalue(obj1->incr(obj1->value1));
    std::cout << "called method in obj1" << std::endl;

    auto obj2 = factory(); // move to obj2 from factory
    std::cout << "made obj2 by factory" << std::endl;
    printvalue(obj2->incr(obj2->value1));
    std::cout << "called method in obj2" << std::endl;

    //////////////////////////////////
    ///  std::vector
    //////////////////////////////////
    auto vec1 = std::make_unique<std::vector<int>>(3);
    (*vec1)[0] = 1;
    vec1->at(1) = 2;
    vec1->at(2) = 3;
    std::cout << "setarray:" << vec1->at(0) << std::endl;

    // compile error
    // auto vec2 = vec1;         // you can NOT copy
    auto vec2 = std::move(vec1); // just move
    std::cout << "moved from vec1 to vec2" << std::endl;

    printvalue(vec2->at(0));
    std::cout << "printed vec2" << std::endl;
    printvalue(vec2.get()->at(0));
    std::cout << "printed vec2.get()->at(0)" << std::endl;

    //printvalue(vec1[0]); // nullpointer ? but no compile error
    //std::cout << "printed value1" << std::endl;
    if(vec1.get()==nullptr) {
        std::cout << "value1.get is null" << std::endl;
    }

    // compile error
    // printarray(3, vec2);
    printarray(3, vec2.get()->data()); // int *value
    std::cout << "printed vec2.get()->data()" << std::endl;

    auto vec3 = std::make_unique<std::vector<int>>();
    vec3->push_back(1);
    std::cout << "pushed vec3" << std::endl;
    std::cout << vec3->at(0) << std::endl;
    std::cout << "printed vec3->at(0)" << std::endl;

    //////////////////////////////////
    ///  std::array
    //////////////////////////////////
    auto arr1 = std::make_unique<std::array<int,3>>();
    //std::unique_ptr<std::array<int, 3>> arr3 = std::make_unique<std::array<int,3>>();
    arr1->at(0) = 1;
    (*arr1)[1] = 2;
    arr1.get()->at(2) = 3;
    std::cout << "setarray:" << arr1->at(0) << std::endl;

    // compile error
    // auto arr2 = arr1;         // you can NOT copy
    auto arr2 = std::move(arr1); // just move
    std::cout << "moved from arr1 to arr2" << std::endl;

    printvalue(arr2->at(0));
    std::cout << "printed arr2" << std::endl;
    printvalue(arr2.get()->at(0));
    std::cout << "printed arr2.get()->at(0)" << std::endl;

    //printvalue(arr1[0]); // nullpointer ? but no compile error
    //std::cout << "printed value1" << std::endl;
    if(arr1.get()==nullptr) {
        std::cout << "value1.get is null" << std::endl;
    }

    // compile error
    // printarray(3, arr2);
    printarray(3, arr2.get()->data()); // int *value
    std::cout << "printed arr2.get()->data()" << std::endl;
}
}

void main()
{
    unique_pointer_sample::make_unique_sample();
}

