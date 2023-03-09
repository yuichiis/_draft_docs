#ifndef TESTDLL_H_
#define TESTDLL_H_

#if _MSC_VER

#if !defined(RINDOW_FUNC)
  #if defined(RINDOW_COMPILING_DLL)
    #define RINDOW_FUNC
    #define RINDOW_FUNC_DECL extern __declspec(dllexport)
  #elif defined(RINDOW_MATHLIB_INCLUDING_SOURCE)
    #define RINDOW_FUNC
    #define RINDOW_FUNC_DECL
  #else
    #define RINDOW_FUNC
    #define RINDOW_FUNC_DECL extern __declspec(dllimport)
  #endif
#endif // !defined(RINDOW_FUNC)

#else // _MSC_VER

  #define RINDOW_FUNC
  #define RINDOW_FUNC_DECL

#endif // _MSC_VER

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

RINDOW_FUNC_DECL uint64_t testdll(int * x);
RINDOW_FUNC_DECL int * returnpointer(int * x);
RINDOW_FUNC_DECL int64_t get_server_var();
RINDOW_FUNC_DECL void set_server_var(int64_t val);

#ifdef __cplusplus
} // extern "C"
#endif

// TESTDLL_H_
#endif
