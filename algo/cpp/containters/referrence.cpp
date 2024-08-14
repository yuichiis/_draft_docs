#include <iostream>

void main()
{
    int *array = new int(3);
    array[0] = 1;
    array[1] = 2;
    array[2] = 3;

    int *pointer = array;
    std::cout << *pointer++ << std::endl; 
    int& snap = *pointer;
    std::cout << *pointer++ << std::endl; 
    std::cout << *pointer++ << std::endl; 

    std::cout << snap << std::endl; 
    array[1] = 10;
    std::cout << snap << std::endl; 
}