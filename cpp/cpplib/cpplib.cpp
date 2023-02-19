#include <iostream>
#include <stdexcept>
#include <vector>
#include "cpplib.hpp"

namespace CppNs {
    CppLib::CppLib(
        const char *name,
        int n
    ) : name(name), intvector(new std::vector<int>(n))
    {
        int i=0;
        for(auto &v : *intvector) {
            v = i;
            i++;
        }
        std::cout << "Initialized." << std::endl;
    }

    void CppLib::hello(void)
    {
        std::cout << "Hello, " << name << std::endl;
    }

    void CppLib::error(void)
    {
        throw CppException("exception!!");
    }

    void CppLib::runtime_error(void)
    {
        throw std::runtime_error("runtime error!!");
    }

    void CppLib::logic_error(void)
    {
        throw std::logic_error("logic error!!");
    }

    std::shared_ptr<std::vector<int>> CppLib::list(void) {
        return intvector;
    }

    void CppLib::printList(void) {
        for(auto v : *intvector) {
            std::cout << v << ",";
        }
        std::cout << std::endl;
    }

    void CppLib::incrementList(void) {
        for(auto &v : *intvector) {
            v++;
        }
    }

    CppException::CppException(
        const char *msg
    ) : std::runtime_error(msg)
    {
    }
}
