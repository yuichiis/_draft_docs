#include <iostream>
#include <string>
#include "cpplib.hpp"

int main(int ac, char *av[])
{
    std::cout << "Hello, World" << std::endl;
    CppNs::CppLib sub("CppLib",5);
    std::string option = "";
    if(ac>1) {
        option = av[1];
    }
    sub.hello();
    try {
        if(option == "l") {
            sub.logic_error();
        } else if(option == "r") {
            sub.runtime_error();
        } else {
            sub.error();
        }
    } catch(std::runtime_error& e) {
        std::cout << "RUNTIME:" << e.what() << std::endl;
    } catch(std::logic_error& e) {
        std::cout << "LOGIC:" << e.what() << std::endl;
    }

    std::cout << "sub:";
    sub.printList();
    {
        CppNs::CppLib sub2(sub);
        for (auto &v : *sub2.list()) {
            v++;
        }
        std::cout << "sub2:";
        for (auto v : *sub2.list()) {
            std::cout << v << ",";
        }
        std::cout << std::endl;
        sub2.incrementList();
        std::cout << "sub2 after inc:";
        sub2.printList();
    }
    CppNs::CppLib sub3("CppLib3",3);
    std::cout << "sub:";
    sub.printList();
    std::cout << "sub3:";
    sub3.printList();
    return 0;
}
