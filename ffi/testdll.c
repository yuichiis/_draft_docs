#define COMPILING_DLL

#include <stdint.h>
#include <stdio.h>
#include <windows.h>

#include "testdll.h"

RINDOW_FUNC uint64_t testdll(int * x)
{
    printf("[%d]\n",*x);
    return *x;
}

RINDOW_FUNC int * returnpointer(int *x)
{
    printf("pointer[%lld]\n",(int64_t)x);
    return x;
}