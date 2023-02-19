#include <iostream>

namespace Cmap {
    class Cmapcc
    {
        public: void hello(void)
        {
            std::cout << "Hello C++!" << std::endl;
        }
    };

    extern "C" void* cmapcc_new(void)
    {
        return new Cmapcc();
    }

    extern "C" void cmapcc_delete(void *obj)
    {
        Cmapcc *cc = (Cmapcc *)obj;
        delete(cc);
    }

    extern "C" void cmapcc_hello(void *obj)
    {
        Cmapcc *cc = (Cmapcc *)obj;
        cc->hello();
    }
}
