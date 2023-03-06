#define COMPILING_DLL

#include <stdint.h>
#include <stdio.h>
#if _MSC_VER
#include <windows.h>
#endif

#include "testdll.h"

RINDOW_FUNC uint64_t testdll(int * x)
{
    printf("[%d]\n",*x);
    return *x;
}

RINDOW_FUNC int * returnpointer(int *x)
{
    #if _MSC_VER
        printf("pointer[%lld]\n",(int64_t)x);
    #else
        printf("pointer[%ld]\n",(int64_t)x);
    #endif
    return x;
}