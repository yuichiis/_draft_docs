#define RINDOW_COMPILING_DLL

#include <stdint.h>
#include <stdio.h>
#if _MSC_VER
#include <windows.h>
#endif

#include "testdll.h"

static int64_t server_var = 0;

#if _MSC_VER
BOOL WINAPI DllMain(HINSTANCE hinstDLL,  // DLL module handle
    DWORD fdwReason,              // reason called 
    LPVOID lpvReserved)           // reserved 
{ 
    BOOL fInit, fIgnore; 
 
    switch (fdwReason) 
    { 
        // DLL load due to process initialization or LoadLibrary
 
          case DLL_PROCESS_ATTACH:
            printf("attach process dll\n");
            server_var += 1;
            break; 
 
        // The attached process creates a new thread
 
        case DLL_THREAD_ATTACH: 
            printf("attach thread dll\n");
            break;
 
        // The thread of the attached process terminates
 
        case DLL_THREAD_DETACH: 
            printf("detach thread dll\n");
            break; 
 
        // DLL unload due to process termination or FreeLibrary
 
        case DLL_PROCESS_DETACH: 
            printf("detach process dll\n");
            break; 
 
        default: 
            printf("unknown reason=%d\n",fdwReason);
            break; 
     } 
 
    return TRUE; 
    UNREFERENCED_PARAMETER(hinstDLL); 
    UNREFERENCED_PARAMETER(lpvReserved); 
} 
#endif

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

RINDOW_FUNC int64_t get_server_var()
{
    return server_var;
}

RINDOW_FUNC void set_server_var(int64_t val)
{
    server_var = val;
}

