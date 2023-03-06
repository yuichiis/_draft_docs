#include <stdio.h>
#include <stdint.h>
#include "testdll.h"

int main(int ac, char *av[])
{
    int x=1;
    uint64_t y;
    int *z;
    y = testdll(&x);
    #if _MSC_VER
        printf("y=%lld\n",y);
    #else
        printf("y=%ld\n",y);
    #endif

    z = returnpointer(&x);
    #if _MSC_VER
        printf("&x=%lld\n",(int64_t)&x);
        printf("z=%lld\n",(int64_t)z);
    #else
        printf("&x=%ld\n",(int64_t)&x);
        printf("z=%ld\n",(int64_t)z);
    #endif
}