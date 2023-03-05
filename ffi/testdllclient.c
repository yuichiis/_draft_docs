#include <stdio.h>
#include <stdint.h>
#include "testdll.h"

int main(int ac, char *av[])
{
    int x=1;
    uint64_t y;
    int *z;
    y = testdll(&x);
    printf("y=%lld\n",y);

    z = returnpointer(&x);
    printf("&x=%lld\n",(int64_t)&x);
    printf("z=%lld\n",(int64_t)z);
}