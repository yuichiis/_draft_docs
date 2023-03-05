#ifndef TESTDLL_H_
#define TESTDLL_H_


#if defined(COMPILING_DLL)
  #define PUBLIC_API __declspec(dllexport)
#else
  #define PUBLIC_API __declspec(dllimport)
#endif

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

extern uint64_t PUBLIC_API testdll(int * x);
extern PUBLIC_API int * returnpointer(int * x);

#ifdef __cplusplus
} // extern "C"
#endif

// TESTDLL_H_
#endif
