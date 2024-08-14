#include <iostream>

extern "C" extern void clibmap(void);

int main(int ac, char *av[])
{
    std::cout << "Hello, World" << std::endl;
    clibmap();
    return 0;
}
