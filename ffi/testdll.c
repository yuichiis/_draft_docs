#define COMPILING_DLL

#include <stdint.h>
#include <stdio.h>
#include <windows.h>

#include "testdll.h"

uint64_t testdll(int * x)
{
    printf("[%d]\n",*x);
    return *x;
}

int * returnpointer(int *x)
{
    printf("pointer[%lld]\n",(int64_t)x);
    return x;
}