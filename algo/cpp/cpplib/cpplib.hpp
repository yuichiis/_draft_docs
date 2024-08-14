#include <stdexcept>
#include <vector>

namespace CppNs {
    class CppLib {
    private:
        const char *name;
        std::shared_ptr<std::vector<int>> intvector;
    public:
        CppLib(const char *name, int n);
        void hello(void);
        void error(void);
        void runtime_error(void);
        void logic_error(void);
        std::shared_ptr<std::vector<int>> list(void);
        void printList(void);
        void incrementList(void);
    };

    class CppException : public std::runtime_error {
    public:
        CppException(const char *msg);
    };
}
