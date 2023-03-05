#line 1 "clblastffi.c"
#line 1 "C:\\OpenCL\\CLBlast-1.5.2-Windows-x64\\include\\clblast_c.h"

// =================================================================================================
// This file is part of the CLBlast project. The project is licensed under Apache Version 2.0. This
// project loosely follows the Google C++ styleguide and uses a tab-size of two spaces and a max-
// width of 100 characters per line.
//
// Author(s):
//   Cedric Nugteren <www.cedricnugteren.nl>
//
// This file contains the plain C interface to the CLBlast BLAS routines, the counter-part of the
// normal 'clblast.h' C++ header.
//
// =================================================================================================




// Includes the normal OpenCL C header


#line 22 "C:\\OpenCL\\CLBlast-1.5.2-Windows-x64\\include\\clblast_c.h"
  #line 1 "C:\\OpenCL\\include\\CL/opencl.h"
/*******************************************************************************
 * Copyright (c) 2008-2021 The Khronos Group Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 ******************************************************************************/








#line 1 "C:\\OpenCL\\include\\CL/cl.h"
/*******************************************************************************
 * Copyright (c) 2008-2020 The Khronos Group Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 ******************************************************************************/




#line 1 "C:\\OpenCL\\include\\CL/cl_version.h"
/*******************************************************************************
 * Copyright (c) 2018-2020 The Khronos Group Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 ******************************************************************************/




/* Detect which version to target */

#pragma message("cl_version.h: CL_TARGET_OPENCL_VERSION is not defined. Defaulting to 300 (OpenCL 3.0)")

#line 25 "C:\\OpenCL\\include\\CL/cl_version.h"




#line 36 "C:\\OpenCL\\include\\CL/cl_version.h"


/* OpenCL Version */


#line 42 "C:\\OpenCL\\include\\CL/cl_version.h"


#line 45 "C:\\OpenCL\\include\\CL/cl_version.h"


#line 48 "C:\\OpenCL\\include\\CL/cl_version.h"


#line 51 "C:\\OpenCL\\include\\CL/cl_version.h"


#line 54 "C:\\OpenCL\\include\\CL/cl_version.h"


#line 57 "C:\\OpenCL\\include\\CL/cl_version.h"


#line 60 "C:\\OpenCL\\include\\CL/cl_version.h"

/* Allow deprecated APIs for older OpenCL versions. */


#line 65 "C:\\OpenCL\\include\\CL/cl_version.h"


#line 68 "C:\\OpenCL\\include\\CL/cl_version.h"


#line 71 "C:\\OpenCL\\include\\CL/cl_version.h"


#line 74 "C:\\OpenCL\\include\\CL/cl_version.h"


#line 77 "C:\\OpenCL\\include\\CL/cl_version.h"


#line 80 "C:\\OpenCL\\include\\CL/cl_version.h"

#line 82 "C:\\OpenCL\\include\\CL/cl_version.h"
#line 21 "C:\\OpenCL\\include\\CL/cl.h"
#line 1 "C:\\OpenCL\\include\\CL/cl_platform.h"
/*******************************************************************************
 * Copyright (c) 2008-2020 The Khronos Group Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 ******************************************************************************/











    
        
    #line 30 "C:\\OpenCL\\include\\CL/cl_platform.h"
    
        
    #line 33 "C:\\OpenCL\\include\\CL/cl_platform.h"
    
        
    #line 36 "C:\\OpenCL\\include\\CL/cl_platform.h"










#line 47 "C:\\OpenCL\\include\\CL/cl_platform.h"

/*
 * Deprecation flags refer to the last version of the header in which the
 * feature was not deprecated.
 *
 * E.g. VERSION_1_1_DEPRECATED means the feature is present in 1.1 without
 * deprecation but is deprecated in versions later than 1.1.
 */



#line 59 "C:\\OpenCL\\include\\CL/cl_platform.h"



#line 63 "C:\\OpenCL\\include\\CL/cl_platform.h"


















  
  



#line 87 "C:\\OpenCL\\include\\CL/cl_platform.h"





    
    
#line 95 "C:\\OpenCL\\include\\CL/cl_platform.h"





    
    
#line 103 "C:\\OpenCL\\include\\CL/cl_platform.h"





    
    
 #line 111 "C:\\OpenCL\\include\\CL/cl_platform.h"





    
    
#line 119 "C:\\OpenCL\\include\\CL/cl_platform.h"





    
    
#line 127 "C:\\OpenCL\\include\\CL/cl_platform.h"





    
    
#line 135 "C:\\OpenCL\\include\\CL/cl_platform.h"






#line 142 "C:\\OpenCL\\include\\CL/cl_platform.h"

/* intptr_t is used in cl.h and provided by stddef.h in Visual C++, but not in clang */
/* stdint.h was missing before Visual Studio 2010, include it for later versions and for clang */

    #line 1 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\stdint.h"
//
// stdint.h
//
//      Copyright (c) Microsoft Corporation. All rights reserved.
//
// The C Standard Library <stdint.h> header.
//
#pragma once


#line 1 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"
//
// vcruntime.h
//
//      Copyright (c) Microsoft Corporation. All rights reserved.
//
// Declarations used throughout the VCRuntime library.
//
#pragma once
//
// Note on use of "deprecate":
//
// Various places in this header and other headers use
// __declspec(deprecate) or macros that have the term DEPRECATE in them.
// We use "deprecate" here ONLY to signal the compiler to emit a warning
// about these items. The use of "deprecate" should NOT be taken to imply
// that any standard committee has deprecated these functions from the
// relevant standards.  In fact, these functions are NOT deprecated from
// the standard.
//
// Full details can be found in our documentation by searching for
// "Security Enhancements in the CRT".
//




// Many VCRuntime headers avoid exposing their contents to non-compilers like
// the Windows resource compiler and Qt's meta-object compiler (moc).


#line 32 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"

#line 34 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"
#line 35 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"


    
#line 39 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"

// The _CRTIMP macro is not used in the VCRuntime or the CoreCRT anymore, but
// there is a lot of existing code that declares CRT functions using this macro,
// and if we remove its definition, we break that existing code.  It is thus
// defined here only for compatibility.

    
    

#line 49 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"
        


            
        #line 54 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"
    #line 55 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"
#line 56 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"

#line 1 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\sal.h"
/***
*sal.h - markers for documenting the semantics of APIs
*
*       Copyright (c) Microsoft Corporation. All rights reserved.
*
*Purpose:
*       sal.h provides a set of annotations to describe how a function uses its
*       parameters - the assumptions it makes about them, and the guarantees it makes
*       upon finishing.
*
*       [Public]
*
****/
#pragma once

/*==========================================================================

   The comments in this file are intended to give basic understanding of
   the usage of SAL, the Microsoft Source Code Annotation Language.
   For more details, please see https://go.microsoft.com/fwlink/?LinkID=242134

   The macros are defined in 3 layers, plus the structural set:

   _In_/_Out_/_Ret_ Layer:
   ----------------------
   This layer provides the highest abstraction and its macros should be used
   in most cases. These macros typically start with:
      _In_     : input parameter to a function, unmodified by called function
      _Out_    : output parameter, written to by called function, pointed-to
                 location not expected to be initialized prior to call
      _Outptr_ : like _Out_ when returned variable is a pointer type
                 (so param is pointer-to-pointer type). Called function
                 provides/allocated space.
      _Outref_ : like _Outptr_, except param is reference-to-pointer type.
      _Inout_  : inout parameter, read from and potentially modified by
                 called function.
      _Ret_    : for return values
      _Field_  : class/struct field invariants
   For common usage, this class of SAL provides the most concise annotations.
   Note that _In_/_Out_/_Inout_/_Outptr_ annotations are designed to be used
   with a parameter target. Using them with _At_ to specify non-parameter
   targets may yield unexpected results.

   This layer also includes a number of other properties that can be specified
   to extend the ability of code analysis, most notably:
      -- Designating parameters as format strings for printf/scanf/scanf_s
      -- Requesting stricter type checking for C enum parameters

   _Pre_/_Post_ Layer:
   ------------------
   The macros of this layer only should be used when there is no suitable macro
   in the _In_/_Out_ layer. Its macros start with _Pre_ or _Post_.
   This layer provides the most flexibility for annotations.

   Implementation Abstraction Layer:
   --------------------------------
   Macros from this layer should never be used directly. The layer only exists
   to hide the implementation of the annotation macros.

   Structural Layer:
   ----------------
   These annotations, like _At_ and _When_, are used with annotations from
   any of the other layers as modifiers, indicating exactly when and where
   the annotations apply.


   Common syntactic conventions:
   ----------------------------

   Usage:
   -----
   _In_, _Out_, _Inout_, _Pre_, _Post_, are for formal parameters.
   _Ret_, _Deref_ret_ must be used for return values.

   Nullness:
   --------
   If the parameter can be NULL as a precondition to the function, the
   annotation contains _opt. If the macro does not contain '_opt' the
   parameter cannot be NULL.

   If an out/inout parameter returns a null pointer as a postcondition, this is
   indicated by _Ret_maybenull_ or _result_maybenull_. If the macro is not
   of this form, then the result will not be NULL as a postcondition.
     _Outptr_ - output value is not NULL
     _Outptr_result_maybenull_ - output value might be NULL

   String Type:
   -----------
   _z: NullTerminated string
   for _In_ parameters the buffer must have the specified stringtype before the call
   for _Out_ parameters the buffer must have the specified stringtype after the call
   for _Inout_ parameters both conditions apply

   Extent Syntax:
   -------------
   Buffer sizes are expressed as element counts, unless the macro explicitly
   contains _byte_ or _bytes_. Some annotations specify two buffer sizes, in
   which case the second is used to indicate how much of the buffer is valid
   as a postcondition. This table outlines the precondition buffer allocation
   size, precondition number of valid elements, postcondition allocation size,
   and postcondition number of valid elements for representative buffer size
   annotations:
                                     Pre    |  Pre    |  Post   |  Post
                                     alloc  |  valid  |  alloc  |  valid
      Annotation                     elems  |  elems  |  elems  |  elems
      ----------                     ------------------------------------
      _In_reads_(s)                    s    |   s     |   s     |   s
      _Inout_updates_(s)               s    |   s     |   s     |   s
      _Inout_updates_to_(s,c)          s    |   s     |   s     |   c
      _Out_writes_(s)                  s    |   0     |   s     |   s
      _Out_writes_to_(s,c)             s    |   0     |   s     |   c
      _Outptr_result_buffer_(s)        ?    |   ?     |   s     |   s
      _Outptr_result_buffer_to_(s,c)   ?    |   ?     |   s     |   c

   For the _Outptr_ annotations, the buffer in question is at one level of
   dereference. The called function is responsible for supplying the buffer.

   Success and failure:
   -------------------
   The SAL concept of success allows functions to define expressions that can
   be tested by the caller, which if it evaluates to non-zero, indicates the
   function succeeded, which means that its postconditions are guaranteed to
   hold.  Otherwise, if the expression evaluates to zero, the function is
   considered to have failed, and the postconditions are not guaranteed.

   The success criteria can be specified with the _Success_(expr) annotation:
     _Success_(return != FALSE) BOOL
     PathCanonicalizeA(_Out_writes_(MAX_PATH) LPSTR pszBuf, LPCSTR pszPath) :
        pszBuf is only guaranteed to be NULL-terminated when TRUE is returned,
        and FALSE indicates failure. In common practice, callers check for zero
        vs. non-zero returns, so it is preferable to express the success
        criteria in terms of zero/non-zero, not checked for exactly TRUE.

   Functions can specify that some postconditions will still hold, even when
   the function fails, using _On_failure_(anno-list), or postconditions that
   hold regardless of success or failure using _Always_(anno-list).

   The annotation _Return_type_success_(expr) may be used with a typedef to
   give a default _Success_ criteria to all functions returning that type.
   This is the case for common Windows API status types, including
   HRESULT and NTSTATUS.  This may be overridden on a per-function basis by
   specifying a _Success_ annotation locally.

============================================================================*/





#line 151 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\sal.h"



#line 155 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\sal.h"

























// Disable expansion of SAL macros in non-Prefast mode to
// improve compiler throughput.


#line 185 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\sal.h"


#line 188 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\sal.h"

#line 190 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\sal.h"

// safeguard for MIDL and RC builds



#line 196 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\sal.h"



#line 200 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\sal.h"






#line 207 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\sal.h"











#line 219 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\sal.h"






// Some annotations aren't officially SAL2 yet.

#line 228 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\sal.h"
#line 229 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\sal.h"


//============================================================================
//   Structural SAL:
//     These annotations modify the use of other annotations.  They may
//     express the annotation target (i.e. what parameter/field the annotation
//     applies to) or the condition under which the annotation is applicable.
//============================================================================

// _At_(target, annos) specifies that the annotations listed in 'annos' is to
// be applied to 'target' rather than to the identifier which is the current
// lexical target.


// _At_buffer_(target, iter, bound, annos) is similar to _At_, except that
// target names a buffer, and each annotation in annos is applied to each
// element of target up to bound, with the variable named in iter usable
// by the annotations to refer to relevant offsets within target.


// _When_(expr, annos) specifies that the annotations listed in 'annos' only
// apply when 'expr' evaluates to non-zero.




// <expr> indicates whether normal post conditions apply to a function


// <expr> indicates whether post conditions apply to a function returning
// the type that this annotation is applied to


// Establish postconditions that apply only if the function does not succeed


// Establish postconditions that apply in both success and failure cases.
// Only applicable with functions that have  _Success_ or _Return_type_succss_.


// Usable on a function defintion. Asserts that a function declaration is
// in scope, and its annotations are to be used. There are no other annotations
// allowed on the function definition.


// _Notref_ may precede a _Deref_ or "real" annotation, and removes one
// level of dereference if the parameter is a C++ reference (&).  If the
// net deref on a "real" annotation is negative, it is simply discarded.


// Annotations for defensive programming styles.







//============================================================================
//   _In_/_Out_ Layer:
//============================================================================

// Reserved pointer parameters, must always be NULL.


// _Const_ allows specification that any namable memory location is considered
// readonly for a given call.



// Input parameters --------------------------

//   _In_ - Annotations for parameters where data is passed into the function, but not modified.
//          _In_ by itself can be used with non-pointer types (although it is redundant).

// e.g. void SetPoint( _In_ const POINT* pPT );



// nullterminated 'in' parameters.
// e.g. void CopyStr( _In_z_ const char* szFrom, _Out_z_cap_(cchTo) char* szTo, size_t cchTo );




// 'input' buffers with given size











// 'input' buffers valid to the given end pointer








// Output parameters --------------------------

//   _Out_ - Annotations for pointer or reference parameters where data passed back to the caller.
//           These are mostly used where the pointer/reference is to a non-pointer type.
//           _Outptr_/_Outref) (see below) are typically used to return pointers via parameters.

// e.g. void GetPoint( _Out_ POINT* pPT );


























// Inout parameters ----------------------------

//   _Inout_ - Annotations for pointer or reference parameters where data is passed in and
//        potentially modified.
//          void ModifyPoint( _Inout_ POINT* pPT );
//          void ModifyPointByRef( _Inout_ POINT& pPT );




// For modifying string buffers
//   void toupper( _Inout_z_ char* sz );



// For modifying buffers with explicit element size











// For modifying buffers with explicit byte size










// Pointer to pointer parameters -------------------------

//   _Outptr_ - Annotations for output params returning pointers
//      These describe parameters where the called function provides the buffer:
//        HRESULT SHStrDupW(_In_ LPCWSTR psz, _Outptr_ LPWSTR *ppwsz);
//      The caller passes the address of an LPWSTR variable as ppwsz, and SHStrDupW allocates
//      and initializes memory and returns the pointer to the new LPWSTR in *ppwsz.
//
//    _Outptr_opt_ - describes parameters that are allowed to be NULL.
//    _Outptr_*_result_maybenull_ - describes parameters where the called function might return NULL to the caller.
//
//    Example:
//       void MyFunc(_Outptr_opt_ int **ppData1, _Outptr_result_maybenull_ int **ppData2);
//    Callers:
//       MyFunc(NULL, NULL);           // error: parameter 2, ppData2, should not be NULL
//       MyFunc(&pData1, &pData2);     // ok: both non-NULL
//       if (*pData1 == *pData2) ...   // error: pData2 might be NULL after call






// Annotations for _Outptr_ parameters returning pointers to null terminated strings.






// Annotations for _Outptr_ parameters where the output pointer is set to NULL if the function fails.




// Annotations for _Outptr_ parameters which return a pointer to a ref-counted COM object,
// following the COM convention of setting the output to NULL on failure.
// The current implementation is identical to _Outptr_result_nullonfailure_.
// For pointers to types that are not COM objects, _Outptr_result_nullonfailure_ is preferred.






// Annotations for _Outptr_ parameters returning a pointer to buffer with a specified number of elements/bytes

































// Annotations for output reference to pointer parameters.


















// Annotations for output reference to pointer parameters that guarantee
// that the pointer is set to NULL on failure.


// Generic annotations to set output value of a by-pointer or by-reference parameter to null/zero on failure.




// return values -------------------------------

//
// _Ret_ annotations
//
// describing conditions that hold for return values after the call

// e.g. _Ret_z_ CString::operator const wchar_t*() const noexcept;



// used with allocated but not yet initialized objects




// used with allocated and initialized objects
//    returns single valid object


//    returns pointer to initialized buffer of specified size







//    returns pointer to partially initialized buffer, with total size 'size' and initialized size 'count'






// Annotations for strict type checking




// Check the return value of a function e.g. _Check_return_ ErrorCode Foo();



// e.g. MyPrintF( _Printf_format_string_ const wchar_t* wzFormat, ... );









// annotations to express value of integral or pointer parameter









// annotation to express that a value (usually a field of a mutable class)
// is not changed by a function call


// Annotations to allow expressing generalized pre and post conditions.
// 'cond' may be any valid SAL expression that is considered to be true as a precondition
// or postcondition (respsectively).



// Annotations to express struct, class and field invariants




















//============================================================================
//   _Pre_/_Post_ Layer:
//============================================================================

//
// Raw Pre/Post for declaring custom pre/post conditions
//




//
// Validity property
//





//
// Buffer size properties
//

// Expressing buffer sizes without specifying pre or post condition








// Expressing buffer size as pre or post condition










//
// Pointer null-ness properties
//




//
// _Pre_ annotations ---
//
// describing conditions that must be met before the call of the function

// e.g. int strlen( _Pre_z_ const char* sz );
// buffer is a zero terminated string


// valid size unknown or indicated by type (e.g.:LPSTR)





// Overrides recursive valid when some field is not yet initialized when using _Inout_


// used with allocated but not yet initialized objects




//
// _Post_ annotations ---
//
// describing conditions that hold after the function call

// void CopyStr( _In_z_ const char* szFrom, _Pre_cap_(cch) _Post_z_ char* szFrom, size_t cchFrom );
// buffer will be a zero-terminated string after the call


// e.g. HRESULT InitStruct( _Post_valid_ Struct* pobj );



// e.g. void free( _Post_ptr_invalid_ void* pv );


// e.g. void ThrowExceptionIfNull( _Post_notnull_ const void* pv );


// e.g. HRESULT GetObject(_Outptr_ _On_failure_(_At_(*p, _Post_null_)) T **p);







#pragma region Input Buffer SAL 1 compatibility macros

/*==========================================================================

   This section contains definitions for macros defined for VS2010 and earlier.
   Usage of these macros is still supported, but the SAL 2 macros defined above
   are recommended instead.  This comment block is retained to assist in
   understanding SAL that still uses the older syntax.

   The macros are defined in 3 layers:

   _In_/_Out_ Layer:
   ----------------
   This layer provides the highest abstraction and its macros should be used
   in most cases. Its macros start with _In_, _Out_ or _Inout_. For the
   typical case they provide the most concise annotations.

   _Pre_/_Post_ Layer:
   ------------------
   The macros of this layer only should be used when there is no suitable macro
   in the _In_/_Out_ layer. Its macros start with _Pre_, _Post_, _Ret_,
   _Deref_pre_ _Deref_post_ and _Deref_ret_. This layer provides the most
   flexibility for annotations.

   Implementation Abstraction Layer:
   --------------------------------
   Macros from this layer should never be used directly. The layer only exists
   to hide the implementation of the annotation macros.


   Annotation Syntax:
   |--------------|----------|----------------|-----------------------------|
   |   Usage      | Nullness | ZeroTerminated |  Extent                     |
   |--------------|----------|----------------|-----------------------------|
   | _In_         | <>       | <>             | <>                          |
   | _Out_        | opt_     | z_             | [byte]cap_[c_|x_]( size )   |
   | _Inout_      |          |                | [byte]count_[c_|x_]( size ) |
   | _Deref_out_  |          |                | ptrdiff_cap_( ptr )         |
   |--------------|          |                | ptrdiff_count_( ptr )       |
   | _Ret_        |          |                |                             |
   | _Deref_ret_  |          |                |                             |
   |--------------|          |                |                             |
   | _Pre_        |          |                |                             |
   | _Post_       |          |                |                             |
   | _Deref_pre_  |          |                |                             |
   | _Deref_post_ |          |                |                             |
   |--------------|----------|----------------|-----------------------------|

   Usage:
   -----
   _In_, _Out_, _Inout_, _Pre_, _Post_, _Deref_pre_, _Deref_post_ are for
   formal parameters.
   _Ret_, _Deref_ret_ must be used for return values.

   Nullness:
   --------
   If the pointer can be NULL the annotation contains _opt. If the macro
   does not contain '_opt' the pointer may not be NULL.

   String Type:
   -----------
   _z: NullTerminated string
   for _In_ parameters the buffer must have the specified stringtype before the call
   for _Out_ parameters the buffer must have the specified stringtype after the call
   for _Inout_ parameters both conditions apply

   Extent Syntax:
   |------|---------------|---------------|
   | Unit | Writ/Readable | Argument Type |
   |------|---------------|---------------|
   |  <>  | cap_          | <>            |
   | byte | count_        | c_            |
   |      |               | x_            |
   |------|---------------|---------------|

   'cap' (capacity) describes the writable size of the buffer and is typically used
   with _Out_. The default unit is elements. Use 'bytecap' if the size is given in bytes
   'count' describes the readable size of the buffer and is typically used with _In_.
   The default unit is elements. Use 'bytecount' if the size is given in bytes.

   Argument syntax for cap_, bytecap_, count_, bytecount_:
   (<parameter>|return)[+n]  e.g. cch, return, cb+2

   If the buffer size is a constant expression use the c_ postfix.
   E.g. cap_c_(20), count_c_(MAX_PATH), bytecount_c_(16)

   If the buffer size is given by a limiting pointer use the ptrdiff_ versions
   of the macros.

   If the buffer size is neither a parameter nor a constant expression use the x_
   postfix. e.g. bytecount_x_(num*size) x_ annotations accept any arbitrary string.
   No analysis can be done for x_ annotations but they at least tell the tool that
   the buffer has some sort of extent description. x_ annotations might be supported
   by future compiler versions.

============================================================================*/

// e.g. void SetCharRange( _In_count_(cch) const char* rgch, size_t cch )
// valid buffer extent described by another parameter





// valid buffer extent described by a constant extression





// nullterminated  'input' buffers with given size

// e.g. void SetCharRange( _In_count_(cch) const char* rgch, size_t cch )
// nullterminated valid buffer extent described by another parameter





// nullterminated valid buffer extent described by a constant extression





// buffer capacity is described by another pointer
// e.g. void Foo( _In_ptrdiff_count_(pchMax) const char* pch, const char* pchMax ) { while pch < pchMax ) pch++; }



// 'x' version for complex expressions that are not supported by the current compiler version
// e.g. void Set3ColMatrix( _In_count_x_(3*cRows) const Elem* matrix, int cRows );






// 'out' with buffer size
// e.g. void GetIndices( _Out_cap_(cIndices) int* rgIndices, size_t cIndices );
// buffer capacity is described by another parameter





// buffer capacity is described by a constant expression





// buffer capacity is described by another parameter multiplied by a constant expression





// buffer capacity is described by another pointer
// e.g. void Foo( _Out_ptrdiff_cap_(pchMax) char* pch, const char* pchMax ) { while pch < pchMax ) pch++; }



// buffer capacity is described by a complex expression





// a zero terminated string is filled into a buffer of given capacity
// e.g. void CopyStr( _In_z_ const char* szFrom, _Out_z_cap_(cchTo) char* szTo, size_t cchTo );
// buffer capacity is described by another parameter





// buffer capacity is described by a constant expression





// buffer capacity is described by a complex expression





// a zero terminated string is filled into a buffer of given capacity
// e.g. size_t CopyCharRange( _In_count_(cchFrom) const char* rgchFrom, size_t cchFrom, _Out_cap_post_count_(cchTo,return)) char* rgchTo, size_t cchTo );





// a zero terminated string is filled into a buffer of given capacity
// e.g. size_t CopyStr( _In_z_ const char* szFrom, _Out_z_cap_post_count_(cchTo,return+1) char* szTo, size_t cchTo );





// only use with dereferenced arguments e.g. '*pcch'










// e.g. GetString( _Out_z_capcount_(*pLen+1) char* sz, size_t* pLen );






// 'inout' buffers with initialized elements before and after the call
// e.g. void ModifyIndices( _Inout_count_(cIndices) int* rgIndices, size_t cIndices );










// nullterminated 'inout' buffers with initialized elements before and after the call
// e.g. void ModifyIndices( _Inout_count_(cIndices) int* rgIndices, size_t cIndices );


















// e.g. void AppendToLPSTR( _In_ LPCSTR szFrom, _Inout_cap_(cchTo) LPSTR* szTo, size_t cchTo );















// inout string buffers with writable size
// e.g. void AppendStr( _In_z_ const char* szFrom, _Inout_z_cap_(cchTo) char* szTo, size_t cchTo );
















// returning pointers to valid objects



// annotations to express 'boundedness' of integral value parameter








// e.g.  HRESULT HrCreatePoint( _Deref_out_opt_ POINT** ppPT );





// e.g.  void CloneString( _In_z_ const wchar_t* wzFrom, _Deref_out_z_ wchar_t** pWzTo );





//
// _Deref_pre_ ---
//
// describing conditions for array elements of dereferenced pointer parameters that must be met before the call

// e.g. void SaveStringArray( _In_count_(cStrings) _Deref_pre_z_ const wchar_t* const rgpwch[] );



// e.g. void FillInArrayOfStr32( _In_count_(cStrings) _Deref_pre_cap_c_(32) _Deref_post_z_ wchar_t* const rgpwch[] );
// buffer capacity is described by another parameter





// buffer capacity is described by a constant expression





// buffer capacity is described by a complex condition





// convenience macros for nullterminated buffers with given capacity















// known capacity and valid but unknown readable extent















// e.g. void SaveMatrix( _In_count_(n) _Deref_pre_count_(n) const Elem** matrix, size_t n );
// valid buffer extent is described by another parameter





// valid buffer extent is described by a constant expression





// valid buffer extent is described by a complex expression





// e.g. void PrintStringArray( _In_count_(cElems) _Deref_pre_valid_ LPCSTR rgStr[], size_t cElems );








// restrict access rights



//
// _Deref_post_ ---
//
// describing conditions for array elements or dereferenced pointer parameters that hold after the call

// e.g. void CloneString( _In_z_ const Wchar_t* wzIn _Out_ _Deref_post_z_ wchar_t** pWzOut );



// e.g. HRESULT HrAllocateMemory( size_t cb, _Out_ _Deref_post_bytecap_(cb) void** ppv );
// buffer capacity is described by another parameter





// buffer capacity is described by a constant expression





// buffer capacity is described by a complex expression





// convenience macros for nullterminated buffers with given capacity















// known capacity and valid but unknown readable extent















// e.g. HRESULT HrAllocateZeroInitializedMemory( size_t cb, _Out_ _Deref_post_bytecount_(cb) void** ppv );
// valid buffer extent is described by another parameter





// buffer capacity is described by a constant expression





// buffer capacity is described by a complex expression





// e.g. void GetStrings( _Out_count_(cElems) _Deref_post_valid_ LPSTR const rgStr[], size_t cElems );







//
// _Deref_ret_ ---
//




//
// special _Deref_ ---
//


//
// _Ret_ ---
//

// e.g. _Ret_opt_valid_ LPSTR void* CloneSTR( _Pre_valid_ LPSTR src );



// e.g. _Ret_opt_bytecap_(cb) void* AllocateMemory( size_t cb );
// Buffer capacity is described by another parameter





// Buffer capacity is described by a constant expression





// Buffer capacity is described by a complex condition





// return value is nullterminated and capacity is given by another parameter





// e.g. _Ret_opt_bytecount_(cb) void* AllocateZeroInitializedMemory( size_t cb );
// Valid Buffer extent is described by another parameter





// Valid Buffer extent is described by a constant expression





// Valid Buffer extent is described by a complex expression





// return value is nullterminated and length is given by another parameter






// _Pre_ annotations ---


// restrict access rights



// e.g. void FreeMemory( _Pre_bytecap_(cb) _Post_ptr_invalid_ void* pv, size_t cb );
// buffer capacity described by another parameter





// buffer capacity described by a constant expression







// buffer capacity is described by another parameter multiplied by a constant expression



// buffer capacity described by size of other buffer, only used by dangerous legacy APIs
// e.g. int strcpy(_Pre_cap_for_(src) char* dst, const char* src);



// buffer capacity described by a complex condition





// buffer capacity described by the difference to another pointer parameter



// e.g. void AppendStr( _Pre_z_ const char* szFrom, _Pre_z_cap_(cchTo) _Post_z_ char* szTo, size_t cchTo );















// known capacity and valid but unknown readable extent















// e.g. void AppendCharRange( _Pre_count_(cchFrom) const char* rgFrom, size_t cchFrom, _Out_z_cap_(cchTo) char* szTo, size_t cchTo );
// Valid buffer extent described by another parameter





// Valid buffer extent described by a constant expression





// Valid buffer extent described by a complex expression





// Valid buffer extent described by the difference to another pointer parameter




// char * strncpy(_Out_cap_(_Count) _Post_maybez_ char * _Dest, _In_z_ const char * _Source, _In_ size_t _Count)
// buffer maybe zero-terminated after the call


// e.g. SIZE_T HeapSize( _In_ HANDLE hHeap, DWORD dwFlags, _Pre_notnull_ _Post_bytecap_(return) LPCVOID lpMem );



// e.g. int strlen( _In_z_ _Post_count_(return+1) const char* sz );







// e.g. size_t CopyStr( _In_z_ const char* szFrom, _Pre_cap_(cch) _Post_z_count_(return+1) char* szFrom, size_t cchFrom );







//
// _Prepost_ ---
//
// describing conditions that hold before and after the function call



















//
// _Deref_<both> ---
//
// short version for _Deref_pre_<ann> _Deref_post_<ann>
// describing conditions for array elements or dereferenced pointer parameters that hold before and after the call










































//
// _Deref_<miscellaneous>
//
// used with references to arrays







#pragma endregion Input Buffer SAL 1 compatibility macros


//============================================================================
//   Implementation Layer:
//============================================================================


// Naming conventions:
// A symbol the begins with _SA_ is for the machinery of creating any
// annotations; many of those come from sourceannotations.h in the case
// of attributes.

// A symbol that ends with _impl is the very lowest level macro.  It is
// not required to be a legal standalone annotation, and in the case
// of attribute annotations, usually is not.  (In the case of some declspec
// annotations, it might be, but it should not be assumed so.)  Those
// symbols will be used in the _PreN..., _PostN... and _RetN... annotations
// to build up more complete annotations.

// A symbol ending in _impl_ is reserved to the implementation as well,
// but it does form a complete annotation; usually they are used to build
// up even higher level annotations.



























































#line 1555 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\sal.h"






























#line 1586 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\sal.h"
























#line 1611 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\sal.h"

// Using "nothing" for sal










#line 1624 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\sal.h"






































#line 1663 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\sal.h"















































































































#line 1775 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\sal.h"






































































































#line 1878 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\sal.h"








































































































































































#line 2047 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\sal.h"

































































































// Obsolete -- may be needed for transition to attributes.



#line 2149 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\sal.h"

// This section contains the deprecated annotations

/*
 -------------------------------------------------------------------------------
 Introduction

 sal.h provides a set of annotations to describe how a function uses its
 parameters - the assumptions it makes about them, and the guarantees it makes
 upon finishing.

 Annotations may be placed before either a function parameter's type or its return
 type, and describe the function's behavior regarding the parameter or return value.
 There are two classes of annotations: buffer annotations and advanced annotations.
 Buffer annotations describe how functions use their pointer parameters, and
 advanced annotations either describe complex/unusual buffer behavior, or provide
 additional information about a parameter that is not otherwise expressible.

 -------------------------------------------------------------------------------
 Buffer Annotations

 The most important annotations in sal.h provide a consistent way to annotate
 buffer parameters or return values for a function. Each of these annotations describes
 a single buffer (which could be a string, a fixed-length or variable-length array,
 or just a pointer) that the function interacts with: where it is, how large it is,
 how much is initialized, and what the function does with it.

 The appropriate macro for a given buffer can be constructed using the table below.
 Just pick the appropriate values from each category, and combine them together
 with a leading underscore. Some combinations of values do not make sense as buffer
 annotations. Only meaningful annotations can be added to your code; for a list of
 these, see the buffer annotation definitions section.

 Only a single buffer annotation should be used for each parameter.

 |------------|------------|---------|--------|----------|----------|---------------|
 |   Level    |   Usage    |  Size   | Output | NullTerm | Optional |  Parameters   |
 |------------|------------|---------|--------|----------|----------|---------------|
 | <>         | <>         | <>      | <>     | _z       | <>       | <>            |
 | _deref     | _in        | _ecount | _full  | _nz      | _opt     | (size)        |
 | _deref_opt | _out       | _bcount | _part  |          |          | (size,length) |
 |            | _inout     |         |        |          |          |               |
 |            |            |         |        |          |          |               |
 |------------|------------|---------|--------|----------|----------|---------------|

 Level: Describes the buffer pointer's level of indirection from the parameter or
          return value 'p'.

 <>         : p is the buffer pointer.
 _deref     : *p is the buffer pointer. p must not be NULL.
 _deref_opt : *p may be the buffer pointer. p may be NULL, in which case the rest of
                the annotation is ignored.

 Usage: Describes how the function uses the buffer.

 <>     : The buffer is not accessed. If used on the return value or with _deref, the
            function will provide the buffer, and it will be uninitialized at exit.
            Otherwise, the caller must provide the buffer. This should only be used
            for alloc and free functions.
 _in    : The function will only read from the buffer. The caller must provide the
            buffer and initialize it. Cannot be used with _deref.
 _out   : The function will only write to the buffer. If used on the return value or
            with _deref, the function will provide the buffer and initialize it.
            Otherwise, the caller must provide the buffer, and the function will
            initialize it.
 _inout : The function may freely read from and write to the buffer. The caller must
            provide the buffer and initialize it. If used with _deref, the buffer may
            be reallocated by the function.

 Size: Describes the total size of the buffer. This may be less than the space actually
         allocated for the buffer, in which case it describes the accessible amount.

 <>      : No buffer size is given. If the type specifies the buffer size (such as
             with LPSTR and LPWSTR), that amount is used. Otherwise, the buffer is one
             element long. Must be used with _in, _out, or _inout.
 _ecount : The buffer size is an explicit element count.
 _bcount : The buffer size is an explicit byte count.

 Output: Describes how much of the buffer will be initialized by the function. For
           _inout buffers, this also describes how much is initialized at entry. Omit this
           category for _in buffers; they must be fully initialized by the caller.

 <>    : The type specifies how much is initialized. For instance, a function initializing
           an LPWSTR must NULL-terminate the string.
 _full : The function initializes the entire buffer.
 _part : The function initializes part of the buffer, and explicitly indicates how much.

 NullTerm: States if the present of a '\0' marks the end of valid elements in the buffer.
 _z    : A '\0' indicated the end of the buffer
 _nz     : The buffer may not be null terminated and a '\0' does not indicate the end of the
          buffer.
 Optional: Describes if the buffer itself is optional.

 <>   : The pointer to the buffer must not be NULL.
 _opt : The pointer to the buffer might be NULL. It will be checked before being dereferenced.

 Parameters: Gives explicit counts for the size and length of the buffer.

 <>            : There is no explicit count. Use when neither _ecount nor _bcount is used.
 (size)        : Only the buffer's total size is given. Use with _ecount or _bcount but not _part.
 (size,length) : The buffer's total size and initialized length are given. Use with _ecount_part
                   and _bcount_part.

 -------------------------------------------------------------------------------
 Buffer Annotation Examples

 LWSTDAPI_(BOOL) StrToIntExA(
     __in LPCSTR pszString,
     DWORD dwFlags,
     __out int *piRet                     -- A pointer whose dereference will be filled in.
 );

 void MyPaintingFunction(
     __in HWND hwndControl,               -- An initialized read-only parameter.
     __in_opt HDC hdcOptional,            -- An initialized read-only parameter that might be NULL.
     __inout IPropertyStore *ppsStore     -- An initialized parameter that may be freely used
                                          --   and modified.
 );

 LWSTDAPI_(BOOL) PathCompactPathExA(
     __out_ecount(cchMax) LPSTR pszOut,   -- A string buffer with cch elements that will
                                          --   be NULL terminated on exit.
     __in LPCSTR pszSrc,
     UINT cchMax,
     DWORD dwFlags
 );

 HRESULT SHLocalAllocBytes(
     size_t cb,
     __deref_bcount(cb) T **ppv           -- A pointer whose dereference will be set to an
                                          --   uninitialized buffer with cb bytes.
 );

 __inout_bcount_full(cb) : A buffer with cb elements that is fully initialized at
     entry and exit, and may be written to by this function.

 __out_ecount_part(count, *countOut) : A buffer with count elements that will be
     partially initialized by this function. The function indicates how much it
     initialized by setting *countOut.

 -------------------------------------------------------------------------------
 Advanced Annotations

 Advanced annotations describe behavior that is not expressible with the regular
 buffer macros. These may be used either to annotate buffer parameters that involve
 complex or conditional behavior, or to enrich existing annotations with additional
 information.

 __success(expr) f :
     <expr> indicates whether function f succeeded or not. If <expr> is true at exit,
     all the function's guarantees (as given by other annotations) must hold. If <expr>
     is false at exit, the caller should not expect any of the function's guarantees
     to hold. If not used, the function must always satisfy its guarantees. Added
     automatically to functions that indicate success in standard ways, such as by
     returning an HRESULT.

 __nullterminated p :
     Pointer p is a buffer that may be read or written up to and including the first
     NULL character or pointer. May be used on typedefs, which marks valid (properly
     initialized) instances of that type as being NULL-terminated.

 __nullnullterminated p :
     Pointer p is a buffer that may be read or written up to and including the first
     sequence of two NULL characters or pointers. May be used on typedefs, which marks
     valid instances of that type as being double-NULL terminated.

 __reserved v :
     Value v must be 0/NULL, reserved for future use.

 __checkReturn v :
     Return value v must not be ignored by callers of this function.

 __typefix(ctype) v :
     Value v should be treated as an instance of ctype, rather than its declared type.

 __override f :
     Specify C#-style 'override' behaviour for overriding virtual methods.

 __callback f :
     Function f can be used as a function pointer.

 __format_string p :
     Pointer p is a string that contains % markers in the style of printf.

 __blocksOn(resource) f :
     Function f blocks on the resource 'resource'.

 __fallthrough :
     Annotates switch statement labels where fall-through is desired, to distinguish
     from forgotten break statements.

 -------------------------------------------------------------------------------
 Advanced Annotation Examples

 __success(return != FALSE) LWSTDAPI_(BOOL)
 PathCanonicalizeA(__out_ecount(MAX_PATH) LPSTR pszBuf, LPCSTR pszPath) :
    pszBuf is only guaranteed to be NULL-terminated when TRUE is returned.

 typedef __nullterminated WCHAR* LPWSTR : Initialized LPWSTRs are NULL-terminated strings.

 __out_ecount(cch) __typefix(LPWSTR) void *psz : psz is a buffer parameter which will be
     a NULL-terminated WCHAR string at exit, and which initially contains cch WCHARs.

 -------------------------------------------------------------------------------
*/











#line 2366 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\sal.h"
#line 2367 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\sal.h"


/*
 -------------------------------------------------------------------------------
 Helper Macro Definitions

 These express behavior common to many of the high-level annotations.
 DO NOT USE THESE IN YOUR CODE.
 -------------------------------------------------------------------------------
*/

/*
    The helper annotations are only understood by the compiler version used by
    various defect detection tools. When the regular compiler is running, they
    are defined into nothing, and do not affect the compiled code.
*/



















































































































































































































#line 2595 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\sal.h"
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
    
    
    

    
    

#line 2634 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\sal.h"

/*
-------------------------------------------------------------------------------
Buffer Annotation Definitions

Any of these may be used to directly annotate functions, but only one should
be used for each parameter. To determine which annotation to use for a given
buffer, use the table in the buffer annotations section.
-------------------------------------------------------------------------------
*/
































































































































































































/*
-------------------------------------------------------------------------------
Advanced Annotation Definitions

Any of these may be used to directly annotate functions, and may be used in
combination with each other or with regular buffer macros. For an explanation
of each annotation, see the advanced annotations section.
-------------------------------------------------------------------------------
*/






















#line 2868 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\sal.h"









#line 2878 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\sal.h"



    
    


#line 2886 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\sal.h"
#line 2887 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\sal.h"






#line 2894 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\sal.h"
#line 2895 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\sal.h"






#line 2902 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\sal.h"
#line 2903 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\sal.h"











#line 2915 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\sal.h"

//
// Set the analysis mode (global flags to analysis).
// They take effect at the point of declaration; use at global scope
// as a declaration.
//

// Synthesize a unique symbol.








//
// Floating point warnings are only meaningful in kernel-mode on x86
// so avoid reporting them on other platforms.
//













#line 2949 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\sal.h"

// The following are predefined:
//  _Analysis_operator_new_throw_   (operator new throws)
//  _Analysis_operator_new_null_        (operator new returns null)
//  _Analysis_operator_new_never_fails_ (operator new never fails)
//

// Function class annotations.

















#line 1 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\concurrencysal.h"
/***
*concurrencysal.h - markers for documenting the concurrent semantics of APIs
*
*       Copyright (c) Microsoft Corporation. All rights reserved.
*
*Purpose:
*       This file contains macros for Concurrency SAL annotations. Definitions
*       starting with _Internal are low level macros that are subject to change.
*       Users should not use those low level macros directly.
*       [ANSI]
*
*       [Public]
*
****/




#pragma once















































































































































































































































































#line 292 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\concurrencysal.h"



#line 296 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\concurrencysal.h"























































/*
 * Old spelling: will be deprecated
 */


































#line 389 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\concurrencysal.h"





#line 395 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\concurrencysal.h"
#line 2975 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\sal.h"
#line 58 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"
#line 1 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vadefs.h"
//
// vadefs.h
//
//      Copyright (c) Microsoft Corporation. All rights reserved.
//
// Definitions of macro helpers used by <stdarg.h>.  This is the topmost header
// in the CRT header lattice, and is always the first CRT header to be included,
// explicitly or implicitly.  Therefore, this header also has several definitions
// that are used throughout the CRT.
//
#pragma once



#pragma pack(push, 8)

// C4339: '__type_info_node': use of undefined type detected in CLR meta-data (/Wall)

    


        
    #line 24 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vadefs.h"
#line 25 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vadefs.h"

// C4412: function signature contains type '<typename>';
//        C++ objects are unsafe to pass between pure code and mixed or native. (/Wall)

    


        
    #line 34 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vadefs.h"
#line 35 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vadefs.h"

// Use _VCRUNTIME_EXTRA_DISABLED_WARNINGS to add additional warning suppressions to VCRuntime headers.

    
#line 40 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vadefs.h"

// C4514: unreferenced inline function has been removed (/Wall)
// C4820: '<typename>' : 'N' bytes padding added after data member (/Wall)

    
#line 46 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vadefs.h"

#pragma warning(push)
#pragma warning(disable:   4514 4820 )







#line 57 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vadefs.h"


    
    
        typedef unsigned __int64  uintptr_t;
    

#line 65 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vadefs.h"
#line 66 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vadefs.h"


    
    


        typedef char* va_list;
    #line 74 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vadefs.h"
#line 75 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vadefs.h"




    
#line 81 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vadefs.h"





#line 87 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vadefs.h"



#line 91 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vadefs.h"
    
    
#line 94 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vadefs.h"











#line 106 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vadefs.h"







#line 114 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vadefs.h"











#line 126 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vadefs.h"





#line 132 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vadefs.h"










#line 143 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vadefs.h"










#line 154 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vadefs.h"

    void __cdecl __va_start(va_list* , ...);

    
    



    

#line 165 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vadefs.h"




































#line 202 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vadefs.h"

    

#line 206 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vadefs.h"

#pragma warning(pop) 
#pragma pack(pop)
#line 59 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"

#pragma warning(push)
#pragma warning(disable:   4514 4820 )

// All C headers have a common prologue and epilogue, to enclose the header in
// an extern "C" declaration when the header is #included in a C++ translation
// unit and to push/pop the packing.










#line 77 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"









#line 87 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"

    


    


#line 95 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"

__pragma(pack(push, 8))




    


        
    #line 106 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"
#line 107 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"
















    

#line 126 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"

#line 128 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"
        
    #line 130 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"
#line 131 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"


    

#line 136 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"
        
    #line 138 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"
#line 139 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"

// Definitions of calling conventions used code sometimes compiled as managed



#line 145 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"
    
    
#line 148 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"




    
#line 154 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"



// Definitions of common __declspecs




    


#line 166 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"



#line 170 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"
    
#line 172 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"




    
#line 178 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"


    



      
    #line 186 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"
#line 187 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"

// For backwards compatibility


// Definitions of common types

    typedef unsigned __int64 size_t;
    typedef __int64          ptrdiff_t;
    typedef __int64          intptr_t;




#line 201 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"



#line 205 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"



#line 209 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"
    typedef _Bool __vcrt_bool;
#line 211 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"

// Indicate that these common types are defined

    
#line 216 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"


    
#line 220 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"


    
#line 224 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"

// Provide a typedef for wchar_t for use under /Zc:wchar_t-

    
    typedef unsigned short wchar_t;
#line 230 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"


    


        
    #line 237 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"
#line 238 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"


    


#line 244 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"



#line 248 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"










    
#line 260 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"



#line 264 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"


    

#line 269 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"

#line 271 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"
        
    #line 273 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"

    


#line 278 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"


#line 281 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"
        
        
    #line 284 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"

    
#line 287 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"



#line 291 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"

// [[nodiscard]] attributes on STL functions

    
        
    



#line 301 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"
#line 302 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"



#line 306 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"
    
#line 308 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"

// See note on use of "deprecate" at the top of this file




#line 315 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"


    


        




    #line 326 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"
#line 327 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"



#line 331 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"


    
        
    


#line 339 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"
#line 340 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"


    void __cdecl __security_init_cookie(void);

    


#line 348 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"


#line 351 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"
        void __cdecl __security_check_cookie(  uintptr_t _StackCookie);
        __declspec(noreturn) void __cdecl __report_gsfailure(  uintptr_t _StackCookie);
    #line 354 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"
#line 355 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"

extern uintptr_t __security_cookie;


    
    
    
#line 363 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"

__pragma(pack(pop))

#pragma warning(pop) 

#line 369 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\vcruntime.h"
#line 12 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\stdint.h"



#pragma warning(push)
#pragma warning(disable:   4514 4820 )

typedef signed char        int8_t;
typedef short              int16_t;
typedef int                int32_t;
typedef long long          int64_t;
typedef unsigned char      uint8_t;
typedef unsigned short     uint16_t;
typedef unsigned int       uint32_t;
typedef unsigned long long uint64_t;

typedef signed char        int_least8_t;
typedef short              int_least16_t;
typedef int                int_least32_t;
typedef long long          int_least64_t;
typedef unsigned char      uint_least8_t;
typedef unsigned short     uint_least16_t;
typedef unsigned int       uint_least32_t;
typedef unsigned long long uint_least64_t;

typedef signed char        int_fast8_t;
typedef int                int_fast16_t;
typedef int                int_fast32_t;
typedef long long          int_fast64_t;
typedef unsigned char      uint_fast8_t;
typedef unsigned int       uint_fast16_t;
typedef unsigned int       uint_fast32_t;
typedef unsigned long long uint_fast64_t;

typedef long long          intmax_t;
typedef unsigned long long uintmax_t;

// These macros must exactly match those in the Windows SDK's intsafe.h.








































    
    
    




#line 97 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\stdint.h"









    // SIZE_MAX definition must match exactly with limits.h for modules support.
    
        
    

#line 112 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\stdint.h"
#line 113 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\stdint.h"























#pragma warning(pop) 

#line 139 "C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\Community\\VC\\Tools\\MSVC\\14.29.30133\\include\\stdint.h"
#line 147 "C:\\OpenCL\\include\\CL/cl_platform.h"
#line 148 "C:\\OpenCL\\include\\CL/cl_platform.h"

/* scalar types  */
typedef signed   __int8         cl_char;
typedef unsigned __int8         cl_uchar;
typedef signed   __int16        cl_short;
typedef unsigned __int16        cl_ushort;
typedef signed   __int32        cl_int;
typedef unsigned __int32        cl_uint;
typedef signed   __int64        cl_long;
typedef unsigned __int64        cl_ulong;

typedef unsigned __int16        cl_half;
typedef float                   cl_float;
typedef double                  cl_double;



#line 166 "C:\\OpenCL\\include\\CL/cl_platform.h"

/* Macro names and corresponding values defined by OpenCL */
































































































































































































#line 361 "C:\\OpenCL\\include\\CL/cl_platform.h"

#line 1 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\stddef.h"
//
// stddef.h
//
//      Copyright (c) Microsoft Corporation. All rights reserved.
//
// The C <stddef.h> Standard Library header.
//
#pragma once



#line 1 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"
//
// corecrt.h
//
//      Copyright (c) Microsoft Corporation. All rights reserved.
//
// Declarations used throughout the CoreCRT library.
//
#pragma once



//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Warning Suppression
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

// C4412: function signature contains type '_locale_t';
//        C++ objects are unsafe to pass between pure code and mixed or native. (/Wall)

    


        
    #line 26 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 27 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"

// Use _UCRT_EXTRA_DISABLED_WARNINGS to add additional warning suppressions to UCRT headers.

    
#line 32 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"

// C4324: structure was padded due to __declspec(align()) (/W4)
// C4514: unreferenced inline function has been removed (/Wall)
// C4574: 'MACRO' is defined to be '0': did you mean to use '#if MACRO'? (/Wall)
// C4710: function not inlined (/Wall)
// C4793: 'function' is compiled as native code (/Wall and /W1 under /clr:pure)
// C4820: padding after data member (/Wall)
// C4995: name was marked #pragma deprecated
// C4996: __declspec(deprecated)
// C28719: Banned API, use a more robust and secure replacement.
// C28726: Banned or deprecated API, use a more robust and secure replacement.
// C28727: Banned API.

    
#line 47 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"


    











        
    #line 63 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 64 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"


    


        
    #line 71 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 72 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"

#pragma warning(push)
#pragma warning(disable: 4324  4514 4574 4710 4793 4820 4995 4996 28719 28726 28727 )


__pragma(pack(push, 8))

//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Annotation Macros
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

    

#line 88 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"

#line 90 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"
        
    #line 92 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 93 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"

// If you need the ability to remove __declspec(import) from an API, to support static replacement,
// declare the API using _ACRTIMP_ALT instead of _ACRTIMP.

    
#line 99 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"


    

#line 104 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"

#line 106 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"
        
    #line 108 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 109 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"



#line 113 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"
    
#line 115 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"


    


#line 121 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"





#line 127 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"
    
#line 129 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"

// __declspec(guard(overflow)) enabled by /sdl compiler switch for CRT allocators



    
#line 136 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"



#line 140 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"
    
#line 142 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"

// The CLR requires code calling other SecurityCritical code or using SecurityCritical types
// to be marked as SecurityCritical.
// _CRT_SECURITYCRITICAL_ATTRIBUTE covers this for internal function definitions.
// _CRT_INLINE_PURE_SECURITYCRITICAL_ATTRIBUTE is for inline pure functions defined in the header.
// This is clr:pure-only because for mixed mode we compile inline functions as native.



    
#line 153 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"













    


        
    #line 171 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 172 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"



#line 176 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"
    
#line 178 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"



#line 182 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"
    
#line 184 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"



#line 188 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"
    
#line 190 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"



//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Miscellaneous Stuff
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
















#line 215 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"



#line 219 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"
    typedef _Bool __crt_bool;
#line 221 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"














    
        


            
        #line 241 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"
    #line 242 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 243 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"









// CRT headers are included into some kinds of source files where only data type
// definitions and macro definitions are required but function declarations and
// inline function definitions are not.  These files include assembly files, IDL
// files, and resource files.  The tools that process these files often have a
// limited ability to process C and C++ code.  The _CRT_FUNCTIONS_REQUIRED macro
// is defined to 1 when we are compiling a file that actually needs functions to
// be declared (and defined, where applicable), and to 0 when we are compiling a
// file that does not.  This allows us to suppress declarations and definitions
// that are not compilable with the aforementioned tools.

    

#line 265 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"
        
    #line 267 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 268 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"



#line 272 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"


    
#line 276 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"


 






  

#line 288 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"
   
  #line 290 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"
 #line 291 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 292 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"

//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Windows API Partitioning and ARM Desktop Support
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

    

















        
    #line 319 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 320 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"


    
#line 324 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"


    
        
    

#line 331 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 332 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"

// Verify that the ARM Desktop SDK is available when building an ARM Desktop app








//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Invalid Parameter Handler
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+










 void __cdecl _invalid_parameter_noinfo(void);
 __declspec(noreturn) void __cdecl _invalid_parameter_noinfo_noreturn(void);

__declspec(noreturn)
 void __cdecl _invoke_watson(
      wchar_t const* _Expression,
      wchar_t const* _FunctionName,
      wchar_t const* _FileName,
            unsigned int _LineNo,
            uintptr_t _Reserved);


    



        // By default, _CRT_SECURE_INVALID_PARAMETER in retail invokes
        // _invalid_parameter_noinfo_noreturn(), which is marked
        // __declspec(noreturn) and does not return control to the application.
        // Even if _set_invalid_parameter_handler() is used to set a new invalid
        // parameter handler which does return control to the application,
        // _invalid_parameter_noinfo_noreturn() will terminate the application
        // and invoke Watson. You can overwrite the definition of
        // _CRT_SECURE_INVALID_PARAMETER if you need.
        //
        // _CRT_SECURE_INVALID_PARAMETER is used in the Standard C++ Libraries
        // and the SafeInt library.
        

    #line 387 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 388 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"



//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Deprecation and Warnings
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+




    


#line 405 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"



#line 409 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"


    


        


    #line 418 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 419 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"



//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Managed CRT Support
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

    






        
    #line 437 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 438 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"


    


        
    #line 445 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 446 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"



#line 450 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"



//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// SecureCRT Configuration
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+





#line 464 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"















#line 480 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"





    
#line 487 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"



#line 491 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"


    

#line 496 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 497 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"


    


        


            
        #line 507 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"
    #line 508 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 509 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"



#line 513 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"





#line 519 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"


    


        



    #line 529 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 530 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"


    
        
    



#line 539 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"

    
        // _CRT_SECURE_CPP_OVERLOAD_STANDARD_NAMES_COUNT is ignored if
        // _CRT_SECURE_CPP_OVERLOAD_STANDARD_NAMES is set to 0
        
    



#line 549 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"

    
        
              
        

#line 556 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"
    



#line 561 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"

    
        
    



#line 569 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"

    
        
    



#line 577 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 578 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"


    
#line 582 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"



//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// Basic Types
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
typedef int                           errno_t;
typedef unsigned short                wint_t;
typedef unsigned short                wctype_t;
typedef long                          __time32_t;
typedef __int64                       __time64_t;

typedef struct __crt_locale_data_public
{
      unsigned short const* _locale_pctype;
      int _locale_mb_cur_max;
               unsigned int _locale_lc_codepage;
} __crt_locale_data_public;

typedef struct __crt_locale_pointers
{
    struct __crt_locale_data*    locinfo;
    struct __crt_multibyte_data* mbcinfo;
} __crt_locale_pointers;

typedef __crt_locale_pointers* _locale_t;

typedef struct _Mbstatet
{ // state of a multibyte translation
    unsigned long _Wchar;
    unsigned short _Byte, _State;
} _Mbstatet;

typedef _Mbstatet mbstate_t;



#line 622 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"



#line 626 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"


    


        typedef __time64_t time_t;
    #line 633 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 634 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"

// Indicate that these common types are defined

    
#line 639 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"


    typedef size_t rsize_t;
#line 643 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"




//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// C++ Secure Overload Generation Macros
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

    















































































































































#line 798 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"

        
        
        
        
        
        
        
        
        
        
        
        

    #line 813 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 814 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"






































































//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
//
// C++ Standard Overload Generation Macros
//
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

    













































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































#line 1865 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"

        
        
        
        

        

            


            


            


            


            


            


            


            


            



            



            


            


            


            


            


            


            


            


            


            


            



            



            



            


            



            




            

            




            

            




            

            




            

            




            

            




            

            




            

            




            

        











































#line 2055 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"
    #line 2056 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"
#line 2057 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\corecrt.h"

__pragma(pack(pop))


#pragma warning(pop) 
#line 13 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\stddef.h"

#pragma warning(push)
#pragma warning(disable: 4324  4514 4574 4710 4793 4820 4995 4996 28719 28726 28727 )


__pragma(pack(push, 8))
















     int* __cdecl _errno(void);
    

     errno_t __cdecl _set_errno(  int _Value);
     errno_t __cdecl _get_errno(  int* _Value);

#line 42 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\stddef.h"




    


        
    #line 51 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\stddef.h"


#line 54 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\stddef.h"

 extern unsigned long  __cdecl __threadid(void);

 extern uintptr_t __cdecl __threadhandle(void);



__pragma(pack(pop))

#pragma warning(pop) 
#line 65 "C:\\Program Files (x86)\\Windows Kits\\10\\include\\10.0.19041.0\\ucrt\\stddef.h"
#line 363 "C:\\OpenCL\\include\\CL/cl_platform.h"

/* Mirror types to GL types. Mirror types allow us to avoid deciding which 87s to load based on whether we are using GL or GLES here. */
typedef unsigned int cl_GLuint;
typedef int          cl_GLint;
typedef unsigned int cl_GLenum;

/*
 * Vector types
 *
 *  Note:   OpenCL requires that all types be naturally aligned.
 *          This means that vector types must be naturally aligned.
 *          For example, a vector of four floats must be aligned to
 *          a 16 byte boundary (calculated as 4 * the natural 4-byte
 *          alignment of the float).  The alignment qualifiers here
 *          will only function properly if your compiler supports them
 *          and if you don't actively work to defeat them.  For example,
 *          in order for a cl_float4 to be 16 byte aligned in a struct,
 *          the start of the struct must itself be 16-byte aligned.
 *
 *          Maintaining proper alignment is the user's responsibility.
 */

/* Define basic vector types */


















#line 405 "C:\\OpenCL\\include\\CL/cl_platform.h"













#line 419 "C:\\OpenCL\\include\\CL/cl_platform.h"





































#line 457 "C:\\OpenCL\\include\\CL/cl_platform.h"

































#line 491 "C:\\OpenCL\\include\\CL/cl_platform.h"
















#line 508 "C:\\OpenCL\\include\\CL/cl_platform.h"

/* Define capabilities for anonymous struct members. */



#line 514 "C:\\OpenCL\\include\\CL/cl_platform.h"











#line 526 "C:\\OpenCL\\include\\CL/cl_platform.h"


   /* Disable warning C4201: nonstandard extension used : nameless struct/union */
    #pragma warning( push )
    #pragma warning( disable : 4201 )
#line 532 "C:\\OpenCL\\include\\CL/cl_platform.h"

/* Define alignment keys */


#line 537 "C:\\OpenCL\\include\\CL/cl_platform.h"
    /* Alignment keys neutered on windows because MSVC can't swallow function arguments with alignment requirements     */
    /* http://msdn.microsoft.com/en-us/library/373ak2y1%28VS.71%29.aspx                                                 */
    /* #include <crtdefs.h>                                                                                             */
    /* #define CL_ALIGNED(_x)          _CRT_ALIGN(_x)                                                                   */
    



#line 546 "C:\\OpenCL\\include\\CL/cl_platform.h"

/* Indicate whether .xyzw, .s0123 and .hi.lo are supported */

    /* .xyzw and .s0123...{f|F} are supported */
    
    /* .hi and .lo are supported */
    
#line 554 "C:\\OpenCL\\include\\CL/cl_platform.h"

/* Define cl_vector types */

/* ---- cl_charn ---- */
typedef union
{
    cl_char   s[2];

    struct{ cl_char  x, y; };
    struct{ cl_char  s0, s1; };
    struct{ cl_char  lo, hi; };
#line 566 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 569 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_char2;

typedef union
{
    cl_char   s[4];

    struct{ cl_char  x, y, z, w; };
    struct{ cl_char  s0, s1, s2, s3; };
    struct{ cl_char2 lo, hi; };
#line 579 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 582 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 585 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_char4;

/* cl_char3 is identical in size, alignment and behavior to cl_char4. See section 6.1.5. */
typedef  cl_char4  cl_char3;

typedef union
{
    cl_char    s[8];

    struct{ cl_char  x, y, z, w; };
    struct{ cl_char  s0, s1, s2, s3, s4, s5, s6, s7; };
    struct{ cl_char4 lo, hi; };
#line 598 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 601 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 604 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 607 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_char8;

typedef union
{
    cl_char   s[16];

    struct{ cl_char  x, y, z, w, __spacer4, __spacer5, __spacer6, __spacer7, __spacer8, __spacer9, sa, sb, sc, sd, se, sf; };
    struct{ cl_char  s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, sA, sB, sC, sD, sE, sF; };
    struct{ cl_char8 lo, hi; };
#line 617 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 620 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 623 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 626 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 629 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_char16;


/* ---- cl_ucharn ---- */
typedef union
{
    cl_uchar   s[2];

    struct{ cl_uchar  x, y; };
    struct{ cl_uchar  s0, s1; };
    struct{ cl_uchar  lo, hi; };
#line 641 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 644 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_uchar2;

typedef union
{
    cl_uchar   s[4];

    struct{ cl_uchar  x, y, z, w; };
    struct{ cl_uchar  s0, s1, s2, s3; };
    struct{ cl_uchar2 lo, hi; };
#line 654 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 657 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 660 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_uchar4;

/* cl_uchar3 is identical in size, alignment and behavior to cl_uchar4. See section 6.1.5. */
typedef  cl_uchar4  cl_uchar3;

typedef union
{
    cl_uchar    s[8];

    struct{ cl_uchar  x, y, z, w; };
    struct{ cl_uchar  s0, s1, s2, s3, s4, s5, s6, s7; };
    struct{ cl_uchar4 lo, hi; };
#line 673 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 676 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 679 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 682 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_uchar8;

typedef union
{
    cl_uchar   s[16];

    struct{ cl_uchar  x, y, z, w, __spacer4, __spacer5, __spacer6, __spacer7, __spacer8, __spacer9, sa, sb, sc, sd, se, sf; };
    struct{ cl_uchar  s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, sA, sB, sC, sD, sE, sF; };
    struct{ cl_uchar8 lo, hi; };
#line 692 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 695 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 698 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 701 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 704 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_uchar16;


/* ---- cl_shortn ---- */
typedef union
{
    cl_short   s[2];

    struct{ cl_short  x, y; };
    struct{ cl_short  s0, s1; };
    struct{ cl_short  lo, hi; };
#line 716 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 719 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_short2;

typedef union
{
    cl_short   s[4];

    struct{ cl_short  x, y, z, w; };
    struct{ cl_short  s0, s1, s2, s3; };
    struct{ cl_short2 lo, hi; };
#line 729 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 732 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 735 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_short4;

/* cl_short3 is identical in size, alignment and behavior to cl_short4. See section 6.1.5. */
typedef  cl_short4  cl_short3;

typedef union
{
    cl_short    s[8];

    struct{ cl_short  x, y, z, w; };
    struct{ cl_short  s0, s1, s2, s3, s4, s5, s6, s7; };
    struct{ cl_short4 lo, hi; };
#line 748 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 751 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 754 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 757 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_short8;

typedef union
{
    cl_short   s[16];

    struct{ cl_short  x, y, z, w, __spacer4, __spacer5, __spacer6, __spacer7, __spacer8, __spacer9, sa, sb, sc, sd, se, sf; };
    struct{ cl_short  s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, sA, sB, sC, sD, sE, sF; };
    struct{ cl_short8 lo, hi; };
#line 767 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 770 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 773 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 776 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 779 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_short16;


/* ---- cl_ushortn ---- */
typedef union
{
    cl_ushort   s[2];

    struct{ cl_ushort  x, y; };
    struct{ cl_ushort  s0, s1; };
    struct{ cl_ushort  lo, hi; };
#line 791 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 794 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_ushort2;

typedef union
{
    cl_ushort   s[4];

    struct{ cl_ushort  x, y, z, w; };
    struct{ cl_ushort  s0, s1, s2, s3; };
    struct{ cl_ushort2 lo, hi; };
#line 804 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 807 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 810 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_ushort4;

/* cl_ushort3 is identical in size, alignment and behavior to cl_ushort4. See section 6.1.5. */
typedef  cl_ushort4  cl_ushort3;

typedef union
{
    cl_ushort    s[8];

    struct{ cl_ushort  x, y, z, w; };
    struct{ cl_ushort  s0, s1, s2, s3, s4, s5, s6, s7; };
    struct{ cl_ushort4 lo, hi; };
#line 823 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 826 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 829 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 832 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_ushort8;

typedef union
{
    cl_ushort   s[16];

    struct{ cl_ushort  x, y, z, w, __spacer4, __spacer5, __spacer6, __spacer7, __spacer8, __spacer9, sa, sb, sc, sd, se, sf; };
    struct{ cl_ushort  s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, sA, sB, sC, sD, sE, sF; };
    struct{ cl_ushort8 lo, hi; };
#line 842 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 845 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 848 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 851 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 854 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_ushort16;


/* ---- cl_halfn ---- */
typedef union
{
    cl_half   s[2];

     struct{ cl_half  x, y; };
     struct{ cl_half  s0, s1; };
     struct{ cl_half  lo, hi; };
#line 866 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 869 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_half2;

typedef union
{
    cl_half   s[4];

     struct{ cl_half  x, y, z, w; };
     struct{ cl_half  s0, s1, s2, s3; };
     struct{ cl_half2 lo, hi; };
#line 879 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 882 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 885 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_half4;

/* cl_half3 is identical in size, alignment and behavior to cl_half4. See section 6.1.5. */
typedef  cl_half4  cl_half3;

typedef union
{
    cl_half    s[8];

     struct{ cl_half  x, y, z, w; };
     struct{ cl_half  s0, s1, s2, s3, s4, s5, s6, s7; };
     struct{ cl_half4 lo, hi; };
#line 898 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 901 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 904 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 907 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_half8;

typedef union
{
    cl_half   s[16];

     struct{ cl_half  x, y, z, w, __spacer4, __spacer5, __spacer6, __spacer7, __spacer8, __spacer9, sa, sb, sc, sd, se, sf; };
     struct{ cl_half  s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, sA, sB, sC, sD, sE, sF; };
     struct{ cl_half8 lo, hi; };
#line 917 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 920 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 923 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 926 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 929 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_half16;

/* ---- cl_intn ---- */
typedef union
{
    cl_int   s[2];

    struct{ cl_int  x, y; };
    struct{ cl_int  s0, s1; };
    struct{ cl_int  lo, hi; };
#line 940 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 943 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_int2;

typedef union
{
    cl_int   s[4];

    struct{ cl_int  x, y, z, w; };
    struct{ cl_int  s0, s1, s2, s3; };
    struct{ cl_int2 lo, hi; };
#line 953 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 956 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 959 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_int4;

/* cl_int3 is identical in size, alignment and behavior to cl_int4. See section 6.1.5. */
typedef  cl_int4  cl_int3;

typedef union
{
    cl_int    s[8];

    struct{ cl_int  x, y, z, w; };
    struct{ cl_int  s0, s1, s2, s3, s4, s5, s6, s7; };
    struct{ cl_int4 lo, hi; };
#line 972 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 975 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 978 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 981 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_int8;

typedef union
{
    cl_int   s[16];

    struct{ cl_int  x, y, z, w, __spacer4, __spacer5, __spacer6, __spacer7, __spacer8, __spacer9, sa, sb, sc, sd, se, sf; };
    struct{ cl_int  s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, sA, sB, sC, sD, sE, sF; };
    struct{ cl_int8 lo, hi; };
#line 991 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 994 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 997 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1000 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1003 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_int16;


/* ---- cl_uintn ---- */
typedef union
{
    cl_uint   s[2];

    struct{ cl_uint  x, y; };
    struct{ cl_uint  s0, s1; };
    struct{ cl_uint  lo, hi; };
#line 1015 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1018 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_uint2;

typedef union
{
    cl_uint   s[4];

    struct{ cl_uint  x, y, z, w; };
    struct{ cl_uint  s0, s1, s2, s3; };
    struct{ cl_uint2 lo, hi; };
#line 1028 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1031 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1034 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_uint4;

/* cl_uint3 is identical in size, alignment and behavior to cl_uint4. See section 6.1.5. */
typedef  cl_uint4  cl_uint3;

typedef union
{
    cl_uint    s[8];

    struct{ cl_uint  x, y, z, w; };
    struct{ cl_uint  s0, s1, s2, s3, s4, s5, s6, s7; };
    struct{ cl_uint4 lo, hi; };
#line 1047 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1050 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1053 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1056 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_uint8;

typedef union
{
    cl_uint   s[16];

    struct{ cl_uint  x, y, z, w, __spacer4, __spacer5, __spacer6, __spacer7, __spacer8, __spacer9, sa, sb, sc, sd, se, sf; };
    struct{ cl_uint  s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, sA, sB, sC, sD, sE, sF; };
    struct{ cl_uint8 lo, hi; };
#line 1066 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1069 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1072 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1075 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1078 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_uint16;

/* ---- cl_longn ---- */
typedef union
{
    cl_long   s[2];

    struct{ cl_long  x, y; };
    struct{ cl_long  s0, s1; };
    struct{ cl_long  lo, hi; };
#line 1089 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1092 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_long2;

typedef union
{
    cl_long   s[4];

    struct{ cl_long  x, y, z, w; };
    struct{ cl_long  s0, s1, s2, s3; };
    struct{ cl_long2 lo, hi; };
#line 1102 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1105 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1108 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_long4;

/* cl_long3 is identical in size, alignment and behavior to cl_long4. See section 6.1.5. */
typedef  cl_long4  cl_long3;

typedef union
{
    cl_long    s[8];

    struct{ cl_long  x, y, z, w; };
    struct{ cl_long  s0, s1, s2, s3, s4, s5, s6, s7; };
    struct{ cl_long4 lo, hi; };
#line 1121 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1124 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1127 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1130 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_long8;

typedef union
{
    cl_long   s[16];

    struct{ cl_long  x, y, z, w, __spacer4, __spacer5, __spacer6, __spacer7, __spacer8, __spacer9, sa, sb, sc, sd, se, sf; };
    struct{ cl_long  s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, sA, sB, sC, sD, sE, sF; };
    struct{ cl_long8 lo, hi; };
#line 1140 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1143 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1146 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1149 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1152 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_long16;


/* ---- cl_ulongn ---- */
typedef union
{
    cl_ulong   s[2];

    struct{ cl_ulong  x, y; };
    struct{ cl_ulong  s0, s1; };
    struct{ cl_ulong  lo, hi; };
#line 1164 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1167 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_ulong2;

typedef union
{
    cl_ulong   s[4];

    struct{ cl_ulong  x, y, z, w; };
    struct{ cl_ulong  s0, s1, s2, s3; };
    struct{ cl_ulong2 lo, hi; };
#line 1177 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1180 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1183 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_ulong4;

/* cl_ulong3 is identical in size, alignment and behavior to cl_ulong4. See section 6.1.5. */
typedef  cl_ulong4  cl_ulong3;

typedef union
{
    cl_ulong    s[8];

    struct{ cl_ulong  x, y, z, w; };
    struct{ cl_ulong  s0, s1, s2, s3, s4, s5, s6, s7; };
    struct{ cl_ulong4 lo, hi; };
#line 1196 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1199 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1202 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1205 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_ulong8;

typedef union
{
    cl_ulong   s[16];

    struct{ cl_ulong  x, y, z, w, __spacer4, __spacer5, __spacer6, __spacer7, __spacer8, __spacer9, sa, sb, sc, sd, se, sf; };
    struct{ cl_ulong  s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, sA, sB, sC, sD, sE, sF; };
    struct{ cl_ulong8 lo, hi; };
#line 1215 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1218 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1221 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1224 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1227 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_ulong16;


/* --- cl_floatn ---- */

typedef union
{
    cl_float   s[2];

    struct{ cl_float  x, y; };
    struct{ cl_float  s0, s1; };
    struct{ cl_float  lo, hi; };
#line 1240 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1243 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_float2;

typedef union
{
    cl_float   s[4];

    struct{ cl_float   x, y, z, w; };
    struct{ cl_float   s0, s1, s2, s3; };
    struct{ cl_float2  lo, hi; };
#line 1253 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1256 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1259 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_float4;

/* cl_float3 is identical in size, alignment and behavior to cl_float4. See section 6.1.5. */
typedef  cl_float4  cl_float3;

typedef union
{
    cl_float    s[8];

    struct{ cl_float   x, y, z, w; };
    struct{ cl_float   s0, s1, s2, s3, s4, s5, s6, s7; };
    struct{ cl_float4  lo, hi; };
#line 1272 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1275 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1278 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1281 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_float8;

typedef union
{
    cl_float   s[16];

    struct{ cl_float  x, y, z, w, __spacer4, __spacer5, __spacer6, __spacer7, __spacer8, __spacer9, sa, sb, sc, sd, se, sf; };
    struct{ cl_float  s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, sA, sB, sC, sD, sE, sF; };
    struct{ cl_float8 lo, hi; };
#line 1291 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1294 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1297 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1300 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1303 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_float16;

/* --- cl_doublen ---- */

typedef union
{
    cl_double   s[2];

    struct{ cl_double  x, y; };
    struct{ cl_double s0, s1; };
    struct{ cl_double lo, hi; };
#line 1315 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1318 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_double2;

typedef union
{
    cl_double   s[4];

    struct{ cl_double  x, y, z, w; };
    struct{ cl_double  s0, s1, s2, s3; };
    struct{ cl_double2 lo, hi; };
#line 1328 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1331 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1334 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_double4;

/* cl_double3 is identical in size, alignment and behavior to cl_double4. See section 6.1.5. */
typedef  cl_double4  cl_double3;

typedef union
{
    cl_double    s[8];

    struct{ cl_double  x, y, z, w; };
    struct{ cl_double  s0, s1, s2, s3, s4, s5, s6, s7; };
    struct{ cl_double4 lo, hi; };
#line 1347 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1350 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1353 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1356 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_double8;

typedef union
{
    cl_double   s[16];

    struct{ cl_double  x, y, z, w, __spacer4, __spacer5, __spacer6, __spacer7, __spacer8, __spacer9, sa, sb, sc, sd, se, sf; };
    struct{ cl_double  s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, sA, sB, sC, sD, sE, sF; };
    struct{ cl_double8 lo, hi; };
#line 1366 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1369 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1372 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1375 "C:\\OpenCL\\include\\CL/cl_platform.h"


#line 1378 "C:\\OpenCL\\include\\CL/cl_platform.h"
}cl_double16;

/* Macro to facilitate debugging
 * Usage:
 *   Place CL_PROGRAM_STRING_DEBUG_INFO on the line before the first line of your source.
 *   The first line ends with:   CL_PROGRAM_STRING_DEBUG_INFO \"
 *   Each line thereafter of OpenCL C source must end with: \n\
 *   The last line ends in ";
 *
 *   Example:
 *
 *   const char *my_program = CL_PROGRAM_STRING_DEBUG_INFO "\
 *   kernel void foo( int a, float * b )             \n\
 *   {                                               \n\
 *      // my comment                                \n\
 *      *b[ get_global_id(0)] = a;                   \n\
 *   }                                               \n\
 *   ";
 *
 * This should correctly set up the line, (column) and file information for your source
 * string so you can do source level debugging.
 */









    #pragma warning( pop )
#line 1411 "C:\\OpenCL\\include\\CL/cl_platform.h"

#line 1413 "C:\\OpenCL\\include\\CL/cl_platform.h"
#line 22 "C:\\OpenCL\\include\\CL/cl.h"





/******************************************************************************/

typedef struct _cl_platform_id *    cl_platform_id;
typedef struct _cl_device_id *      cl_device_id;
typedef struct _cl_context *        cl_context;
typedef struct _cl_command_queue *  cl_command_queue;
typedef struct _cl_mem *            cl_mem;
typedef struct _cl_program *        cl_program;
typedef struct _cl_kernel *         cl_kernel;
typedef struct _cl_event *          cl_event;
typedef struct _cl_sampler *        cl_sampler;

typedef cl_uint             cl_bool;                     /* WARNING!  Unlike cl_ types in cl_platform.h, cl_bool is not guaranteed to be the same size as the bool in kernels. */
typedef cl_ulong            cl_bitfield;
typedef cl_ulong            cl_properties;
typedef cl_bitfield         cl_device_type;
typedef cl_uint             cl_platform_info;
typedef cl_uint             cl_device_info;
typedef cl_bitfield         cl_device_fp_config;
typedef cl_uint             cl_device_mem_cache_type;
typedef cl_uint             cl_device_local_mem_type;
typedef cl_bitfield         cl_device_exec_capabilities;

typedef cl_bitfield         cl_device_svm_capabilities;
#line 52 "C:\\OpenCL\\include\\CL/cl.h"
typedef cl_bitfield         cl_command_queue_properties;

typedef intptr_t            cl_device_partition_property;
typedef cl_bitfield         cl_device_affinity_domain;
#line 57 "C:\\OpenCL\\include\\CL/cl.h"

typedef intptr_t            cl_context_properties;
typedef cl_uint             cl_context_info;

typedef cl_properties       cl_queue_properties;
#line 63 "C:\\OpenCL\\include\\CL/cl.h"
typedef cl_uint             cl_command_queue_info;
typedef cl_uint             cl_channel_order;
typedef cl_uint             cl_channel_type;
typedef cl_bitfield         cl_mem_flags;

typedef cl_bitfield         cl_svm_mem_flags;
#line 70 "C:\\OpenCL\\include\\CL/cl.h"
typedef cl_uint             cl_mem_object_type;
typedef cl_uint             cl_mem_info;

typedef cl_bitfield         cl_mem_migration_flags;
#line 75 "C:\\OpenCL\\include\\CL/cl.h"
typedef cl_uint             cl_image_info;

typedef cl_uint             cl_buffer_create_type;
#line 79 "C:\\OpenCL\\include\\CL/cl.h"
typedef cl_uint             cl_addressing_mode;
typedef cl_uint             cl_filter_mode;
typedef cl_uint             cl_sampler_info;
typedef cl_bitfield         cl_map_flags;

typedef intptr_t            cl_pipe_properties;
typedef cl_uint             cl_pipe_info;
#line 87 "C:\\OpenCL\\include\\CL/cl.h"
typedef cl_uint             cl_program_info;
typedef cl_uint             cl_program_build_info;

typedef cl_uint             cl_program_binary_type;
#line 92 "C:\\OpenCL\\include\\CL/cl.h"
typedef cl_int              cl_build_status;
typedef cl_uint             cl_kernel_info;

typedef cl_uint             cl_kernel_arg_info;
typedef cl_uint             cl_kernel_arg_address_qualifier;
typedef cl_uint             cl_kernel_arg_access_qualifier;
typedef cl_bitfield         cl_kernel_arg_type_qualifier;
#line 100 "C:\\OpenCL\\include\\CL/cl.h"
typedef cl_uint             cl_kernel_work_group_info;

typedef cl_uint             cl_kernel_sub_group_info;
#line 104 "C:\\OpenCL\\include\\CL/cl.h"
typedef cl_uint             cl_event_info;
typedef cl_uint             cl_command_type;
typedef cl_uint             cl_profiling_info;

typedef cl_properties       cl_sampler_properties;
typedef cl_uint             cl_kernel_exec_info;
#line 111 "C:\\OpenCL\\include\\CL/cl.h"

typedef cl_bitfield         cl_device_atomic_capabilities;
typedef cl_bitfield         cl_device_device_enqueue_capabilities;
typedef cl_uint             cl_khronos_vendor_id;
typedef cl_properties       cl_mem_properties;
typedef cl_uint             cl_version;
#line 118 "C:\\OpenCL\\include\\CL/cl.h"

typedef struct _cl_image_format {
    cl_channel_order        image_channel_order;
    cl_channel_type         image_channel_data_type;
} cl_image_format;



typedef struct _cl_image_desc {
    cl_mem_object_type      image_type;
    size_t                  image_width;
    size_t                  image_height;
    size_t                  image_depth;
    size_t                  image_array_size;
    size_t                  image_row_pitch;
    size_t                  image_slice_pitch;
    cl_uint                 num_mip_levels;
    cl_uint                 num_samples;



#line 140 "C:\\OpenCL\\include\\CL/cl.h"

#pragma warning( push )
#pragma warning( disable : 4201 )   
#line 144 "C:\\OpenCL\\include\\CL/cl.h"






#line 151 "C:\\OpenCL\\include\\CL/cl.h"
    union {
#line 153 "C:\\OpenCL\\include\\CL/cl.h"
#line 154 "C:\\OpenCL\\include\\CL/cl.h"
      cl_mem                  buffer;



#line 159 "C:\\OpenCL\\include\\CL/cl.h"
      cl_mem                  mem_object;
    };
#line 162 "C:\\OpenCL\\include\\CL/cl.h"

#pragma warning( pop )
#line 165 "C:\\OpenCL\\include\\CL/cl.h"



#line 169 "C:\\OpenCL\\include\\CL/cl.h"
} cl_image_desc;

#line 172 "C:\\OpenCL\\include\\CL/cl.h"



typedef struct _cl_buffer_region {
    size_t                  origin;
    size_t                  size;
} cl_buffer_region;

#line 181 "C:\\OpenCL\\include\\CL/cl.h"





typedef struct _cl_name_version {
    cl_version              version;
    char                    name[64];
} cl_name_version;

#line 192 "C:\\OpenCL\\include\\CL/cl.h"

/******************************************************************************/

/* Error Codes */
















#line 213 "C:\\OpenCL\\include\\CL/cl.h"






#line 220 "C:\\OpenCL\\include\\CL/cl.h"





































#line 258 "C:\\OpenCL\\include\\CL/cl.h"





#line 264 "C:\\OpenCL\\include\\CL/cl.h"



#line 268 "C:\\OpenCL\\include\\CL/cl.h"



#line 272 "C:\\OpenCL\\include\\CL/cl.h"


/* cl_bool */





#line 281 "C:\\OpenCL\\include\\CL/cl.h"

/* cl_platform_info */







#line 291 "C:\\OpenCL\\include\\CL/cl.h"



#line 295 "C:\\OpenCL\\include\\CL/cl.h"

/* cl_device_type - bitfield */






#line 304 "C:\\OpenCL\\include\\CL/cl.h"


/* cl_device_info */













































#line 353 "C:\\OpenCL\\include\\CL/cl.h"









#line 363 "C:\\OpenCL\\include\\CL/cl.h"
/* 0x1033 reserved for CL_DEVICE_HALF_FP_CONFIG which is already defined in "cl_ext.h" */











#line 376 "C:\\OpenCL\\include\\CL/cl.h"













#line 390 "C:\\OpenCL\\include\\CL/cl.h"


















#line 409 "C:\\OpenCL\\include\\CL/cl.h"




#line 414 "C:\\OpenCL\\include\\CL/cl.h"












/* 0x106A to 0x106E - Reserved for upcoming KHR extension */




#line 432 "C:\\OpenCL\\include\\CL/cl.h"

/* cl_device_fp_config - bitfield */








#line 443 "C:\\OpenCL\\include\\CL/cl.h"


#line 446 "C:\\OpenCL\\include\\CL/cl.h"

/* cl_device_mem_cache_type */




/* cl_device_local_mem_type */



/* cl_device_exec_capabilities - bitfield */



/* cl_command_queue_properties - bitfield */





#line 467 "C:\\OpenCL\\include\\CL/cl.h"

/* cl_context_info */





#line 475 "C:\\OpenCL\\include\\CL/cl.h"

/* cl_context_properties */



#line 481 "C:\\OpenCL\\include\\CL/cl.h"



/* cl_device_partition_property */





#line 491 "C:\\OpenCL\\include\\CL/cl.h"



/* cl_device_affinity_domain */







#line 503 "C:\\OpenCL\\include\\CL/cl.h"



/* cl_device_svm_capabilities */





#line 513 "C:\\OpenCL\\include\\CL/cl.h"

/* cl_command_queue_info */






#line 522 "C:\\OpenCL\\include\\CL/cl.h"


#line 525 "C:\\OpenCL\\include\\CL/cl.h"


#line 528 "C:\\OpenCL\\include\\CL/cl.h"

/* cl_mem_flags and cl_svm_mem_flags - bitfield */






/* reserved                                         (1 << 6)    */




#line 542 "C:\\OpenCL\\include\\CL/cl.h"




#line 547 "C:\\OpenCL\\include\\CL/cl.h"



/* cl_mem_migration_flags - bitfield */



#line 555 "C:\\OpenCL\\include\\CL/cl.h"

/* cl_channel_order */














#line 572 "C:\\OpenCL\\include\\CL/cl.h"



#line 576 "C:\\OpenCL\\include\\CL/cl.h"






#line 583 "C:\\OpenCL\\include\\CL/cl.h"

/* cl_channel_type */

















#line 603 "C:\\OpenCL\\include\\CL/cl.h"


#line 606 "C:\\OpenCL\\include\\CL/cl.h"

/* cl_mem_object_type */








#line 617 "C:\\OpenCL\\include\\CL/cl.h"


#line 620 "C:\\OpenCL\\include\\CL/cl.h"

/* cl_mem_info */










#line 633 "C:\\OpenCL\\include\\CL/cl.h"


#line 636 "C:\\OpenCL\\include\\CL/cl.h"


#line 639 "C:\\OpenCL\\include\\CL/cl.h"

/* cl_image_info */












#line 654 "C:\\OpenCL\\include\\CL/cl.h"


/* cl_pipe_info */



#line 661 "C:\\OpenCL\\include\\CL/cl.h"


#line 664 "C:\\OpenCL\\include\\CL/cl.h"

/* cl_addressing_mode */






#line 673 "C:\\OpenCL\\include\\CL/cl.h"

/* cl_filter_mode */



/* cl_sampler_info */






/* These enumerants are for the cl_khr_mipmap_image extension.
   They have since been added to cl_ext.h with an appropriate
   KHR suffix, but are left here for backwards compatibility. */



#line 692 "C:\\OpenCL\\include\\CL/cl.h"


#line 695 "C:\\OpenCL\\include\\CL/cl.h"

/* cl_map_flags - bitfield */




#line 702 "C:\\OpenCL\\include\\CL/cl.h"

/* cl_program_info */










#line 715 "C:\\OpenCL\\include\\CL/cl.h"


#line 718 "C:\\OpenCL\\include\\CL/cl.h"



#line 722 "C:\\OpenCL\\include\\CL/cl.h"

/* cl_program_build_info */





#line 730 "C:\\OpenCL\\include\\CL/cl.h"


#line 733 "C:\\OpenCL\\include\\CL/cl.h"



/* cl_program_binary_type */





#line 743 "C:\\OpenCL\\include\\CL/cl.h"

/* cl_build_status */





/* cl_kernel_info */







#line 759 "C:\\OpenCL\\include\\CL/cl.h"



/* cl_kernel_arg_info */






#line 770 "C:\\OpenCL\\include\\CL/cl.h"



/* cl_kernel_arg_address_qualifier */





#line 780 "C:\\OpenCL\\include\\CL/cl.h"



/* cl_kernel_arg_access_qualifier */





#line 790 "C:\\OpenCL\\include\\CL/cl.h"



/* cl_kernel_arg_type_qualifier */






#line 801 "C:\\OpenCL\\include\\CL/cl.h"

#line 803 "C:\\OpenCL\\include\\CL/cl.h"

/* cl_kernel_work_group_info */







#line 813 "C:\\OpenCL\\include\\CL/cl.h"



/* cl_kernel_sub_group_info */






#line 824 "C:\\OpenCL\\include\\CL/cl.h"



/* cl_kernel_exec_info */



#line 832 "C:\\OpenCL\\include\\CL/cl.h"

/* cl_event_info */






#line 841 "C:\\OpenCL\\include\\CL/cl.h"

/* cl_command_type */






















#line 866 "C:\\OpenCL\\include\\CL/cl.h"





#line 872 "C:\\OpenCL\\include\\CL/cl.h"






#line 879 "C:\\OpenCL\\include\\CL/cl.h"


#line 882 "C:\\OpenCL\\include\\CL/cl.h"

/* command execution status */





/* cl_buffer_create_type */


#line 893 "C:\\OpenCL\\include\\CL/cl.h"

/* cl_profiling_info */






#line 902 "C:\\OpenCL\\include\\CL/cl.h"

/* cl_device_atomic_capabilities - bitfield */








#line 913 "C:\\OpenCL\\include\\CL/cl.h"

/* cl_device_device_enqueue_capabilities - bitfield */



#line 919 "C:\\OpenCL\\include\\CL/cl.h"

/* cl_khronos_vendor_id */




/* cl_version */






















#line 949 "C:\\OpenCL\\include\\CL/cl.h"

/********************************************************************************************************/

/* Platform API */
extern  cl_int __stdcall
clGetPlatformIDs(cl_uint          num_entries,
                 cl_platform_id * platforms,
                 cl_uint *        num_platforms) ;

extern  cl_int __stdcall
clGetPlatformInfo(cl_platform_id   platform,
                  cl_platform_info param_name,
                  size_t           param_value_size,
                  void *           param_value,
                  size_t *         param_value_size_ret) ;

/* Device APIs */
extern  cl_int __stdcall
clGetDeviceIDs(cl_platform_id   platform,
               cl_device_type   device_type,
               cl_uint          num_entries,
               cl_device_id *   devices,
               cl_uint *        num_devices) ;

extern  cl_int __stdcall
clGetDeviceInfo(cl_device_id    device,
                cl_device_info  param_name,
                size_t          param_value_size,
                void *          param_value,
                size_t *        param_value_size_ret) ;



extern  cl_int __stdcall
clCreateSubDevices(cl_device_id                         in_device,
                   const cl_device_partition_property * properties,
                   cl_uint                              num_devices,
                   cl_device_id *                       out_devices,
                   cl_uint *                            num_devices_ret) ;

extern  cl_int __stdcall
clRetainDevice(cl_device_id device) ;

extern  cl_int __stdcall
clReleaseDevice(cl_device_id device) ;

#line 996 "C:\\OpenCL\\include\\CL/cl.h"



extern  cl_int __stdcall
clSetDefaultDeviceCommandQueue(cl_context           context,
                               cl_device_id         device,
                               cl_command_queue     command_queue) ;

extern  cl_int __stdcall
clGetDeviceAndHostTimer(cl_device_id    device,
                        cl_ulong*       device_timestamp,
                        cl_ulong*       host_timestamp) ;

extern  cl_int __stdcall
clGetHostTimer(cl_device_id device,
               cl_ulong *   host_timestamp) ;

#line 1014 "C:\\OpenCL\\include\\CL/cl.h"

/* Context APIs */
extern  cl_context __stdcall
clCreateContext(const cl_context_properties * properties,
                cl_uint              num_devices,
                const cl_device_id * devices,
                void (__stdcall * pfn_notify)(const char * errinfo,
                                                const void * private_info,
                                                size_t       cb,
                                                void *       user_data),
                void *               user_data,
                cl_int *             errcode_ret) ;

extern  cl_context __stdcall
clCreateContextFromType(const cl_context_properties * properties,
                        cl_device_type      device_type,
                        void (__stdcall * pfn_notify)(const char * errinfo,
                                                        const void * private_info,
                                                        size_t       cb,
                                                        void *       user_data),
                        void *              user_data,
                        cl_int *            errcode_ret) ;

extern  cl_int __stdcall
clRetainContext(cl_context context) ;

extern  cl_int __stdcall
clReleaseContext(cl_context context) ;

extern  cl_int __stdcall
clGetContextInfo(cl_context         context,
                 cl_context_info    param_name,
                 size_t             param_value_size,
                 void *             param_value,
                 size_t *           param_value_size_ret) ;



extern  cl_int __stdcall
clSetContextDestructorCallback(cl_context         context,
                               void (__stdcall* pfn_notify)(cl_context context,
                                                              void* user_data),
                               void*              user_data) ;

#line 1059 "C:\\OpenCL\\include\\CL/cl.h"

/* Command Queue APIs */



extern  cl_command_queue __stdcall
clCreateCommandQueueWithProperties(cl_context               context,
                                   cl_device_id             device,
                                   const cl_queue_properties *    properties,
                                   cl_int *                 errcode_ret) ;

#line 1071 "C:\\OpenCL\\include\\CL/cl.h"

extern  cl_int __stdcall
clRetainCommandQueue(cl_command_queue command_queue) ;

extern  cl_int __stdcall
clReleaseCommandQueue(cl_command_queue command_queue) ;

extern  cl_int __stdcall
clGetCommandQueueInfo(cl_command_queue      command_queue,
                      cl_command_queue_info param_name,
                      size_t                param_value_size,
                      void *                param_value,
                      size_t *              param_value_size_ret) ;

/* Memory Object APIs */
extern  cl_mem __stdcall
clCreateBuffer(cl_context   context,
               cl_mem_flags flags,
               size_t       size,
               void *       host_ptr,
               cl_int *     errcode_ret) ;



extern  cl_mem __stdcall
clCreateSubBuffer(cl_mem                   buffer,
                  cl_mem_flags             flags,
                  cl_buffer_create_type    buffer_create_type,
                  const void *             buffer_create_info,
                  cl_int *                 errcode_ret) ;

#line 1103 "C:\\OpenCL\\include\\CL/cl.h"



extern  cl_mem __stdcall
clCreateImage(cl_context              context,
              cl_mem_flags            flags,
              const cl_image_format * image_format,
              const cl_image_desc *   image_desc,
              void *                  host_ptr,
              cl_int *                errcode_ret) ;

#line 1115 "C:\\OpenCL\\include\\CL/cl.h"



extern  cl_mem __stdcall
clCreatePipe(cl_context                 context,
             cl_mem_flags               flags,
             cl_uint                    pipe_packet_size,
             cl_uint                    pipe_max_packets,
             const cl_pipe_properties * properties,
             cl_int *                   errcode_ret) ;

#line 1127 "C:\\OpenCL\\include\\CL/cl.h"



extern  cl_mem __stdcall
clCreateBufferWithProperties(cl_context                context,
                             const cl_mem_properties * properties,
                             cl_mem_flags              flags,
                             size_t                    size,
                             void *                    host_ptr,
                             cl_int *                  errcode_ret) ;

extern  cl_mem __stdcall
clCreateImageWithProperties(cl_context                context,
                            const cl_mem_properties * properties,
                            cl_mem_flags              flags,
                            const cl_image_format *   image_format,
                            const cl_image_desc *     image_desc,
                            void *                    host_ptr,
                            cl_int *                  errcode_ret) ;

#line 1148 "C:\\OpenCL\\include\\CL/cl.h"

extern  cl_int __stdcall
clRetainMemObject(cl_mem memobj) ;

extern  cl_int __stdcall
clReleaseMemObject(cl_mem memobj) ;

extern  cl_int __stdcall
clGetSupportedImageFormats(cl_context           context,
                           cl_mem_flags         flags,
                           cl_mem_object_type   image_type,
                           cl_uint              num_entries,
                           cl_image_format *    image_formats,
                           cl_uint *            num_image_formats) ;

extern  cl_int __stdcall
clGetMemObjectInfo(cl_mem           memobj,
                   cl_mem_info      param_name,
                   size_t           param_value_size,
                   void *           param_value,
                   size_t *         param_value_size_ret) ;

extern  cl_int __stdcall
clGetImageInfo(cl_mem           image,
               cl_image_info    param_name,
               size_t           param_value_size,
               void *           param_value,
               size_t *         param_value_size_ret) ;



extern  cl_int __stdcall
clGetPipeInfo(cl_mem           pipe,
              cl_pipe_info     param_name,
              size_t           param_value_size,
              void *           param_value,
              size_t *         param_value_size_ret) ;

#line 1187 "C:\\OpenCL\\include\\CL/cl.h"



extern  cl_int __stdcall
clSetMemObjectDestructorCallback(cl_mem memobj,
                                 void (__stdcall * pfn_notify)(cl_mem memobj,
                                                                 void * user_data),
                                 void * user_data) ;

#line 1197 "C:\\OpenCL\\include\\CL/cl.h"

/* SVM Allocation APIs */



extern  void * __stdcall
clSVMAlloc(cl_context       context,
           cl_svm_mem_flags flags,
           size_t           size,
           cl_uint          alignment) ;

extern  void __stdcall
clSVMFree(cl_context        context,
          void *            svm_pointer) ;

#line 1213 "C:\\OpenCL\\include\\CL/cl.h"

/* Sampler APIs */



extern  cl_sampler __stdcall
clCreateSamplerWithProperties(cl_context                     context,
                              const cl_sampler_properties *  sampler_properties,
                              cl_int *                       errcode_ret) ;

#line 1224 "C:\\OpenCL\\include\\CL/cl.h"

extern  cl_int __stdcall
clRetainSampler(cl_sampler sampler) ;

extern  cl_int __stdcall
clReleaseSampler(cl_sampler sampler) ;

extern  cl_int __stdcall
clGetSamplerInfo(cl_sampler         sampler,
                 cl_sampler_info    param_name,
                 size_t             param_value_size,
                 void *             param_value,
                 size_t *           param_value_size_ret) ;

/* Program Object APIs */
extern  cl_program __stdcall
clCreateProgramWithSource(cl_context        context,
                          cl_uint           count,
                          const char **     strings,
                          const size_t *    lengths,
                          cl_int *          errcode_ret) ;

extern  cl_program __stdcall
clCreateProgramWithBinary(cl_context                     context,
                          cl_uint                        num_devices,
                          const cl_device_id *           device_list,
                          const size_t *                 lengths,
                          const unsigned char **         binaries,
                          cl_int *                       binary_status,
                          cl_int *                       errcode_ret) ;



extern  cl_program __stdcall
clCreateProgramWithBuiltInKernels(cl_context            context,
                                  cl_uint               num_devices,
                                  const cl_device_id *  device_list,
                                  const char *          kernel_names,
                                  cl_int *              errcode_ret) ;

#line 1265 "C:\\OpenCL\\include\\CL/cl.h"



extern  cl_program __stdcall
clCreateProgramWithIL(cl_context    context,
                     const void*    il,
                     size_t         length,
                     cl_int*        errcode_ret) ;

#line 1275 "C:\\OpenCL\\include\\CL/cl.h"

extern  cl_int __stdcall
clRetainProgram(cl_program program) ;

extern  cl_int __stdcall
clReleaseProgram(cl_program program) ;

extern  cl_int __stdcall
clBuildProgram(cl_program           program,
               cl_uint              num_devices,
               const cl_device_id * device_list,
               const char *         options,
               void (__stdcall *  pfn_notify)(cl_program program,
                                                void * user_data),
               void *               user_data) ;



extern  cl_int __stdcall
clCompileProgram(cl_program           program,
                 cl_uint              num_devices,
                 const cl_device_id * device_list,
                 const char *         options,
                 cl_uint              num_input_headers,
                 const cl_program *   input_headers,
                 const char **        header_include_names,
                 void (__stdcall *  pfn_notify)(cl_program program,
                                                  void * user_data),
                 void *               user_data) ;

extern  cl_program __stdcall
clLinkProgram(cl_context           context,
              cl_uint              num_devices,
              const cl_device_id * device_list,
              const char *         options,
              cl_uint              num_input_programs,
              const cl_program *   input_programs,
              void (__stdcall *  pfn_notify)(cl_program program,
                                               void * user_data),
              void *               user_data,
              cl_int *             errcode_ret) ;

#line 1318 "C:\\OpenCL\\include\\CL/cl.h"



extern   __declspec(deprecated) cl_int __stdcall
clSetProgramReleaseCallback(cl_program          program,
                            void (__stdcall * pfn_notify)(cl_program program,
                                                            void * user_data),
                            void *              user_data)  ;

extern  cl_int __stdcall
clSetProgramSpecializationConstant(cl_program  program,
                                   cl_uint     spec_id,
                                   size_t      spec_size,
                                   const void* spec_value) ;

#line 1334 "C:\\OpenCL\\include\\CL/cl.h"



extern  cl_int __stdcall
clUnloadPlatformCompiler(cl_platform_id platform) ;

#line 1341 "C:\\OpenCL\\include\\CL/cl.h"

extern  cl_int __stdcall
clGetProgramInfo(cl_program         program,
                 cl_program_info    param_name,
                 size_t             param_value_size,
                 void *             param_value,
                 size_t *           param_value_size_ret) ;

extern  cl_int __stdcall
clGetProgramBuildInfo(cl_program            program,
                      cl_device_id          device,
                      cl_program_build_info param_name,
                      size_t                param_value_size,
                      void *                param_value,
                      size_t *              param_value_size_ret) ;

/* Kernel Object APIs */
extern  cl_kernel __stdcall
clCreateKernel(cl_program      program,
               const char *    kernel_name,
               cl_int *        errcode_ret) ;

extern  cl_int __stdcall
clCreateKernelsInProgram(cl_program     program,
                         cl_uint        num_kernels,
                         cl_kernel *    kernels,
                         cl_uint *      num_kernels_ret) ;



extern  cl_kernel __stdcall
clCloneKernel(cl_kernel     source_kernel,
              cl_int*       errcode_ret) ;

#line 1376 "C:\\OpenCL\\include\\CL/cl.h"

extern  cl_int __stdcall
clRetainKernel(cl_kernel    kernel) ;

extern  cl_int __stdcall
clReleaseKernel(cl_kernel   kernel) ;

extern  cl_int __stdcall
clSetKernelArg(cl_kernel    kernel,
               cl_uint      arg_index,
               size_t       arg_size,
               const void * arg_value) ;



extern  cl_int __stdcall
clSetKernelArgSVMPointer(cl_kernel    kernel,
                         cl_uint      arg_index,
                         const void * arg_value) ;

extern  cl_int __stdcall
clSetKernelExecInfo(cl_kernel            kernel,
                    cl_kernel_exec_info  param_name,
                    size_t               param_value_size,
                    const void *         param_value) ;

#line 1403 "C:\\OpenCL\\include\\CL/cl.h"

extern  cl_int __stdcall
clGetKernelInfo(cl_kernel       kernel,
                cl_kernel_info  param_name,
                size_t          param_value_size,
                void *          param_value,
                size_t *        param_value_size_ret) ;



extern  cl_int __stdcall
clGetKernelArgInfo(cl_kernel       kernel,
                   cl_uint         arg_indx,
                   cl_kernel_arg_info  param_name,
                   size_t          param_value_size,
                   void *          param_value,
                   size_t *        param_value_size_ret) ;

#line 1422 "C:\\OpenCL\\include\\CL/cl.h"

extern  cl_int __stdcall
clGetKernelWorkGroupInfo(cl_kernel                  kernel,
                         cl_device_id               device,
                         cl_kernel_work_group_info  param_name,
                         size_t                     param_value_size,
                         void *                     param_value,
                         size_t *                   param_value_size_ret) ;



extern  cl_int __stdcall
clGetKernelSubGroupInfo(cl_kernel                   kernel,
                        cl_device_id                device,
                        cl_kernel_sub_group_info    param_name,
                        size_t                      input_value_size,
                        const void*                 input_value,
                        size_t                      param_value_size,
                        void*                       param_value,
                        size_t*                     param_value_size_ret) ;

#line 1444 "C:\\OpenCL\\include\\CL/cl.h"

/* Event Object APIs */
extern  cl_int __stdcall
clWaitForEvents(cl_uint             num_events,
                const cl_event *    event_list) ;

extern  cl_int __stdcall
clGetEventInfo(cl_event         event,
               cl_event_info    param_name,
               size_t           param_value_size,
               void *           param_value,
               size_t *         param_value_size_ret) ;



extern  cl_event __stdcall
clCreateUserEvent(cl_context    context,
                  cl_int *      errcode_ret) ;

#line 1464 "C:\\OpenCL\\include\\CL/cl.h"

extern  cl_int __stdcall
clRetainEvent(cl_event event) ;

extern  cl_int __stdcall
clReleaseEvent(cl_event event) ;



extern  cl_int __stdcall
clSetUserEventStatus(cl_event   event,
                     cl_int     execution_status) ;

extern  cl_int __stdcall
clSetEventCallback(cl_event    event,
                   cl_int      command_exec_callback_type,
                   void (__stdcall * pfn_notify)(cl_event event,
                                                   cl_int   event_command_status,
                                                   void *   user_data),
                   void *      user_data) ;

#line 1486 "C:\\OpenCL\\include\\CL/cl.h"

/* Profiling APIs */
extern  cl_int __stdcall
clGetEventProfilingInfo(cl_event            event,
                        cl_profiling_info   param_name,
                        size_t              param_value_size,
                        void *              param_value,
                        size_t *            param_value_size_ret) ;

/* Flush and Finish APIs */
extern  cl_int __stdcall
clFlush(cl_command_queue command_queue) ;

extern  cl_int __stdcall
clFinish(cl_command_queue command_queue) ;

/* Enqueued Commands APIs */
extern  cl_int __stdcall
clEnqueueReadBuffer(cl_command_queue    command_queue,
                    cl_mem              buffer,
                    cl_bool             blocking_read,
                    size_t              offset,
                    size_t              size,
                    void *              ptr,
                    cl_uint             num_events_in_wait_list,
                    const cl_event *    event_wait_list,
                    cl_event *          event) ;



extern  cl_int __stdcall
clEnqueueReadBufferRect(cl_command_queue    command_queue,
                        cl_mem              buffer,
                        cl_bool             blocking_read,
                        const size_t *      buffer_origin,
                        const size_t *      host_origin,
                        const size_t *      region,
                        size_t              buffer_row_pitch,
                        size_t              buffer_slice_pitch,
                        size_t              host_row_pitch,
                        size_t              host_slice_pitch,
                        void *              ptr,
                        cl_uint             num_events_in_wait_list,
                        const cl_event *    event_wait_list,
                        cl_event *          event) ;

#line 1533 "C:\\OpenCL\\include\\CL/cl.h"

extern  cl_int __stdcall
clEnqueueWriteBuffer(cl_command_queue   command_queue,
                     cl_mem             buffer,
                     cl_bool            blocking_write,
                     size_t             offset,
                     size_t             size,
                     const void *       ptr,
                     cl_uint            num_events_in_wait_list,
                     const cl_event *   event_wait_list,
                     cl_event *         event) ;



extern  cl_int __stdcall
clEnqueueWriteBufferRect(cl_command_queue    command_queue,
                         cl_mem              buffer,
                         cl_bool             blocking_write,
                         const size_t *      buffer_origin,
                         const size_t *      host_origin,
                         const size_t *      region,
                         size_t              buffer_row_pitch,
                         size_t              buffer_slice_pitch,
                         size_t              host_row_pitch,
                         size_t              host_slice_pitch,
                         const void *        ptr,
                         cl_uint             num_events_in_wait_list,
                         const cl_event *    event_wait_list,
                         cl_event *          event) ;

#line 1564 "C:\\OpenCL\\include\\CL/cl.h"



extern  cl_int __stdcall
clEnqueueFillBuffer(cl_command_queue   command_queue,
                    cl_mem             buffer,
                    const void *       pattern,
                    size_t             pattern_size,
                    size_t             offset,
                    size_t             size,
                    cl_uint            num_events_in_wait_list,
                    const cl_event *   event_wait_list,
                    cl_event *         event) ;

#line 1579 "C:\\OpenCL\\include\\CL/cl.h"

extern  cl_int __stdcall
clEnqueueCopyBuffer(cl_command_queue    command_queue,
                    cl_mem              src_buffer,
                    cl_mem              dst_buffer,
                    size_t              src_offset,
                    size_t              dst_offset,
                    size_t              size,
                    cl_uint             num_events_in_wait_list,
                    const cl_event *    event_wait_list,
                    cl_event *          event) ;



extern  cl_int __stdcall
clEnqueueCopyBufferRect(cl_command_queue    command_queue,
                        cl_mem              src_buffer,
                        cl_mem              dst_buffer,
                        const size_t *      src_origin,
                        const size_t *      dst_origin,
                        const size_t *      region,
                        size_t              src_row_pitch,
                        size_t              src_slice_pitch,
                        size_t              dst_row_pitch,
                        size_t              dst_slice_pitch,
                        cl_uint             num_events_in_wait_list,
                        const cl_event *    event_wait_list,
                        cl_event *          event) ;

#line 1609 "C:\\OpenCL\\include\\CL/cl.h"

extern  cl_int __stdcall
clEnqueueReadImage(cl_command_queue     command_queue,
                   cl_mem               image,
                   cl_bool              blocking_read,
                   const size_t *       origin,
                   const size_t *       region,
                   size_t               row_pitch,
                   size_t               slice_pitch,
                   void *               ptr,
                   cl_uint              num_events_in_wait_list,
                   const cl_event *     event_wait_list,
                   cl_event *           event) ;

extern  cl_int __stdcall
clEnqueueWriteImage(cl_command_queue    command_queue,
                    cl_mem              image,
                    cl_bool             blocking_write,
                    const size_t *      origin,
                    const size_t *      region,
                    size_t              input_row_pitch,
                    size_t              input_slice_pitch,
                    const void *        ptr,
                    cl_uint             num_events_in_wait_list,
                    const cl_event *    event_wait_list,
                    cl_event *          event) ;



extern  cl_int __stdcall
clEnqueueFillImage(cl_command_queue   command_queue,
                   cl_mem             image,
                   const void *       fill_color,
                   const size_t *     origin,
                   const size_t *     region,
                   cl_uint            num_events_in_wait_list,
                   const cl_event *   event_wait_list,
                   cl_event *         event) ;

#line 1649 "C:\\OpenCL\\include\\CL/cl.h"

extern  cl_int __stdcall
clEnqueueCopyImage(cl_command_queue     command_queue,
                   cl_mem               src_image,
                   cl_mem               dst_image,
                   const size_t *       src_origin,
                   const size_t *       dst_origin,
                   const size_t *       region,
                   cl_uint              num_events_in_wait_list,
                   const cl_event *     event_wait_list,
                   cl_event *           event) ;

extern  cl_int __stdcall
clEnqueueCopyImageToBuffer(cl_command_queue command_queue,
                           cl_mem           src_image,
                           cl_mem           dst_buffer,
                           const size_t *   src_origin,
                           const size_t *   region,
                           size_t           dst_offset,
                           cl_uint          num_events_in_wait_list,
                           const cl_event * event_wait_list,
                           cl_event *       event) ;

extern  cl_int __stdcall
clEnqueueCopyBufferToImage(cl_command_queue command_queue,
                           cl_mem           src_buffer,
                           cl_mem           dst_image,
                           size_t           src_offset,
                           const size_t *   dst_origin,
                           const size_t *   region,
                           cl_uint          num_events_in_wait_list,
                           const cl_event * event_wait_list,
                           cl_event *       event) ;

extern  void * __stdcall
clEnqueueMapBuffer(cl_command_queue command_queue,
                   cl_mem           buffer,
                   cl_bool          blocking_map,
                   cl_map_flags     map_flags,
                   size_t           offset,
                   size_t           size,
                   cl_uint          num_events_in_wait_list,
                   const cl_event * event_wait_list,
                   cl_event *       event,
                   cl_int *         errcode_ret) ;

extern  void * __stdcall
clEnqueueMapImage(cl_command_queue  command_queue,
                  cl_mem            image,
                  cl_bool           blocking_map,
                  cl_map_flags      map_flags,
                  const size_t *    origin,
                  const size_t *    region,
                  size_t *          image_row_pitch,
                  size_t *          image_slice_pitch,
                  cl_uint           num_events_in_wait_list,
                  const cl_event *  event_wait_list,
                  cl_event *        event,
                  cl_int *          errcode_ret) ;

extern  cl_int __stdcall
clEnqueueUnmapMemObject(cl_command_queue command_queue,
                        cl_mem           memobj,
                        void *           mapped_ptr,
                        cl_uint          num_events_in_wait_list,
                        const cl_event * event_wait_list,
                        cl_event *       event) ;



extern  cl_int __stdcall
clEnqueueMigrateMemObjects(cl_command_queue       command_queue,
                           cl_uint                num_mem_objects,
                           const cl_mem *         mem_objects,
                           cl_mem_migration_flags flags,
                           cl_uint                num_events_in_wait_list,
                           const cl_event *       event_wait_list,
                           cl_event *             event) ;

#line 1729 "C:\\OpenCL\\include\\CL/cl.h"

extern  cl_int __stdcall
clEnqueueNDRangeKernel(cl_command_queue command_queue,
                       cl_kernel        kernel,
                       cl_uint          work_dim,
                       const size_t *   global_work_offset,
                       const size_t *   global_work_size,
                       const size_t *   local_work_size,
                       cl_uint          num_events_in_wait_list,
                       const cl_event * event_wait_list,
                       cl_event *       event) ;

extern  cl_int __stdcall
clEnqueueNativeKernel(cl_command_queue  command_queue,
                      void (__stdcall * user_func)(void *),
                      void *            args,
                      size_t            cb_args,
                      cl_uint           num_mem_objects,
                      const cl_mem *    mem_list,
                      const void **     args_mem_loc,
                      cl_uint           num_events_in_wait_list,
                      const cl_event *  event_wait_list,
                      cl_event *        event) ;



extern  cl_int __stdcall
clEnqueueMarkerWithWaitList(cl_command_queue  command_queue,
                            cl_uint           num_events_in_wait_list,
                            const cl_event *  event_wait_list,
                            cl_event *        event) ;

extern  cl_int __stdcall
clEnqueueBarrierWithWaitList(cl_command_queue  command_queue,
                             cl_uint           num_events_in_wait_list,
                             const cl_event *  event_wait_list,
                             cl_event *        event) ;

#line 1768 "C:\\OpenCL\\include\\CL/cl.h"



extern  cl_int __stdcall
clEnqueueSVMFree(cl_command_queue  command_queue,
                 cl_uint           num_svm_pointers,
                 void *            svm_pointers[],
                 void (__stdcall * pfn_free_func)(cl_command_queue queue,
                                                    cl_uint          num_svm_pointers,
                                                    void *           svm_pointers[],
                                                    void *           user_data),
                 void *            user_data,
                 cl_uint           num_events_in_wait_list,
                 const cl_event *  event_wait_list,
                 cl_event *        event) ;

extern  cl_int __stdcall
clEnqueueSVMMemcpy(cl_command_queue  command_queue,
                   cl_bool           blocking_copy,
                   void *            dst_ptr,
                   const void *      src_ptr,
                   size_t            size,
                   cl_uint           num_events_in_wait_list,
                   const cl_event *  event_wait_list,
                   cl_event *        event) ;

extern  cl_int __stdcall
clEnqueueSVMMemFill(cl_command_queue  command_queue,
                    void *            svm_ptr,
                    const void *      pattern,
                    size_t            pattern_size,
                    size_t            size,
                    cl_uint           num_events_in_wait_list,
                    const cl_event *  event_wait_list,
                    cl_event *        event) ;

extern  cl_int __stdcall
clEnqueueSVMMap(cl_command_queue  command_queue,
                cl_bool           blocking_map,
                cl_map_flags      flags,
                void *            svm_ptr,
                size_t            size,
                cl_uint           num_events_in_wait_list,
                const cl_event *  event_wait_list,
                cl_event *        event) ;

extern  cl_int __stdcall
clEnqueueSVMUnmap(cl_command_queue  command_queue,
                  void *            svm_ptr,
                  cl_uint           num_events_in_wait_list,
                  const cl_event *  event_wait_list,
                  cl_event *        event) ;

#line 1822 "C:\\OpenCL\\include\\CL/cl.h"



extern  cl_int __stdcall
clEnqueueSVMMigrateMem(cl_command_queue         command_queue,
                       cl_uint                  num_svm_pointers,
                       const void **            svm_pointers,
                       const size_t *           sizes,
                       cl_mem_migration_flags   flags,
                       cl_uint                  num_events_in_wait_list,
                       const cl_event *         event_wait_list,
                       cl_event *               event) ;

#line 1836 "C:\\OpenCL\\include\\CL/cl.h"



/* Extension function access
 *
 * Returns the extension function address for the given function name,
 * or NULL if a valid function can not be found.  The client must
 * check to make sure the address is not NULL, before using or
 * calling the returned function address.
 */
extern  void * __stdcall
clGetExtensionFunctionAddressForPlatform(cl_platform_id platform,
                                         const char *   func_name) ;

#line 1851 "C:\\OpenCL\\include\\CL/cl.h"



















/* Deprecated OpenCL 1.1 APIs */
extern   __declspec(deprecated) cl_mem __stdcall
clCreateImage2D(cl_context              context,
                cl_mem_flags            flags,
                const cl_image_format * image_format,
                size_t                  image_width,
                size_t                  image_height,
                size_t                  image_row_pitch,
                void *                  host_ptr,
                cl_int *                errcode_ret)  ;

extern   __declspec(deprecated) cl_mem __stdcall
clCreateImage3D(cl_context              context,
                cl_mem_flags            flags,
                const cl_image_format * image_format,
                size_t                  image_width,
                size_t                  image_height,
                size_t                  image_depth,
                size_t                  image_row_pitch,
                size_t                  image_slice_pitch,
                void *                  host_ptr,
                cl_int *                errcode_ret)  ;

extern   __declspec(deprecated) cl_int __stdcall
clEnqueueMarker(cl_command_queue    command_queue,
                cl_event *          event)  ;

extern   __declspec(deprecated) cl_int __stdcall
clEnqueueWaitForEvents(cl_command_queue  command_queue,
                        cl_uint          num_events,
                        const cl_event * event_list)  ;

extern   __declspec(deprecated) cl_int __stdcall
clEnqueueBarrier(cl_command_queue command_queue)  ;

extern   __declspec(deprecated) cl_int __stdcall
clUnloadCompiler(void)  ;

extern   __declspec(deprecated) void * __stdcall
clGetExtensionFunctionAddress(const char * func_name)  ;

/* Deprecated OpenCL 2.0 APIs */
extern   __declspec(deprecated) cl_command_queue __stdcall
clCreateCommandQueue(cl_context                     context,
                     cl_device_id                   device,
                     cl_command_queue_properties    properties,
                     cl_int *                       errcode_ret)  ;

extern   __declspec(deprecated) cl_sampler __stdcall
clCreateSampler(cl_context          context,
                cl_bool             normalized_coords,
                cl_addressing_mode  addressing_mode,
                cl_filter_mode      filter_mode,
                cl_int *            errcode_ret)  ;

extern   __declspec(deprecated) cl_int __stdcall
clEnqueueTask(cl_command_queue  command_queue,
              cl_kernel         kernel,
              cl_uint           num_events_in_wait_list,
              const cl_event *  event_wait_list,
              cl_event *        event)  ;





#line 1937 "C:\\OpenCL\\include\\CL/cl.h"
#line 25 "C:\\OpenCL\\include\\CL/opencl.h"
#line 1 "C:\\OpenCL\\include\\CL/cl_gl.h"
/*******************************************************************************
 * Copyright (c) 2008-2021 The Khronos Group Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 ******************************************************************************/










typedef cl_uint     cl_gl_object_type;
typedef cl_uint     cl_gl_texture_info;
typedef cl_uint     cl_gl_platform_info;
typedef struct __GLsync *cl_GLsync;

/* cl_gl_object_type = 0x2000 - 0x200F enum values are currently taken           */









#line 42 "C:\\OpenCL\\include\\CL/cl_gl.h"

/* cl_gl_texture_info           */




#line 49 "C:\\OpenCL\\include\\CL/cl_gl.h"


extern  cl_mem __stdcall
clCreateFromGLBuffer(cl_context     context,
                     cl_mem_flags   flags,
                     cl_GLuint      bufobj,
                     cl_int *       errcode_ret) ;



extern  cl_mem __stdcall
clCreateFromGLTexture(cl_context      context,
                      cl_mem_flags    flags,
                      cl_GLenum       target,
                      cl_GLint        miplevel,
                      cl_GLuint       texture,
                      cl_int *        errcode_ret) ;

#line 68 "C:\\OpenCL\\include\\CL/cl_gl.h"

extern  cl_mem __stdcall
clCreateFromGLRenderbuffer(cl_context   context,
                           cl_mem_flags flags,
                           cl_GLuint    renderbuffer,
                           cl_int *     errcode_ret) ;

extern  cl_int __stdcall
clGetGLObjectInfo(cl_mem                memobj,
                  cl_gl_object_type *   gl_object_type,
                  cl_GLuint *           gl_object_name) ;

extern  cl_int __stdcall
clGetGLTextureInfo(cl_mem               memobj,
                   cl_gl_texture_info   param_name,
                   size_t               param_value_size,
                   void *               param_value,
                   size_t *             param_value_size_ret) ;

extern  cl_int __stdcall
clEnqueueAcquireGLObjects(cl_command_queue      command_queue,
                          cl_uint               num_objects,
                          const cl_mem *        mem_objects,
                          cl_uint               num_events_in_wait_list,
                          const cl_event *      event_wait_list,
                          cl_event *            event) ;

extern  cl_int __stdcall
clEnqueueReleaseGLObjects(cl_command_queue      command_queue,
                          cl_uint               num_objects,
                          const cl_mem *        mem_objects,
                          cl_uint               num_events_in_wait_list,
                          const cl_event *      event_wait_list,
                          cl_event *            event) ;


/* Deprecated OpenCL 1.1 APIs */
extern   __declspec(deprecated) cl_mem __stdcall
clCreateFromGLTexture2D(cl_context      context,
                        cl_mem_flags    flags,
                        cl_GLenum       target,
                        cl_GLint        miplevel,
                        cl_GLuint       texture,
                        cl_int *        errcode_ret)  ;

extern   __declspec(deprecated) cl_mem __stdcall
clCreateFromGLTexture3D(cl_context      context,
                        cl_mem_flags    flags,
                        cl_GLenum       target,
                        cl_GLint        miplevel,
                        cl_GLuint       texture,
                        cl_int *        errcode_ret)  ;

/* cl_khr_gl_sharing extension  */



typedef cl_uint     cl_gl_context_info;

/* Additional Error Codes  */


/* cl_gl_context_info  */



/* Additional cl_context_properties  */






extern  cl_int __stdcall
clGetGLContextInfoKHR(const cl_context_properties * properties,
                      cl_gl_context_info            param_name,
                      size_t                        param_value_size,
                      void *                        param_value,
                      size_t *                      param_value_size_ret) ;

typedef cl_int (__stdcall *clGetGLContextInfoKHR_fn)(
    const cl_context_properties * properties,
    cl_gl_context_info            param_name,
    size_t                        param_value_size,
    void *                        param_value,
    size_t *                      param_value_size_ret);

/* 
 *  cl_khr_gl_event extension
 */


extern  cl_event __stdcall
clCreateEventFromGLsyncKHR(cl_context context,
                           cl_GLsync  sync,
                           cl_int *   errcode_ret) ;

/***************************************************************
* cl_intel_sharing_format_query_gl
***************************************************************/


/* when cl_khr_gl_sharing is supported */

extern  cl_int __stdcall
clGetSupportedGLTextureFormatsINTEL(
    cl_context context,
    cl_mem_flags flags,
    cl_mem_object_type image_type,
    cl_uint num_entries,
    cl_GLenum* gl_formats,
    cl_uint* num_texture_formats) ;

typedef cl_int (__stdcall *
clGetSupportedGLTextureFormatsINTEL_fn)(
    cl_context context,
    cl_mem_flags flags,
    cl_mem_object_type image_type,
    cl_uint num_entries,
    cl_GLenum* gl_formats,
    cl_uint* num_texture_formats) ;





#line 195 "C:\\OpenCL\\include\\CL/cl_gl.h"
#line 26 "C:\\OpenCL\\include\\CL/opencl.h"
#line 1 "C:\\OpenCL\\include\\CL/cl_ext.h"
/*******************************************************************************
 * Copyright (c) 2008-2020 The Khronos Group Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 ******************************************************************************/

/* cl_ext.h contains OpenCL extensions which don't have external */
/* (OpenGL, D3D) dependencies.                                   */










/***************************************************************
* cl_khr_command_buffer
***************************************************************/




typedef cl_bitfield         cl_device_command_buffer_capabilities_khr;
typedef struct _cl_command_buffer_khr* cl_command_buffer_khr;
typedef cl_uint             cl_sync_point_khr;
typedef cl_uint             cl_command_buffer_info_khr;
typedef cl_uint             cl_command_buffer_state_khr;
typedef cl_properties       cl_command_buffer_properties_khr;
typedef cl_bitfield         cl_command_buffer_flags_khr;
typedef cl_properties       cl_ndrange_kernel_command_properties_khr;
typedef struct _cl_mutable_command_khr* cl_mutable_command_khr;

/* cl_device_info */



/* cl_device_command_buffer_capabilities_khr - bitfield */





/* cl_command_buffer_properties_khr */


/* cl_command_buffer_flags_khr */


/* Error codes */




/* cl_command_buffer_info_khr */






/* cl_command_buffer_state_khr */





/* cl_command_type */



typedef cl_command_buffer_khr (__stdcall *
clCreateCommandBufferKHR_fn)(
    cl_uint num_queues,
    const cl_command_queue* queues,
    const cl_command_buffer_properties_khr* properties,
    cl_int* errcode_ret) ;

typedef cl_int (__stdcall *
clFinalizeCommandBufferKHR_fn)(
    cl_command_buffer_khr command_buffer) ;

typedef cl_int (__stdcall *
clRetainCommandBufferKHR_fn)(
    cl_command_buffer_khr command_buffer) ;

typedef cl_int (__stdcall *
clReleaseCommandBufferKHR_fn)(
    cl_command_buffer_khr command_buffer) ;

typedef cl_int (__stdcall *
clEnqueueCommandBufferKHR_fn)(
    cl_uint num_queues,
    cl_command_queue* queues,
    cl_command_buffer_khr command_buffer,
    cl_uint num_events_in_wait_list,
    const cl_event* event_wait_list,
    cl_event* event) ;

typedef cl_int (__stdcall *
clCommandBarrierWithWaitListKHR_fn)(
    cl_command_buffer_khr command_buffer,
    cl_command_queue command_queue,
    cl_uint num_sync_points_in_wait_list,
    const cl_sync_point_khr* sync_point_wait_list,
    cl_sync_point_khr* sync_point,
    cl_mutable_command_khr* mutable_handle) ;

typedef cl_int (__stdcall *
clCommandCopyBufferKHR_fn)(
    cl_command_buffer_khr command_buffer,
    cl_command_queue command_queue,
    cl_mem src_buffer,
    cl_mem dst_buffer,
    size_t src_offset,
    size_t dst_offset,
    size_t size,
    cl_uint num_sync_points_in_wait_list,
    const cl_sync_point_khr* sync_point_wait_list,
    cl_sync_point_khr* sync_point,
    cl_mutable_command_khr* mutable_handle) ;

typedef cl_int (__stdcall *
clCommandCopyBufferRectKHR_fn)(
    cl_command_buffer_khr command_buffer,
    cl_command_queue command_queue,
    cl_mem src_buffer,
    cl_mem dst_buffer,
    const size_t* src_origin,
    const size_t* dst_origin,
    const size_t* region,
    size_t src_row_pitch,
    size_t src_slice_pitch,
    size_t dst_row_pitch,
    size_t dst_slice_pitch,
    cl_uint num_sync_points_in_wait_list,
    const cl_sync_point_khr* sync_point_wait_list,
    cl_sync_point_khr* sync_point,
    cl_mutable_command_khr* mutable_handle) ;

typedef cl_int (__stdcall *
clCommandCopyBufferToImageKHR_fn)(
    cl_command_buffer_khr command_buffer,
    cl_command_queue command_queue,
    cl_mem src_buffer,
    cl_mem dst_image,
    size_t src_offset,
    const size_t* dst_origin,
    const size_t* region,
    cl_uint num_sync_points_in_wait_list,
    const cl_sync_point_khr* sync_point_wait_list,
    cl_sync_point_khr* sync_point,
    cl_mutable_command_khr* mutable_handle) ;

typedef cl_int (__stdcall *
clCommandCopyImageKHR_fn)(
    cl_command_buffer_khr command_buffer,
    cl_command_queue command_queue,
    cl_mem src_image,
    cl_mem dst_image,
    const size_t* src_origin,
    const size_t* dst_origin,
    const size_t* region,
    cl_uint num_sync_points_in_wait_list,
    const cl_sync_point_khr* sync_point_wait_list,
    cl_sync_point_khr* sync_point,
    cl_mutable_command_khr* mutable_handle) ;

typedef cl_int (__stdcall *
clCommandCopyImageToBufferKHR_fn)(
    cl_command_buffer_khr command_buffer,
    cl_command_queue command_queue,
    cl_mem src_image,
    cl_mem dst_buffer,
    const size_t* src_origin,
    const size_t* region,
    size_t dst_offset,
    cl_uint num_sync_points_in_wait_list,
    const cl_sync_point_khr* sync_point_wait_list,
    cl_sync_point_khr* sync_point,
    cl_mutable_command_khr* mutable_handle) ;

typedef cl_int (__stdcall *
clCommandFillBufferKHR_fn)(
    cl_command_buffer_khr command_buffer,
    cl_command_queue command_queue,
    cl_mem buffer,
    const void* pattern,
    size_t pattern_size,
    size_t offset,
    size_t size,
    cl_uint num_sync_points_in_wait_list,
    const cl_sync_point_khr* sync_point_wait_list,
    cl_sync_point_khr* sync_point,
    cl_mutable_command_khr* mutable_handle) ;

typedef cl_int (__stdcall *
clCommandFillImageKHR_fn)(
    cl_command_buffer_khr command_buffer,
    cl_command_queue command_queue,
    cl_mem image,
    const void* fill_color,
    const size_t* origin,
    const size_t* region,
    cl_uint num_sync_points_in_wait_list,
    const cl_sync_point_khr* sync_point_wait_list,
    cl_sync_point_khr* sync_point,
    cl_mutable_command_khr* mutable_handle) ;

typedef cl_int (__stdcall *
clCommandNDRangeKernelKHR_fn)(
    cl_command_buffer_khr command_buffer,
    cl_command_queue command_queue,
    const cl_ndrange_kernel_command_properties_khr* properties,
    cl_kernel kernel,
    cl_uint work_dim,
    const size_t* global_work_offset,
    const size_t* global_work_size,
    const size_t* local_work_size,
    cl_uint num_sync_points_in_wait_list,
    const cl_sync_point_khr* sync_point_wait_list,
    cl_sync_point_khr* sync_point,
    cl_mutable_command_khr* mutable_handle) ;

typedef cl_int (__stdcall *
clGetCommandBufferInfoKHR_fn)(
    cl_command_buffer_khr command_buffer,
    cl_command_buffer_info_khr param_name,
    size_t param_value_size,
    void* param_value,
    size_t* param_value_size_ret) ;



extern  cl_command_buffer_khr __stdcall
clCreateCommandBufferKHR(
    cl_uint num_queues,
    const cl_command_queue* queues,
    const cl_command_buffer_properties_khr* properties,
    cl_int* errcode_ret) ;

extern  cl_int __stdcall
clFinalizeCommandBufferKHR(
    cl_command_buffer_khr command_buffer) ;

extern  cl_int __stdcall
clRetainCommandBufferKHR(
    cl_command_buffer_khr command_buffer) ;

extern  cl_int __stdcall
clReleaseCommandBufferKHR(
    cl_command_buffer_khr command_buffer) ;

extern  cl_int __stdcall
clEnqueueCommandBufferKHR(
    cl_uint num_queues,
    cl_command_queue* queues,
    cl_command_buffer_khr command_buffer,
    cl_uint num_events_in_wait_list,
    const cl_event* event_wait_list,
    cl_event* event) ;

extern  cl_int __stdcall
clCommandBarrierWithWaitListKHR(
    cl_command_buffer_khr command_buffer,
    cl_command_queue command_queue,
    cl_uint num_sync_points_in_wait_list,
    const cl_sync_point_khr* sync_point_wait_list,
    cl_sync_point_khr* sync_point,
    cl_mutable_command_khr* mutable_handle) ;

extern  cl_int __stdcall
clCommandCopyBufferKHR(
    cl_command_buffer_khr command_buffer,
    cl_command_queue command_queue,
    cl_mem src_buffer,
    cl_mem dst_buffer,
    size_t src_offset,
    size_t dst_offset,
    size_t size,
    cl_uint num_sync_points_in_wait_list,
    const cl_sync_point_khr* sync_point_wait_list,
    cl_sync_point_khr* sync_point,
    cl_mutable_command_khr* mutable_handle) ;

extern  cl_int __stdcall
clCommandCopyBufferRectKHR(
    cl_command_buffer_khr command_buffer,
    cl_command_queue command_queue,
    cl_mem src_buffer,
    cl_mem dst_buffer,
    const size_t* src_origin,
    const size_t* dst_origin,
    const size_t* region,
    size_t src_row_pitch,
    size_t src_slice_pitch,
    size_t dst_row_pitch,
    size_t dst_slice_pitch,
    cl_uint num_sync_points_in_wait_list,
    const cl_sync_point_khr* sync_point_wait_list,
    cl_sync_point_khr* sync_point,
    cl_mutable_command_khr* mutable_handle) ;

extern  cl_int __stdcall
clCommandCopyBufferToImageKHR(
    cl_command_buffer_khr command_buffer,
    cl_command_queue command_queue,
    cl_mem src_buffer,
    cl_mem dst_image,
    size_t src_offset,
    const size_t* dst_origin,
    const size_t* region,
    cl_uint num_sync_points_in_wait_list,
    const cl_sync_point_khr* sync_point_wait_list,
    cl_sync_point_khr* sync_point,
    cl_mutable_command_khr* mutable_handle) ;

extern  cl_int __stdcall
clCommandCopyImageKHR(
    cl_command_buffer_khr command_buffer,
    cl_command_queue command_queue,
    cl_mem src_image,
    cl_mem dst_image,
    const size_t* src_origin,
    const size_t* dst_origin,
    const size_t* region,
    cl_uint num_sync_points_in_wait_list,
    const cl_sync_point_khr* sync_point_wait_list,
    cl_sync_point_khr* sync_point,
    cl_mutable_command_khr* mutable_handle) ;

extern  cl_int __stdcall
clCommandCopyImageToBufferKHR(
    cl_command_buffer_khr command_buffer,
    cl_command_queue command_queue,
    cl_mem src_image,
    cl_mem dst_buffer,
    const size_t* src_origin,
    const size_t* region,
    size_t dst_offset,
    cl_uint num_sync_points_in_wait_list,
    const cl_sync_point_khr* sync_point_wait_list,
    cl_sync_point_khr* sync_point,
    cl_mutable_command_khr* mutable_handle) ;

extern  cl_int __stdcall
clCommandFillBufferKHR(
    cl_command_buffer_khr command_buffer,
    cl_command_queue command_queue,
    cl_mem buffer,
    const void* pattern,
    size_t pattern_size,
    size_t offset,
    size_t size,
    cl_uint num_sync_points_in_wait_list,
    const cl_sync_point_khr* sync_point_wait_list,
    cl_sync_point_khr* sync_point,
    cl_mutable_command_khr* mutable_handle) ;

extern  cl_int __stdcall
clCommandFillImageKHR(
    cl_command_buffer_khr command_buffer,
    cl_command_queue command_queue,
    cl_mem image,
    const void* fill_color,
    const size_t* origin,
    const size_t* region,
    cl_uint num_sync_points_in_wait_list,
    const cl_sync_point_khr* sync_point_wait_list,
    cl_sync_point_khr* sync_point,
    cl_mutable_command_khr* mutable_handle) ;

extern  cl_int __stdcall
clCommandNDRangeKernelKHR(
    cl_command_buffer_khr command_buffer,
    cl_command_queue command_queue,
    const cl_ndrange_kernel_command_properties_khr* properties,
    cl_kernel kernel,
    cl_uint work_dim,
    const size_t* global_work_offset,
    const size_t* global_work_size,
    const size_t* local_work_size,
    cl_uint num_sync_points_in_wait_list,
    const cl_sync_point_khr* sync_point_wait_list,
    cl_sync_point_khr* sync_point,
    cl_mutable_command_khr* mutable_handle) ;

extern  cl_int __stdcall
clGetCommandBufferInfoKHR(
    cl_command_buffer_khr command_buffer,
    cl_command_buffer_info_khr param_name,
    size_t param_value_size,
    void* param_value,
    size_t* param_value_size_ret) ;

#line 409 "C:\\OpenCL\\include\\CL/cl_ext.h"

/***************************************************************
* cl_khr_command_buffer_mutable_dispatch
***************************************************************/




typedef cl_uint             cl_command_buffer_structure_type_khr;
typedef cl_bitfield         cl_mutable_dispatch_fields_khr;
typedef cl_uint             cl_mutable_command_info_khr;
typedef struct _cl_mutable_dispatch_arg_khr {
    cl_uint arg_index;
    size_t arg_size;
    const void* arg_value;
} cl_mutable_dispatch_arg_khr;
typedef struct _cl_mutable_dispatch_exec_info_khr {
    cl_uint param_name;
    size_t param_value_size;
    const void* param_value;
} cl_mutable_dispatch_exec_info_khr;
typedef struct _cl_mutable_dispatch_config_khr {
    cl_command_buffer_structure_type_khr type;
    const void* next;
    cl_mutable_command_khr command;
    cl_uint num_args;
    cl_uint num_svm_args;
    cl_uint num_exec_infos;
    cl_uint work_dim;
    const cl_mutable_dispatch_arg_khr* arg_list;
    const cl_mutable_dispatch_arg_khr* arg_svm_list;
    const cl_mutable_dispatch_exec_info_khr* exec_info_list;
    const size_t* global_work_offset;
    const size_t* global_work_size;
    const size_t* local_work_size;
} cl_mutable_dispatch_config_khr;
typedef struct _cl_mutable_base_config_khr {
    cl_command_buffer_structure_type_khr type;
    const void* next;
    cl_uint num_mutable_dispatch;
    const cl_mutable_dispatch_config_khr* mutable_dispatch_list;
} cl_mutable_base_config_khr;

/* cl_command_buffer_flags_khr - bitfield */


/* Error codes */


/* cl_device_info */


/* cl_ndrange_kernel_command_properties_khr */


/* cl_mutable_dispatch_fields_khr - bitfield */






/* cl_mutable_command_info_khr */










/* cl_command_buffer_structure_type_khr */




typedef cl_int (__stdcall *
clUpdateMutableCommandsKHR_fn)(
    cl_command_buffer_khr command_buffer,
    const cl_mutable_base_config_khr* mutable_config) ;

typedef cl_int (__stdcall *
clGetMutableCommandInfoKHR_fn)(
    cl_mutable_command_khr command,
    cl_mutable_command_info_khr param_name,
    size_t param_value_size,
    void* param_value,
    size_t* param_value_size_ret) ;



extern  cl_int __stdcall
clUpdateMutableCommandsKHR(
    cl_command_buffer_khr command_buffer,
    const cl_mutable_base_config_khr* mutable_config) ;

extern  cl_int __stdcall
clGetMutableCommandInfoKHR(
    cl_mutable_command_khr command,
    cl_mutable_command_info_khr param_name,
    size_t param_value_size,
    void* param_value,
    size_t* param_value_size_ret) ;

#line 516 "C:\\OpenCL\\include\\CL/cl_ext.h"

/* cl_khr_fp64 extension - no extension #define since it has no functions  */
/* CL_DEVICE_DOUBLE_FP_CONFIG is defined in CL.h for OpenCL >= 120 */



#line 523 "C:\\OpenCL\\include\\CL/cl_ext.h"

/* cl_khr_fp16 extension - no extension #define since it has no functions  */


/* Memory object destruction
 *
 * Apple extension for use to manage externally allocated buffers used with cl_mem objects with CL_MEM_USE_HOST_PTR
 *
 * Registers a user callback function that will be called when the memory object is deleted and its resources
 * freed. Each call to clSetMemObjectCallbackFn registers the specified user callback function on a callback
 * stack associated with memobj. The registered user callback functions are called in the reverse order in
 * which they were registered. The user callback functions are called and then the memory object is deleted
 * and its resources freed. This provides a mechanism for the application (and libraries) using memobj to be
 * notified when the memory referenced by host_ptr, specified when the memory object is created and used as
 * the storage bits for the memory object, can be reused or freed.
 *
 * The application may not call CL api's with the cl_mem object passed to the pfn_notify.
 *
 * Please check for the "cl_APPLE_SetMemObjectDestructor" extension using clGetDeviceInfo(CL_DEVICE_EXTENSIONS)
 * before using.
 */

extern  cl_int __stdcall clSetMemObjectDestructorAPPLE(  cl_mem memobj,
                                        void (* pfn_notify)(cl_mem memobj, void * user_data),
                                        void * user_data)             ;


/* Context Logging Functions
 *
 * The next three convenience functions are intended to be used as the pfn_notify parameter to clCreateContext().
 * Please check for the "cl_APPLE_ContextLoggingFunctions" extension using clGetDeviceInfo(CL_DEVICE_EXTENSIONS)
 * before using.
 *
 * clLogMessagesToSystemLog forwards on all log messages to the Apple System Logger
 */

extern  void __stdcall clLogMessagesToSystemLogAPPLE(  const char * errstr,
                                            const void * private_info,
                                            size_t       cb,
                                            void *       user_data)  ;

/* clLogMessagesToStdout sends all log messages to the file descriptor stdout */
extern  void __stdcall clLogMessagesToStdoutAPPLE(   const char * errstr,
                                          const void * private_info,
                                          size_t       cb,
                                          void *       user_data)    ;

/* clLogMessagesToStderr sends all log messages to the file descriptor stderr */
extern  void __stdcall clLogMessagesToStderrAPPLE(   const char * errstr,
                                          const void * private_info,
                                          size_t       cb,
                                          void *       user_data)    ;


/************************
* cl_khr_icd extension *
************************/


/* cl_platform_info                                                        */


/* Additional Error Codes                                                  */


extern  cl_int __stdcall
clIcdGetPlatformIDsKHR(cl_uint          num_entries,
                       cl_platform_id * platforms,
                       cl_uint *        num_platforms);

typedef cl_int
(__stdcall *clIcdGetPlatformIDsKHR_fn)(cl_uint          num_entries,
                                         cl_platform_id * platforms,
                                         cl_uint *        num_platforms);


/*******************************
 * cl_khr_il_program extension *
 *******************************/


/* New property to clGetDeviceInfo for retrieving supported intermediate
 * languages
 */


/* New property to clGetProgramInfo for retrieving for retrieving the IL of a
 * program
 */


extern  cl_program __stdcall
clCreateProgramWithILKHR(cl_context   context,
                         const void * il,
                         size_t       length,
                         cl_int *     errcode_ret);

typedef cl_program
(__stdcall *clCreateProgramWithILKHR_fn)(cl_context   context,
                                           const void * il,
                                           size_t       length,
                                           cl_int *     errcode_ret) ;

/* Extension: cl_khr_image2d_from_buffer
 *
 * This extension allows a 2D image to be created from a cl_mem buffer without
 * a copy. The type associated with a 2D image created from a buffer in an
 * OpenCL program is image2d_t. Both the sampler and sampler-less read_image
 * built-in functions are supported for 2D images and 2D images created from
 * a buffer.  Similarly, the write_image built-ins are also supported for 2D
 * images created from a buffer.
 *
 * When the 2D image from buffer is created, the client must specify the
 * width, height, image format (i.e. channel order and channel data type)
 * and optionally the row pitch.
 *
 * The pitch specified must be a multiple of
 * CL_DEVICE_IMAGE_PITCH_ALIGNMENT_KHR pixels.
 * The base address of the buffer must be aligned to
 * CL_DEVICE_IMAGE_BASE_ADDRESS_ALIGNMENT_KHR pixels.
 */





/**************************************
 * cl_khr_initialize_memory extension *
 **************************************/




/**************************************
 * cl_khr_terminate_context extension *
 **************************************/







extern  cl_int __stdcall
clTerminateContextKHR(cl_context context) ;

typedef cl_int
(__stdcall *clTerminateContextKHR_fn)(cl_context context) ;


/*
 * Extension: cl_khr_spir
 *
 * This extension adds support to create an OpenCL program object from a
 * Standard Portable Intermediate Representation (SPIR) instance
 */





/*****************************************
 * cl_khr_create_command_queue extension *
 *****************************************/


typedef cl_properties cl_queue_properties_khr;

extern  cl_command_queue __stdcall
clCreateCommandQueueWithPropertiesKHR(cl_context context,
                                      cl_device_id device,
                                      const cl_queue_properties_khr* properties,
                                      cl_int* errcode_ret) ;

typedef cl_command_queue
(__stdcall *clCreateCommandQueueWithPropertiesKHR_fn)(cl_context context,
                                                        cl_device_id device,
                                                        const cl_queue_properties_khr* properties,
                                                        cl_int* errcode_ret) ;


/******************************************
* cl_nv_device_attribute_query extension *
******************************************/

/* cl_nv_device_attribute_query extension - no extension #define since it has no functions */









/*********************************
* cl_amd_device_attribute_query *
*********************************/
























/*********************************
* cl_arm_printf extension
*********************************/





/***********************************
* cl_ext_device_fission extension
***********************************/


extern  cl_int __stdcall
clReleaseDeviceEXT(cl_device_id device) ;

typedef cl_int
(__stdcall *clReleaseDeviceEXT_fn)(cl_device_id device) ;

extern  cl_int __stdcall
clRetainDeviceEXT(cl_device_id device) ;

typedef cl_int
(__stdcall *clRetainDeviceEXT_fn)(cl_device_id device) ;

typedef cl_ulong  cl_device_partition_property_ext;
extern  cl_int __stdcall
clCreateSubDevicesEXT(cl_device_id   in_device,
                      const cl_device_partition_property_ext * properties,
                      cl_uint        num_entries,
                      cl_device_id * out_devices,
                      cl_uint *      num_devices) ;

typedef cl_int
(__stdcall * clCreateSubDevicesEXT_fn)(cl_device_id   in_device,
                                         const cl_device_partition_property_ext * properties,
                                         cl_uint        num_entries,
                                         cl_device_id * out_devices,
                                         cl_uint *      num_devices) ;

/* cl_device_partition_property_ext */





/* clDeviceGetInfo selectors */






/* error codes */




/* CL_AFFINITY_DOMAINs */







/* cl_device_partition_property_ext list terminators */





/***********************************
 * cl_ext_migrate_memobject extension definitions
 ***********************************/


typedef cl_bitfield cl_mem_migration_flags_ext;





extern  cl_int __stdcall
clEnqueueMigrateMemObjectEXT(cl_command_queue command_queue,
                             cl_uint          num_mem_objects,
                             const cl_mem *   mem_objects,
                             cl_mem_migration_flags_ext flags,
                             cl_uint          num_events_in_wait_list,
                             const cl_event * event_wait_list,
                             cl_event *       event);

typedef cl_int
(__stdcall *clEnqueueMigrateMemObjectEXT_fn)(cl_command_queue command_queue,
                                               cl_uint          num_mem_objects,
                                               const cl_mem *   mem_objects,
                                               cl_mem_migration_flags_ext flags,
                                               cl_uint          num_events_in_wait_list,
                                               const cl_event * event_wait_list,
                                               cl_event *       event);


/*********************************
* cl_ext_cxx_for_opencl extension
*********************************/




/*********************************
* cl_qcom_ext_host_ptr extension
*********************************/













typedef cl_uint                                   cl_image_pitch_info_qcom;

extern  cl_int __stdcall
clGetDeviceImageInfoQCOM(cl_device_id             device,
                         size_t                   image_width,
                         size_t                   image_height,
                         const cl_image_format   *image_format,
                         cl_image_pitch_info_qcom param_name,
                         size_t                   param_value_size,
                         void                    *param_value,
                         size_t                  *param_value_size_ret);

typedef struct _cl_mem_ext_host_ptr
{
    /* Type of external memory allocation. */
    /* Legal values will be defined in layered extensions. */
    cl_uint  allocation_type;

    /* Host cache policy for this external memory allocation. */
    cl_uint  host_cache_policy;

} cl_mem_ext_host_ptr;


/*******************************************
* cl_qcom_ext_host_ptr_iocoherent extension
********************************************/

/* Cache policy specifying io-coherence */



/*********************************
* cl_qcom_ion_host_ptr extension
*********************************/



typedef struct _cl_mem_ion_host_ptr
{
    /* Type of external memory allocation. */
    /* Must be CL_MEM_ION_HOST_PTR_QCOM for ION allocations. */
    cl_mem_ext_host_ptr  ext_host_ptr;

    /* ION file descriptor */
    int                  ion_filedesc;

    /* Host pointer to the ION allocated memory */
    void*                ion_hostptr;

} cl_mem_ion_host_ptr;


/*********************************
* cl_qcom_android_native_buffer_host_ptr extension
*********************************/



typedef struct _cl_mem_android_native_buffer_host_ptr
{
    /* Type of external memory allocation. */
    /* Must be CL_MEM_ANDROID_NATIVE_BUFFER_HOST_PTR_QCOM for Android native buffers. */
    cl_mem_ext_host_ptr  ext_host_ptr;

    /* Virtual pointer to the android native buffer */
    void*                anb_ptr;

} cl_mem_android_native_buffer_host_ptr;


/******************************************
 * cl_img_yuv_image extension *
 ******************************************/

/* Image formats used in clCreateImage */




/******************************************
 * cl_img_cached_allocations extension *
 ******************************************/

/* Flag values used by clCreateBuffer */




/******************************************
 * cl_img_use_gralloc_ptr extension *
 ******************************************/


/* Flag values used by clCreateBuffer */


/* To be used by clGetEventInfo: */



/* Error codes from clEnqueueAcquireGrallocObjectsIMG and clEnqueueReleaseGrallocObjectsIMG */



extern  cl_int __stdcall
clEnqueueAcquireGrallocObjectsIMG(cl_command_queue      command_queue,
                                  cl_uint               num_objects,
                                  const cl_mem *        mem_objects,
                                  cl_uint               num_events_in_wait_list,
                                  const cl_event *      event_wait_list,
                                  cl_event *            event) ;

extern  cl_int __stdcall
clEnqueueReleaseGrallocObjectsIMG(cl_command_queue      command_queue,
                                  cl_uint               num_objects,
                                  const cl_mem *        mem_objects,
                                  cl_uint               num_events_in_wait_list,
                                  const cl_event *      event_wait_list,
                                  cl_event *            event) ;

/******************************************
 * cl_img_generate_mipmap extension *
 ******************************************/


typedef cl_uint cl_mipmap_filter_mode_img;

/* To be used by clEnqueueGenerateMipmapIMG */



/* To be used by clGetEventInfo */


extern  cl_int __stdcall
clEnqueueGenerateMipmapIMG(cl_command_queue          command_queue,
                           cl_mem                    src_image,
                           cl_mem                    dst_image,
                           cl_mipmap_filter_mode_img mipmap_filter_mode,
                           const size_t              *array_region,
                           const size_t              *mip_region,
                           cl_uint                   num_events_in_wait_list,
                           const cl_event            *event_wait_list,
                           cl_event *event) ;
  
/******************************************
 * cl_img_mem_properties extension *
 ******************************************/


/* To be used by clCreateBufferWithProperties */


/* To be used wiith the CL_MEM_ALLOC_FLAGS_IMG property */
typedef cl_bitfield cl_mem_alloc_flags_img;

/* To be used with cl_mem_alloc_flags_img */


/*********************************
* cl_khr_subgroups extension
*********************************/








#line 1042 "C:\\OpenCL\\include\\CL/cl_ext.h"

/* cl_kernel_sub_group_info */



extern  cl_int __stdcall
clGetKernelSubGroupInfoKHR(cl_kernel    in_kernel,
                           cl_device_id in_device,
                           cl_kernel_sub_group_info param_name,
                           size_t       input_value_size,
                           const void * input_value,
                           size_t       param_value_size,
                           void *       param_value,
                           size_t *     param_value_size_ret)  ;

typedef cl_int
(__stdcall * clGetKernelSubGroupInfoKHR_fn)(cl_kernel    in_kernel,
                                              cl_device_id in_device,
                                              cl_kernel_sub_group_info param_name,
                                              size_t       input_value_size,
                                              const void * input_value,
                                              size_t       param_value_size,
                                              void *       param_value,
                                              size_t *     param_value_size_ret)  ;


/*********************************
* cl_khr_mipmap_image extension
*********************************/

/* cl_sampler_properties */





/*********************************
* cl_khr_priority_hints extension
*********************************/
/* This extension define is for backwards compatibility.
   It shouldn't be required since this extension has no new functions. */


typedef cl_uint  cl_queue_priority_khr;

/* cl_command_queue_properties */


/* cl_queue_priority_khr */





/*********************************
* cl_khr_throttle_hints extension
*********************************/
/* This extension define is for backwards compatibility.
   It shouldn't be required since this extension has no new functions. */


typedef cl_uint  cl_queue_throttle_khr;

/* cl_command_queue_properties */


/* cl_queue_throttle_khr */





/*********************************
* cl_khr_subgroup_named_barrier
*********************************/
/* This extension define is for backwards compatibility.
   It shouldn't be required since this extension has no new functions. */


/* cl_device_info */



/*********************************
* cl_khr_extended_versioning
*********************************/




















typedef cl_uint cl_version_khr;



typedef struct _cl_name_version_khr
{
    cl_version_khr version;
    char name[64];
} cl_name_version_khr;

/* cl_platform_info */



/* cl_device_info */







/*********************************
* cl_khr_device_uuid extension
*********************************/












/***************************************************************
* cl_khr_pci_bus_info
***************************************************************/


typedef struct _cl_device_pci_bus_info_khr {
    cl_uint pci_domain;
    cl_uint pci_bus;
    cl_uint pci_device;
    cl_uint pci_function;
} cl_device_pci_bus_info_khr;

/* cl_device_info */



/***************************************************************
* cl_khr_suggested_local_work_size
***************************************************************/


extern  cl_int __stdcall
clGetKernelSuggestedLocalWorkSizeKHR(
    cl_command_queue command_queue,
    cl_kernel kernel,
    cl_uint work_dim,
    const size_t* global_work_offset,
    const size_t* global_work_size,
    size_t* suggested_local_work_size) ;

typedef cl_int (__stdcall *
clGetKernelSuggestedLocalWorkSizeKHR_fn)(
    cl_command_queue command_queue,
    cl_kernel kernel,
    cl_uint work_dim,
    const size_t* global_work_offset,
    const size_t* global_work_size,
    size_t* suggested_local_work_size) ;


/***************************************************************
* cl_khr_integer_dot_product
***************************************************************/


typedef cl_bitfield         cl_device_integer_dot_product_capabilities_khr;

/* cl_device_integer_dot_product_capabilities_khr */



typedef struct _cl_device_integer_dot_product_acceleration_properties_khr {
    cl_bool signed_accelerated;
    cl_bool unsigned_accelerated;
    cl_bool mixed_signedness_accelerated;
    cl_bool accumulating_saturating_signed_accelerated;
    cl_bool accumulating_saturating_unsigned_accelerated;
    cl_bool accumulating_saturating_mixed_signedness_accelerated;
} cl_device_integer_dot_product_acceleration_properties_khr;

/* cl_device_info */





/***************************************************************
* cl_khr_external_memory
***************************************************************/


typedef cl_uint             cl_external_memory_handle_type_khr;

/* cl_platform_info */


/* cl_device_info */


/* cl_mem_properties */



/* cl_command_type */




typedef cl_int (__stdcall *
clEnqueueAcquireExternalMemObjectsKHR_fn)(
    cl_command_queue command_queue,
    cl_uint num_mem_objects,
    const cl_mem* mem_objects,
    cl_uint num_events_in_wait_list,
    const cl_event* event_wait_list,
    cl_event* event) ;

typedef cl_int (__stdcall *
clEnqueueReleaseExternalMemObjectsKHR_fn)(
    cl_command_queue command_queue,
    cl_uint num_mem_objects,
    const cl_mem* mem_objects,
    cl_uint num_events_in_wait_list,
    const cl_event* event_wait_list,
    cl_event* event) ;

extern  cl_int __stdcall
clEnqueueAcquireExternalMemObjectsKHR(
    cl_command_queue command_queue,
    cl_uint num_mem_objects,
    const cl_mem* mem_objects,
    cl_uint num_events_in_wait_list,
    const cl_event* event_wait_list,
    cl_event* event) ;

extern  cl_int __stdcall
clEnqueueReleaseExternalMemObjectsKHR(
    cl_command_queue command_queue,
    cl_uint num_mem_objects,
    const cl_mem* mem_objects,
    cl_uint num_events_in_wait_list,
    const cl_event* event_wait_list,
    cl_event* event) ;

/***************************************************************
* cl_khr_external_memory_dma_buf
***************************************************************/


/* cl_external_memory_handle_type_khr */


/***************************************************************
* cl_khr_external_memory_dx
***************************************************************/


/* cl_external_memory_handle_type_khr */





/***************************************************************
* cl_khr_external_memory_opaque_fd
***************************************************************/


/* cl_external_memory_handle_type_khr */


/***************************************************************
* cl_khr_external_memory_win32
***************************************************************/


/* cl_external_memory_handle_type_khr */



/***************************************************************
* cl_khr_external_semaphore
***************************************************************/


typedef struct _cl_semaphore_khr * cl_semaphore_khr;
typedef cl_uint             cl_external_semaphore_handle_type_khr;

/* cl_platform_info */



/* cl_device_info */



/* cl_semaphore_properties_khr */




typedef cl_int (__stdcall *
clGetSemaphoreHandleForTypeKHR_fn)(
    cl_semaphore_khr sema_object,
    cl_device_id device,
    cl_external_semaphore_handle_type_khr handle_type,
    size_t handle_size,
    void* handle_ptr,
    size_t* handle_size_ret) ;

extern  cl_int __stdcall
clGetSemaphoreHandleForTypeKHR(
    cl_semaphore_khr sema_object,
    cl_device_id device,
    cl_external_semaphore_handle_type_khr handle_type,
    size_t handle_size,
    void* handle_ptr,
    size_t* handle_size_ret) ;

/***************************************************************
* cl_khr_external_semaphore_dx_fence
***************************************************************/


/* cl_external_semaphore_handle_type_khr */


/***************************************************************
* cl_khr_external_semaphore_opaque_fd
***************************************************************/


/* cl_external_semaphore_handle_type_khr */


/***************************************************************
* cl_khr_external_semaphore_sync_fd
***************************************************************/


/* cl_external_semaphore_handle_type_khr */


/***************************************************************
* cl_khr_external_semaphore_win32
***************************************************************/


/* cl_external_semaphore_handle_type_khr */



/***************************************************************
* cl_khr_semaphore
***************************************************************/


/* type cl_semaphore_khr */
typedef cl_properties       cl_semaphore_properties_khr;
typedef cl_uint             cl_semaphore_info_khr;
typedef cl_uint             cl_semaphore_type_khr;
typedef cl_ulong            cl_semaphore_payload_khr;

/* cl_semaphore_type */


/* cl_platform_info */


/* cl_device_info */


/* cl_semaphore_info_khr */





/* cl_semaphore_info_khr or cl_semaphore_properties_khr */

/* enum CL_DEVICE_HANDLE_LIST_KHR */
/* enum CL_DEVICE_HANDLE_LIST_END_KHR */

/* cl_command_type */



/* Error codes */



typedef cl_semaphore_khr (__stdcall *
clCreateSemaphoreWithPropertiesKHR_fn)(
    cl_context context,
    const cl_semaphore_properties_khr* sema_props,
    cl_int* errcode_ret) ;

typedef cl_int (__stdcall *
clEnqueueWaitSemaphoresKHR_fn)(
    cl_command_queue command_queue,
    cl_uint num_sema_objects,
    const cl_semaphore_khr* sema_objects,
    const cl_semaphore_payload_khr* sema_payload_list,
    cl_uint num_events_in_wait_list,
    const cl_event* event_wait_list,
    cl_event* event) ;

typedef cl_int (__stdcall *
clEnqueueSignalSemaphoresKHR_fn)(
    cl_command_queue command_queue,
    cl_uint num_sema_objects,
    const cl_semaphore_khr* sema_objects,
    const cl_semaphore_payload_khr* sema_payload_list,
    cl_uint num_events_in_wait_list,
    const cl_event* event_wait_list,
    cl_event* event) ;

typedef cl_int (__stdcall *
clGetSemaphoreInfoKHR_fn)(
    cl_semaphore_khr sema_object,
    cl_semaphore_info_khr param_name,
    size_t param_value_size,
    void* param_value,
    size_t* param_value_size_ret) ;

typedef cl_int (__stdcall *
clReleaseSemaphoreKHR_fn)(
    cl_semaphore_khr sema_object) ;

typedef cl_int (__stdcall *
clRetainSemaphoreKHR_fn)(
    cl_semaphore_khr sema_object) ;

extern  cl_semaphore_khr __stdcall
clCreateSemaphoreWithPropertiesKHR(
    cl_context context,
    const cl_semaphore_properties_khr* sema_props,
    cl_int* errcode_ret) ;

extern  cl_int __stdcall
clEnqueueWaitSemaphoresKHR(
    cl_command_queue command_queue,
    cl_uint num_sema_objects,
    const cl_semaphore_khr* sema_objects,
    const cl_semaphore_payload_khr* sema_payload_list,
    cl_uint num_events_in_wait_list,
    const cl_event* event_wait_list,
    cl_event* event) ;

extern  cl_int __stdcall
clEnqueueSignalSemaphoresKHR(
    cl_command_queue command_queue,
    cl_uint num_sema_objects,
    const cl_semaphore_khr* sema_objects,
    const cl_semaphore_payload_khr* sema_payload_list,
    cl_uint num_events_in_wait_list,
    const cl_event* event_wait_list,
    cl_event* event) ;

extern  cl_int __stdcall
clGetSemaphoreInfoKHR(
    cl_semaphore_khr sema_object,
    cl_semaphore_info_khr param_name,
    size_t param_value_size,
    void* param_value,
    size_t* param_value_size_ret) ;

extern  cl_int __stdcall
clReleaseSemaphoreKHR(
    cl_semaphore_khr sema_object) ;

extern  cl_int __stdcall
clRetainSemaphoreKHR(
    cl_semaphore_khr sema_object) ;

/**********************************
 * cl_arm_import_memory extension *
 **********************************/


typedef intptr_t cl_import_properties_arm;

/* Default and valid proporties name for cl_arm_import_memory */


/* Host process memory type default value for CL_IMPORT_TYPE_ARM property */


/* DMA BUF memory type value for CL_IMPORT_TYPE_ARM property */


/* Protected memory property */


/* Android hardware buffer type value for CL_IMPORT_TYPE_ARM property */


/* Data consistency with host property */


/* Index of plane in a multiplanar hardware buffer */


/* Index of layer in a multilayer hardware buffer */


/* Import memory size value to indicate a size for the whole buffer */


/* This extension adds a new function that allows for direct memory import into
 * OpenCL via the clImportMemoryARM function.
 *
 * Memory imported through this interface will be mapped into the device's page
 * tables directly, providing zero copy access. It will never fall back to copy
 * operations and aliased buffers.
 *
 * Types of memory supported for import are specified as additional extension
 * strings.
 *
 * This extension produces cl_mem allocations which are compatible with all other
 * users of cl_mem in the standard API.
 *
 * This extension maps pages with the same properties as the normal buffer creation
 * function clCreateBuffer.
 */
extern  cl_mem __stdcall
clImportMemoryARM( cl_context context,
                   cl_mem_flags flags,
                   const cl_import_properties_arm *properties,
                   void *memory,
                   size_t size,
                   cl_int *errcode_ret) ;


/******************************************
 * cl_arm_shared_virtual_memory extension *
 ******************************************/


/* Used by clGetDeviceInfo */


/* Used by clGetMemObjectInfo */


/* Used by clSetKernelExecInfoARM: */



/* To be used by clGetEventInfo: */






/* Flag values returned by clGetDeviceInfo with CL_DEVICE_SVM_CAPABILITIES_ARM as the param_name. */





/* Flag values used by clSVMAllocARM: */



typedef cl_bitfield cl_svm_mem_flags_arm;
typedef cl_uint     cl_kernel_exec_info_arm;
typedef cl_bitfield cl_device_svm_capabilities_arm;

extern  void * __stdcall
clSVMAllocARM(cl_context       context,
              cl_svm_mem_flags_arm flags,
              size_t           size,
              cl_uint          alignment) ;

extern  void __stdcall
clSVMFreeARM(cl_context        context,
             void *            svm_pointer) ;

extern  cl_int __stdcall
clEnqueueSVMFreeARM(cl_command_queue  command_queue,
                    cl_uint           num_svm_pointers,
                    void *            svm_pointers[],
                    void (__stdcall * pfn_free_func)(cl_command_queue queue,
                                                       cl_uint          num_svm_pointers,
                                                       void *           svm_pointers[],
                                                       void *           user_data),
                    void *            user_data,
                    cl_uint           num_events_in_wait_list,
                    const cl_event *  event_wait_list,
                    cl_event *        event) ;

extern  cl_int __stdcall
clEnqueueSVMMemcpyARM(cl_command_queue  command_queue,
                      cl_bool           blocking_copy,
                      void *            dst_ptr,
                      const void *      src_ptr,
                      size_t            size,
                      cl_uint           num_events_in_wait_list,
                      const cl_event *  event_wait_list,
                      cl_event *        event) ;

extern  cl_int __stdcall
clEnqueueSVMMemFillARM(cl_command_queue  command_queue,
                       void *            svm_ptr,
                       const void *      pattern,
                       size_t            pattern_size,
                       size_t            size,
                       cl_uint           num_events_in_wait_list,
                       const cl_event *  event_wait_list,
                       cl_event *        event) ;

extern  cl_int __stdcall
clEnqueueSVMMapARM(cl_command_queue  command_queue,
                   cl_bool           blocking_map,
                   cl_map_flags      flags,
                   void *            svm_ptr,
                   size_t            size,
                   cl_uint           num_events_in_wait_list,
                   const cl_event *  event_wait_list,
                   cl_event *        event) ;

extern  cl_int __stdcall
clEnqueueSVMUnmapARM(cl_command_queue  command_queue,
                     void *            svm_ptr,
                     cl_uint           num_events_in_wait_list,
                     const cl_event *  event_wait_list,
                     cl_event *        event) ;

extern  cl_int __stdcall
clSetKernelArgSVMPointerARM(cl_kernel    kernel,
                            cl_uint      arg_index,
                            const void * arg_value) ;

extern  cl_int __stdcall
clSetKernelExecInfoARM(cl_kernel            kernel,
                       cl_kernel_exec_info_arm  param_name,
                       size_t               param_value_size,
                       const void *         param_value) ;

/********************************
 * cl_arm_get_core_id extension *
 ********************************/





/* Device info property for bitfield of cores present */


#line 1718 "C:\\OpenCL\\include\\CL/cl_ext.h"

/*********************************
* cl_arm_job_slot_selection
*********************************/



/* cl_device_info */


/* cl_command_queue_properties */


/*********************************
* cl_arm_scheduling_controls
*********************************/



typedef cl_bitfield cl_device_scheduling_controls_capabilities_arm;

/* cl_device_info */













/* cl_kernel_info */


/* cl_kernel_exec_info */





/* cl_queue_properties */



/**************************************
* cl_arm_controlled_kernel_termination
***************************************/



/* Error code to indicate kernel terminated with failure */


/* cl_device_info */


/* Bit fields for controlled termination feature query */
typedef cl_bitfield cl_device_controlled_termination_capabilities_arm;





/* cl_event_info */


/* Values returned for event termination reason query */
typedef cl_uint cl_command_termination_reason_arm;






/*************************************
* cl_arm_protected_memory_allocation *
*************************************/





/******************************************
* cl_intel_exec_by_local_thread extension *
******************************************/





/***************************************************************
* cl_intel_device_attribute_query
***************************************************************/



typedef cl_bitfield         cl_device_feature_capabilities_intel;

/* cl_device_feature_capabilities_intel */



/* cl_device_info */








/***********************************************
* cl_intel_device_partition_by_names extension *
************************************************/






/************************************************
* cl_intel_accelerator extension                *
* cl_intel_motion_estimation extension          *
* cl_intel_advanced_motion_estimation extension *
*************************************************/





typedef struct _cl_accelerator_intel* cl_accelerator_intel;
typedef cl_uint cl_accelerator_type_intel;
typedef cl_uint cl_accelerator_info_intel;

typedef struct _cl_motion_estimation_desc_intel {
    cl_uint mb_block_type;
    cl_uint subpixel_mode;
    cl_uint sad_adjust_mode;
    cl_uint search_path_type;
} cl_motion_estimation_desc_intel;

/* error codes */





/* cl_accelerator_type_intel */


/* cl_accelerator_info_intel */





/* cl_motion_detect_desc_intel flags */

























































/* cl_device_info */






extern  cl_accelerator_intel __stdcall
clCreateAcceleratorINTEL(
    cl_context                   context,
    cl_accelerator_type_intel    accelerator_type,
    size_t                       descriptor_size,
    const void*                  descriptor,
    cl_int*                      errcode_ret) ;

typedef cl_accelerator_intel (__stdcall *clCreateAcceleratorINTEL_fn)(
    cl_context                   context,
    cl_accelerator_type_intel    accelerator_type,
    size_t                       descriptor_size,
    const void*                  descriptor,
    cl_int*                      errcode_ret) ;

extern  cl_int __stdcall
clGetAcceleratorInfoINTEL(
    cl_accelerator_intel         accelerator,
    cl_accelerator_info_intel    param_name,
    size_t                       param_value_size,
    void*                        param_value,
    size_t*                      param_value_size_ret) ;

typedef cl_int (__stdcall *clGetAcceleratorInfoINTEL_fn)(
    cl_accelerator_intel         accelerator,
    cl_accelerator_info_intel    param_name,
    size_t                       param_value_size,
    void*                        param_value,
    size_t*                      param_value_size_ret) ;

extern  cl_int __stdcall
clRetainAcceleratorINTEL(
    cl_accelerator_intel         accelerator) ;

typedef cl_int (__stdcall *clRetainAcceleratorINTEL_fn)(
    cl_accelerator_intel         accelerator) ;

extern  cl_int __stdcall
clReleaseAcceleratorINTEL(
    cl_accelerator_intel         accelerator) ;

typedef cl_int (__stdcall *clReleaseAcceleratorINTEL_fn)(
    cl_accelerator_intel         accelerator) ;

/******************************************
* cl_intel_simultaneous_sharing extension *
*******************************************/






/***********************************
* cl_intel_egl_image_yuv extension *
************************************/





/********************************
* cl_intel_packed_yuv extension *
*********************************/








/********************************************
* cl_intel_required_subgroup_size extension *
*********************************************/







/****************************************
* cl_intel_driver_diagnostics extension *
*****************************************/



typedef cl_uint cl_diagnostics_verbose_level;








/********************************
* cl_intel_planar_yuv extension *
*********************************/









/*******************************************************
* cl_intel_device_side_avc_motion_estimation extension *
********************************************************/































































































































/*******************************************
* cl_intel_unified_shared_memory extension *
********************************************/


typedef cl_bitfield         cl_device_unified_shared_memory_capabilities_intel;
typedef cl_properties 		cl_mem_properties_intel;
typedef cl_bitfield         cl_mem_alloc_flags_intel;
typedef cl_uint             cl_mem_info_intel;
typedef cl_uint             cl_unified_shared_memory_type_intel;
typedef cl_uint             cl_mem_advice_intel;

/* cl_device_info */






/* cl_device_unified_shared_memory_capabilities_intel - bitfield */





/* cl_mem_properties_intel */


/* cl_mem_alloc_flags_intel - bitfield */




/* cl_mem_alloc_info_intel */





/* cl_unified_shared_memory_type_intel */





/* cl_kernel_exec_info */





/* cl_command_type */






typedef void* (__stdcall *
clHostMemAllocINTEL_fn)(
    cl_context context,
    const cl_mem_properties_intel* properties,
    size_t size,
    cl_uint alignment,
    cl_int* errcode_ret) ;

typedef void* (__stdcall *
clDeviceMemAllocINTEL_fn)(
    cl_context context,
    cl_device_id device,
    const cl_mem_properties_intel* properties,
    size_t size,
    cl_uint alignment,
    cl_int* errcode_ret) ;

typedef void* (__stdcall *
clSharedMemAllocINTEL_fn)(
    cl_context context,
    cl_device_id device,
    const cl_mem_properties_intel* properties,
    size_t size,
    cl_uint alignment,
    cl_int* errcode_ret) ;

typedef cl_int (__stdcall *
clMemFreeINTEL_fn)(
    cl_context context,
    void* ptr) ;

typedef cl_int (__stdcall *
clMemBlockingFreeINTEL_fn)(
    cl_context context,
    void* ptr) ;

typedef cl_int (__stdcall *
clGetMemAllocInfoINTEL_fn)(
    cl_context context,
    const void* ptr,
    cl_mem_info_intel param_name,
    size_t param_value_size,
    void* param_value,
    size_t* param_value_size_ret) ;

typedef cl_int (__stdcall *
clSetKernelArgMemPointerINTEL_fn)(
    cl_kernel kernel,
    cl_uint arg_index,
    const void* arg_value) ;

typedef cl_int (__stdcall *
clEnqueueMemFillINTEL_fn)(
    cl_command_queue command_queue,
    void* dst_ptr,
    const void* pattern,
    size_t pattern_size,
    size_t size,
    cl_uint num_events_in_wait_list,
    const cl_event* event_wait_list,
    cl_event* event) ;

typedef cl_int (__stdcall *
clEnqueueMemcpyINTEL_fn)(
    cl_command_queue command_queue,
    cl_bool blocking,
    void* dst_ptr,
    const void* src_ptr,
    size_t size,
    cl_uint num_events_in_wait_list,
    const cl_event* event_wait_list,
    cl_event* event) ;

typedef cl_int (__stdcall *
clEnqueueMemAdviseINTEL_fn)(
    cl_command_queue command_queue,
    const void* ptr,
    size_t size,
    cl_mem_advice_intel advice,
    cl_uint num_events_in_wait_list,
    const cl_event* event_wait_list,
    cl_event* event) ;



extern  void* __stdcall
clHostMemAllocINTEL(
    cl_context context,
    const cl_mem_properties_intel* properties,
    size_t size,
    cl_uint alignment,
    cl_int* errcode_ret) ;

extern  void* __stdcall
clDeviceMemAllocINTEL(
    cl_context context,
    cl_device_id device,
    const cl_mem_properties_intel* properties,
    size_t size,
    cl_uint alignment,
    cl_int* errcode_ret) ;

extern  void* __stdcall
clSharedMemAllocINTEL(
    cl_context context,
    cl_device_id device,
    const cl_mem_properties_intel* properties,
    size_t size,
    cl_uint alignment,
    cl_int* errcode_ret) ;

extern  cl_int __stdcall
clMemFreeINTEL(
    cl_context context,
    void* ptr) ;

extern  cl_int __stdcall
clMemBlockingFreeINTEL(
    cl_context context,
    void* ptr) ;

extern  cl_int __stdcall
clGetMemAllocInfoINTEL(
    cl_context context,
    const void* ptr,
    cl_mem_info_intel param_name,
    size_t param_value_size,
    void* param_value,
    size_t* param_value_size_ret) ;

extern  cl_int __stdcall
clSetKernelArgMemPointerINTEL(
    cl_kernel kernel,
    cl_uint arg_index,
    const void* arg_value) ;

extern  cl_int __stdcall
clEnqueueMemFillINTEL(
    cl_command_queue command_queue,
    void* dst_ptr,
    const void* pattern,
    size_t pattern_size,
    size_t size,
    cl_uint num_events_in_wait_list,
    const cl_event* event_wait_list,
    cl_event* event) ;

extern  cl_int __stdcall
clEnqueueMemcpyINTEL(
    cl_command_queue command_queue,
    cl_bool blocking,
    void* dst_ptr,
    const void* src_ptr,
    size_t size,
    cl_uint num_events_in_wait_list,
    const cl_event* event_wait_list,
    cl_event* event) ;

extern  cl_int __stdcall
clEnqueueMemAdviseINTEL(
    cl_command_queue command_queue,
    const void* ptr,
    size_t size,
    cl_mem_advice_intel advice,
    cl_uint num_events_in_wait_list,
    const cl_event* event_wait_list,
    cl_event* event) ;

#line 2409 "C:\\OpenCL\\include\\CL/cl_ext.h"


/* Requires OpenCL 1.2 for cl_mem_migration_flags: */

typedef cl_int (__stdcall *
clEnqueueMigrateMemINTEL_fn)(
    cl_command_queue command_queue,
    const void* ptr,
    size_t size,
    cl_mem_migration_flags flags,
    cl_uint num_events_in_wait_list,
    const cl_event* event_wait_list,
    cl_event* event) ;



extern  cl_int __stdcall
clEnqueueMigrateMemINTEL(
    cl_command_queue command_queue,
    const void* ptr,
    size_t size,
    cl_mem_migration_flags flags,
    cl_uint num_events_in_wait_list,
    const cl_event* event_wait_list,
    cl_event* event) ;

#line 2436 "C:\\OpenCL\\include\\CL/cl_ext.h"

#line 2438 "C:\\OpenCL\\include\\CL/cl_ext.h"

/* deprecated, use clEnqueueMemFillINTEL instead */

typedef cl_int (__stdcall *
clEnqueueMemsetINTEL_fn)(
    cl_command_queue command_queue,
    void* dst_ptr,
    cl_int value,
    size_t size,
    cl_uint num_events_in_wait_list,
    const cl_event* event_wait_list,
    cl_event* event) ;



extern  cl_int __stdcall
clEnqueueMemsetINTEL(
    cl_command_queue command_queue,
    void* dst_ptr,
    cl_int value,
    size_t size,
    cl_uint num_events_in_wait_list,
    const cl_event* event_wait_list,
    cl_event* event) ;

#line 2464 "C:\\OpenCL\\include\\CL/cl_ext.h"

/***************************************************************
* cl_intel_mem_alloc_buffer_location
***************************************************************/




/* cl_mem_properties_intel */


/* cl_mem_alloc_info_intel */
/* enum CL_MEM_ALLOC_BUFFER_LOCATION_INTEL */

/***************************************************
* cl_intel_create_buffer_with_properties extension *
****************************************************/



extern  cl_mem __stdcall
clCreateBufferWithPropertiesINTEL(
    cl_context   context,
    const cl_mem_properties_intel* properties,
    cl_mem_flags flags,
    size_t       size,
    void *       host_ptr,
    cl_int *     errcode_ret) ;

typedef cl_mem (__stdcall *
clCreateBufferWithPropertiesINTEL_fn)(
    cl_context   context,
    const cl_mem_properties_intel* properties,
    cl_mem_flags flags,
    size_t       size,
    void *       host_ptr,
    cl_int *     errcode_ret) ;

/******************************************
* cl_intel_mem_channel_property extension *
*******************************************/



/*********************************
* cl_intel_mem_force_host_memory *
**********************************/



/* cl_mem_flags */


/***************************************************************
* cl_intel_command_queue_families
***************************************************************/


typedef cl_bitfield         cl_command_queue_capabilities_intel;



typedef struct _cl_queue_family_properties_intel {
    cl_command_queue_properties properties;
    cl_command_queue_capabilities_intel capabilities;
    cl_uint count;
    char name[64];
} cl_queue_family_properties_intel;

/* cl_device_info */


/* cl_queue_properties */



/* cl_command_queue_capabilities_intel */


















/***************************************************************
* cl_intel_queue_no_sync_operations
***************************************************************/



/* addition to cl_command_queue_properties */

    
/***************************************************************
* cl_intel_sharing_format_query
***************************************************************/


/***************************************************************
* cl_ext_image_requirements_info
***************************************************************/





typedef cl_uint cl_image_requirements_info_ext;









extern  cl_int __stdcall
clGetImageRequirementsInfoEXT(
    cl_context                     context,
    const cl_mem_properties*       properties,
    cl_mem_flags                   flags,
    const cl_image_format*         image_format,
    const cl_image_desc*           image_desc,
    cl_image_requirements_info_ext param_name,
    size_t  param_value_size,
    void*   param_value,
    size_t* param_value_size_ret) ;

typedef cl_int (__stdcall *
clGetImageRequirementsInfoEXT_fn)(
    cl_context                     context,
    const cl_mem_properties*       properties,
    cl_mem_flags                   flags,
    const cl_image_format*         image_format,
    const cl_image_desc*           image_desc,
    cl_image_requirements_info_ext param_name,
    size_t  param_value_size,
    void*   param_value,
    size_t* param_value_size_ret) ;

#line 2616 "C:\\OpenCL\\include\\CL/cl_ext.h"

/***************************************************************
* cl_ext_image_from_buffer
***************************************************************/







#line 2628 "C:\\OpenCL\\include\\CL/cl_ext.h"






#line 2635 "C:\\OpenCL\\include\\CL/cl_ext.h"
#line 27 "C:\\OpenCL\\include\\CL/opencl.h"





#line 33 "C:\\OpenCL\\include\\CL/opencl.h"
#line 23 "C:\\OpenCL\\CLBlast-1.5.2-Windows-x64\\include\\clblast_c.h"
#line 24 "C:\\OpenCL\\CLBlast-1.5.2-Windows-x64\\include\\clblast_c.h"

// Exports library functions under Windows when building a DLL. See also:
// https://msdn.microsoft.com/en-us/library/a90k134d.aspx






#line 34 "C:\\OpenCL\\CLBlast-1.5.2-Windows-x64\\include\\clblast_c.h"
  
#line 36 "C:\\OpenCL\\CLBlast-1.5.2-Windows-x64\\include\\clblast_c.h"

// Version numbering (v1.5.1)




// The C interface




// =================================================================================================

// Status codes. These codes can be returned by functions declared in this header file. The error
// codes match either the standard OpenCL error codes or the clBLAS error codes. 
typedef enum CLBlastStatusCode_ {

  // Status codes in common with the OpenCL standard
  CLBlastSuccess                   =   0, // CL_SUCCESS
  CLBlastOpenCLCompilerNotAvailable=  -3, // CL_COMPILER_NOT_AVAILABLE
  CLBlastTempBufferAllocFailure    =  -4, // CL_MEM_OBJECT_ALLOCATION_FAILURE
  CLBlastOpenCLOutOfResources      =  -5, // CL_OUT_OF_RESOURCES
  CLBlastOpenCLOutOfHostMemory     =  -6, // CL_OUT_OF_HOST_MEMORY
  CLBlastOpenCLBuildProgramFailure = -11, // CL_BUILD_PROGRAM_FAILURE: OpenCL compilation error
  CLBlastInvalidValue              = -30, // CL_INVALID_VALUE
  CLBlastInvalidCommandQueue       = -36, // CL_INVALID_COMMAND_QUEUE
  CLBlastInvalidMemObject          = -38, // CL_INVALID_MEM_OBJECT
  CLBlastInvalidBinary             = -42, // CL_INVALID_BINARY
  CLBlastInvalidBuildOptions       = -43, // CL_INVALID_BUILD_OPTIONS
  CLBlastInvalidProgram            = -44, // CL_INVALID_PROGRAM
  CLBlastInvalidProgramExecutable  = -45, // CL_INVALID_PROGRAM_EXECUTABLE
  CLBlastInvalidKernelName         = -46, // CL_INVALID_KERNEL_NAME
  CLBlastInvalidKernelDefinition   = -47, // CL_INVALID_KERNEL_DEFINITION
  CLBlastInvalidKernel             = -48, // CL_INVALID_KERNEL
  CLBlastInvalidArgIndex           = -49, // CL_INVALID_ARG_INDEX
  CLBlastInvalidArgValue           = -50, // CL_INVALID_ARG_VALUE
  CLBlastInvalidArgSize            = -51, // CL_INVALID_ARG_SIZE
  CLBlastInvalidKernelArgs         = -52, // CL_INVALID_KERNEL_ARGS
  CLBlastInvalidLocalNumDimensions = -53, // CL_INVALID_WORK_DIMENSION: Too many thread dimensions
  CLBlastInvalidLocalThreadsTotal  = -54, // CL_INVALID_WORK_GROUP_SIZE: Too many threads in total
  CLBlastInvalidLocalThreadsDim    = -55, // CL_INVALID_WORK_ITEM_SIZE: ... or for a specific dimension
  CLBlastInvalidGlobalOffset       = -56, // CL_INVALID_GLOBAL_OFFSET
  CLBlastInvalidEventWaitList      = -57, // CL_INVALID_EVENT_WAIT_LIST
  CLBlastInvalidEvent              = -58, // CL_INVALID_EVENT
  CLBlastInvalidOperation          = -59, // CL_INVALID_OPERATION
  CLBlastInvalidBufferSize         = -61, // CL_INVALID_BUFFER_SIZE
  CLBlastInvalidGlobalWorkSize     = -63, // CL_INVALID_GLOBAL_WORK_SIZE

  // Status codes in common with the clBLAS library
  CLBlastNotImplemented            = -1024, // Routine or functionality not implemented yet
  CLBlastInvalidMatrixA            = -1022, // Matrix A is not a valid OpenCL buffer
  CLBlastInvalidMatrixB            = -1021, // Matrix B is not a valid OpenCL buffer
  CLBlastInvalidMatrixC            = -1020, // Matrix C is not a valid OpenCL buffer
  CLBlastInvalidVectorX            = -1019, // Vector X is not a valid OpenCL buffer
  CLBlastInvalidVectorY            = -1018, // Vector Y is not a valid OpenCL buffer
  CLBlastInvalidDimension          = -1017, // Dimensions M, N, and K have to be larger than zero
  CLBlastInvalidLeadDimA           = -1016, // LD of A is smaller than the matrix's first dimension
  CLBlastInvalidLeadDimB           = -1015, // LD of B is smaller than the matrix's first dimension
  CLBlastInvalidLeadDimC           = -1014, // LD of C is smaller than the matrix's first dimension
  CLBlastInvalidIncrementX         = -1013, // Increment of vector X cannot be zero
  CLBlastInvalidIncrementY         = -1012, // Increment of vector Y cannot be zero
  CLBlastInsufficientMemoryA       = -1011, // Matrix A's OpenCL buffer is too small
  CLBlastInsufficientMemoryB       = -1010, // Matrix B's OpenCL buffer is too small
  CLBlastInsufficientMemoryC       = -1009, // Matrix C's OpenCL buffer is too small
  CLBlastInsufficientMemoryX       = -1008, // Vector X's OpenCL buffer is too small
  CLBlastInsufficientMemoryY       = -1007, // Vector Y's OpenCL buffer is too small

  // Custom additional status codes for CLBlast
  CLBlastInsufficientMemoryTemp    = -2050, // Temporary buffer provided to GEMM routine is too small
  CLBlastInvalidBatchCount         = -2049, // The batch count needs to be positive
  CLBlastInvalidOverrideKernel     = -2048, // Trying to override parameters for an invalid kernel
  CLBlastMissingOverrideParameter  = -2047, // Missing override parameter(s) for the target kernel
  CLBlastInvalidLocalMemUsage      = -2046, // Not enough local memory available on this device
  CLBlastNoHalfPrecision           = -2045, // Half precision (16-bits) not supported by the device
  CLBlastNoDoublePrecision         = -2044, // Double precision (64-bits) not supported by the device
  CLBlastInvalidVectorScalar       = -2043, // The unit-sized vector is not a valid OpenCL buffer
  CLBlastInsufficientMemoryScalar  = -2042, // The unit-sized vector's OpenCL buffer is too small
  CLBlastDatabaseError             = -2041, // Entry for the device was not found in the database
  CLBlastUnknownError              = -2040, // A catch-all error code representing an unspecified error
  CLBlastUnexpectedError           = -2039, // A catch-all error code representing an unexpected exception
} CLBlastStatusCode;

// Matrix layout and transpose types
typedef enum CLBlastLayout_ { CLBlastLayoutRowMajor = 101,
                              CLBlastLayoutColMajor = 102 } CLBlastLayout;
typedef enum CLBlastTranspose_ { CLBlastTransposeNo = 111, CLBlastTransposeYes = 112,
                                 CLBlastTransposeConjugate = 113 } CLBlastTranspose;
typedef enum CLBlastTriangle_ { CLBlastTriangleUpper = 121,
                                CLBlastTriangleLower = 122 } CLBlastTriangle;
typedef enum CLBlastDiagonal_ { CLBlastDiagonalNonUnit = 131,
                                CLBlastDiagonalUnit = 132 } CLBlastDiagonal;
typedef enum CLBlastSide_ { CLBlastSideLeft = 141, CLBlastSideRight = 142 } CLBlastSide;
typedef enum CLBlastKernelMode_ { CLBlastKernelModeCrossCorrelation = 151, CLBlastKernelModeConvolution = 152 } CLBlastKernelMode;

// Precision enum (values in bits)
typedef enum CLBlastPrecision_ { CLBlastPrecisionHalf = 16, CLBlastPrecisionSingle = 32,
                                 CLBlastPrecisionDouble = 64, CLBlastPrecisionComplexSingle = 3232,
                                 CLBlastPrecisionComplexDouble = 6464 } CLBlastPrecision;

// =================================================================================================
// BLAS level-1 (vector-vector) routines
// =================================================================================================

// Generate givens plane rotation: SROTG/DROTG
CLBlastStatusCode  CLBlastSrotg(cl_mem sa_buffer, const size_t sa_offset,
                                          cl_mem sb_buffer, const size_t sb_offset,
                                          cl_mem sc_buffer, const size_t sc_offset,
                                          cl_mem ss_buffer, const size_t ss_offset,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDrotg(cl_mem sa_buffer, const size_t sa_offset,
                                          cl_mem sb_buffer, const size_t sb_offset,
                                          cl_mem sc_buffer, const size_t sc_offset,
                                          cl_mem ss_buffer, const size_t ss_offset,
                                          cl_command_queue* queue, cl_event* event);

// Generate modified givens plane rotation: SROTMG/DROTMG
CLBlastStatusCode  CLBlastSrotmg(cl_mem sd1_buffer, const size_t sd1_offset,
                                           cl_mem sd2_buffer, const size_t sd2_offset,
                                           cl_mem sx1_buffer, const size_t sx1_offset,
                                           const cl_mem sy1_buffer, const size_t sy1_offset,
                                           cl_mem sparam_buffer, const size_t sparam_offset,
                                           cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDrotmg(cl_mem sd1_buffer, const size_t sd1_offset,
                                           cl_mem sd2_buffer, const size_t sd2_offset,
                                           cl_mem sx1_buffer, const size_t sx1_offset,
                                           const cl_mem sy1_buffer, const size_t sy1_offset,
                                           cl_mem sparam_buffer, const size_t sparam_offset,
                                           cl_command_queue* queue, cl_event* event);

// Apply givens plane rotation: SROT/DROT
CLBlastStatusCode  CLBlastSrot(const size_t n,
                                         cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                         cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                         const float cos,
                                         const float sin,
                                         cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDrot(const size_t n,
                                         cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                         cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                         const double cos,
                                         const double sin,
                                         cl_command_queue* queue, cl_event* event);

// Apply modified givens plane rotation: SROTM/DROTM
CLBlastStatusCode  CLBlastSrotm(const size_t n,
                                          cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_mem sparam_buffer, const size_t sparam_offset,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDrotm(const size_t n,
                                          cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_mem sparam_buffer, const size_t sparam_offset,
                                          cl_command_queue* queue, cl_event* event);

// Swap two vectors: SSWAP/DSWAP/CSWAP/ZSWAP/HSWAP
CLBlastStatusCode  CLBlastSswap(const size_t n,
                                          cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDswap(const size_t n,
                                          cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastCswap(const size_t n,
                                          cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastZswap(const size_t n,
                                          cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastHswap(const size_t n,
                                          cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);

// Vector scaling: SSCAL/DSCAL/CSCAL/ZSCAL/HSCAL
CLBlastStatusCode  CLBlastSscal(const size_t n,
                                          const float alpha,
                                          cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDscal(const size_t n,
                                          const double alpha,
                                          cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastCscal(const size_t n,
                                          const cl_float2 alpha,
                                          cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastZscal(const size_t n,
                                          const cl_double2 alpha,
                                          cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastHscal(const size_t n,
                                          const cl_half alpha,
                                          cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);

// Vector copy: SCOPY/DCOPY/CCOPY/ZCOPY/HCOPY
CLBlastStatusCode  CLBlastScopy(const size_t n,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDcopy(const size_t n,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastCcopy(const size_t n,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastZcopy(const size_t n,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastHcopy(const size_t n,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);

// Vector-times-constant plus vector: SAXPY/DAXPY/CAXPY/ZAXPY/HAXPY
CLBlastStatusCode  CLBlastSaxpy(const size_t n,
                                          const float alpha,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDaxpy(const size_t n,
                                          const double alpha,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastCaxpy(const size_t n,
                                          const cl_float2 alpha,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastZaxpy(const size_t n,
                                          const cl_double2 alpha,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastHaxpy(const size_t n,
                                          const cl_half alpha,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);

// Dot product of two vectors: SDOT/DDOT/HDOT
CLBlastStatusCode  CLBlastSdot(const size_t n,
                                         cl_mem dot_buffer, const size_t dot_offset,
                                         const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                         const cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                         cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDdot(const size_t n,
                                         cl_mem dot_buffer, const size_t dot_offset,
                                         const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                         const cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                         cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastHdot(const size_t n,
                                         cl_mem dot_buffer, const size_t dot_offset,
                                         const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                         const cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                         cl_command_queue* queue, cl_event* event);

// Dot product of two complex vectors: CDOTU/ZDOTU
CLBlastStatusCode  CLBlastCdotu(const size_t n,
                                          cl_mem dot_buffer, const size_t dot_offset,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastZdotu(const size_t n,
                                          cl_mem dot_buffer, const size_t dot_offset,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);

// Dot product of two complex vectors, one conjugated: CDOTC/ZDOTC
CLBlastStatusCode  CLBlastCdotc(const size_t n,
                                          cl_mem dot_buffer, const size_t dot_offset,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastZdotc(const size_t n,
                                          cl_mem dot_buffer, const size_t dot_offset,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);

// Euclidian norm of a vector: SNRM2/DNRM2/ScNRM2/DzNRM2/HNRM2
CLBlastStatusCode  CLBlastSnrm2(const size_t n,
                                          cl_mem nrm2_buffer, const size_t nrm2_offset,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDnrm2(const size_t n,
                                          cl_mem nrm2_buffer, const size_t nrm2_offset,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastScnrm2(const size_t n,
                                          cl_mem nrm2_buffer, const size_t nrm2_offset,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDznrm2(const size_t n,
                                          cl_mem nrm2_buffer, const size_t nrm2_offset,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastHnrm2(const size_t n,
                                          cl_mem nrm2_buffer, const size_t nrm2_offset,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);

// Absolute sum of values in a vector: SASUM/DASUM/ScASUM/DzASUM/HASUM
CLBlastStatusCode  CLBlastSasum(const size_t n,
                                          cl_mem asum_buffer, const size_t asum_offset,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDasum(const size_t n,
                                          cl_mem asum_buffer, const size_t asum_offset,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastScasum(const size_t n,
                                          cl_mem asum_buffer, const size_t asum_offset,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDzasum(const size_t n,
                                          cl_mem asum_buffer, const size_t asum_offset,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastHasum(const size_t n,
                                          cl_mem asum_buffer, const size_t asum_offset,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);

// Sum of values in a vector (non-BLAS function): SSUM/DSUM/ScSUM/DzSUM/HSUM
CLBlastStatusCode  CLBlastSsum(const size_t n,
                                         cl_mem sum_buffer, const size_t sum_offset,
                                         const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                         cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDsum(const size_t n,
                                         cl_mem sum_buffer, const size_t sum_offset,
                                         const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                         cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastScsum(const size_t n,
                                         cl_mem sum_buffer, const size_t sum_offset,
                                         const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                         cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDzsum(const size_t n,
                                         cl_mem sum_buffer, const size_t sum_offset,
                                         const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                         cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastHsum(const size_t n,
                                         cl_mem sum_buffer, const size_t sum_offset,
                                         const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                         cl_command_queue* queue, cl_event* event);

// Index of absolute maximum value in a vector: iSAMAX/iDAMAX/iCAMAX/iZAMAX/iHAMAX
CLBlastStatusCode  CLBlastiSamax(const size_t n,
                                          cl_mem imax_buffer, const size_t imax_offset,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastiDamax(const size_t n,
                                          cl_mem imax_buffer, const size_t imax_offset,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastiCamax(const size_t n,
                                          cl_mem imax_buffer, const size_t imax_offset,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastiZamax(const size_t n,
                                          cl_mem imax_buffer, const size_t imax_offset,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastiHamax(const size_t n,
                                          cl_mem imax_buffer, const size_t imax_offset,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);

// Index of absolute minimum value in a vector (non-BLAS function): iSAMIN/iDAMIN/iCAMIN/iZAMIN/iHAMIN
CLBlastStatusCode  CLBlastiSamin(const size_t n,
                                          cl_mem imin_buffer, const size_t imin_offset,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastiDamin(const size_t n,
                                          cl_mem imin_buffer, const size_t imin_offset,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastiCamin(const size_t n,
                                          cl_mem imin_buffer, const size_t imin_offset,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastiZamin(const size_t n,
                                          cl_mem imin_buffer, const size_t imin_offset,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastiHamin(const size_t n,
                                          cl_mem imin_buffer, const size_t imin_offset,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);

// Index of maximum value in a vector (non-BLAS function): iSMAX/iDMAX/iCMAX/iZMAX/iHMAX
CLBlastStatusCode  CLBlastiSmax(const size_t n,
                                         cl_mem imax_buffer, const size_t imax_offset,
                                         const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                         cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastiDmax(const size_t n,
                                         cl_mem imax_buffer, const size_t imax_offset,
                                         const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                         cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastiCmax(const size_t n,
                                         cl_mem imax_buffer, const size_t imax_offset,
                                         const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                         cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastiZmax(const size_t n,
                                         cl_mem imax_buffer, const size_t imax_offset,
                                         const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                         cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastiHmax(const size_t n,
                                         cl_mem imax_buffer, const size_t imax_offset,
                                         const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                         cl_command_queue* queue, cl_event* event);

// Index of minimum value in a vector (non-BLAS function): iSMIN/iDMIN/iCMIN/iZMIN/iHMIN
CLBlastStatusCode  CLBlastiSmin(const size_t n,
                                         cl_mem imin_buffer, const size_t imin_offset,
                                         const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                         cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastiDmin(const size_t n,
                                         cl_mem imin_buffer, const size_t imin_offset,
                                         const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                         cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastiCmin(const size_t n,
                                         cl_mem imin_buffer, const size_t imin_offset,
                                         const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                         cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastiZmin(const size_t n,
                                         cl_mem imin_buffer, const size_t imin_offset,
                                         const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                         cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastiHmin(const size_t n,
                                         cl_mem imin_buffer, const size_t imin_offset,
                                         const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                         cl_command_queue* queue, cl_event* event);

// =================================================================================================
// BLAS level-2 (matrix-vector) routines
// =================================================================================================

// General matrix-vector multiplication: SGEMV/DGEMV/CGEMV/ZGEMV/HGEMV
CLBlastStatusCode  CLBlastSgemv(const CLBlastLayout layout, const CLBlastTranspose a_transpose,
                                          const size_t m, const size_t n,
                                          const float alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const float beta,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDgemv(const CLBlastLayout layout, const CLBlastTranspose a_transpose,
                                          const size_t m, const size_t n,
                                          const double alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const double beta,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastCgemv(const CLBlastLayout layout, const CLBlastTranspose a_transpose,
                                          const size_t m, const size_t n,
                                          const cl_float2 alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const cl_float2 beta,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastZgemv(const CLBlastLayout layout, const CLBlastTranspose a_transpose,
                                          const size_t m, const size_t n,
                                          const cl_double2 alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const cl_double2 beta,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastHgemv(const CLBlastLayout layout, const CLBlastTranspose a_transpose,
                                          const size_t m, const size_t n,
                                          const cl_half alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const cl_half beta,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);

// General banded matrix-vector multiplication: SGBMV/DGBMV/CGBMV/ZGBMV/HGBMV
CLBlastStatusCode  CLBlastSgbmv(const CLBlastLayout layout, const CLBlastTranspose a_transpose,
                                          const size_t m, const size_t n, const size_t kl, const size_t ku,
                                          const float alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const float beta,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDgbmv(const CLBlastLayout layout, const CLBlastTranspose a_transpose,
                                          const size_t m, const size_t n, const size_t kl, const size_t ku,
                                          const double alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const double beta,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastCgbmv(const CLBlastLayout layout, const CLBlastTranspose a_transpose,
                                          const size_t m, const size_t n, const size_t kl, const size_t ku,
                                          const cl_float2 alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const cl_float2 beta,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastZgbmv(const CLBlastLayout layout, const CLBlastTranspose a_transpose,
                                          const size_t m, const size_t n, const size_t kl, const size_t ku,
                                          const cl_double2 alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const cl_double2 beta,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastHgbmv(const CLBlastLayout layout, const CLBlastTranspose a_transpose,
                                          const size_t m, const size_t n, const size_t kl, const size_t ku,
                                          const cl_half alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const cl_half beta,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);

// Hermitian matrix-vector multiplication: CHEMV/ZHEMV
CLBlastStatusCode  CLBlastChemv(const CLBlastLayout layout, const CLBlastTriangle triangle,
                                          const size_t n,
                                          const cl_float2 alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const cl_float2 beta,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastZhemv(const CLBlastLayout layout, const CLBlastTriangle triangle,
                                          const size_t n,
                                          const cl_double2 alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const cl_double2 beta,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);

// Hermitian banded matrix-vector multiplication: CHBMV/ZHBMV
CLBlastStatusCode  CLBlastChbmv(const CLBlastLayout layout, const CLBlastTriangle triangle,
                                          const size_t n, const size_t k,
                                          const cl_float2 alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const cl_float2 beta,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastZhbmv(const CLBlastLayout layout, const CLBlastTriangle triangle,
                                          const size_t n, const size_t k,
                                          const cl_double2 alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const cl_double2 beta,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);

// Hermitian packed matrix-vector multiplication: CHPMV/ZHPMV
CLBlastStatusCode  CLBlastChpmv(const CLBlastLayout layout, const CLBlastTriangle triangle,
                                          const size_t n,
                                          const cl_float2 alpha,
                                          const cl_mem ap_buffer, const size_t ap_offset,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const cl_float2 beta,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastZhpmv(const CLBlastLayout layout, const CLBlastTriangle triangle,
                                          const size_t n,
                                          const cl_double2 alpha,
                                          const cl_mem ap_buffer, const size_t ap_offset,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const cl_double2 beta,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);

// Symmetric matrix-vector multiplication: SSYMV/DSYMV/HSYMV
CLBlastStatusCode  CLBlastSsymv(const CLBlastLayout layout, const CLBlastTriangle triangle,
                                          const size_t n,
                                          const float alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const float beta,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDsymv(const CLBlastLayout layout, const CLBlastTriangle triangle,
                                          const size_t n,
                                          const double alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const double beta,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastHsymv(const CLBlastLayout layout, const CLBlastTriangle triangle,
                                          const size_t n,
                                          const cl_half alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const cl_half beta,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);

// Symmetric banded matrix-vector multiplication: SSBMV/DSBMV/HSBMV
CLBlastStatusCode  CLBlastSsbmv(const CLBlastLayout layout, const CLBlastTriangle triangle,
                                          const size_t n, const size_t k,
                                          const float alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const float beta,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDsbmv(const CLBlastLayout layout, const CLBlastTriangle triangle,
                                          const size_t n, const size_t k,
                                          const double alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const double beta,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastHsbmv(const CLBlastLayout layout, const CLBlastTriangle triangle,
                                          const size_t n, const size_t k,
                                          const cl_half alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const cl_half beta,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);

// Symmetric packed matrix-vector multiplication: SSPMV/DSPMV/HSPMV
CLBlastStatusCode  CLBlastSspmv(const CLBlastLayout layout, const CLBlastTriangle triangle,
                                          const size_t n,
                                          const float alpha,
                                          const cl_mem ap_buffer, const size_t ap_offset,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const float beta,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDspmv(const CLBlastLayout layout, const CLBlastTriangle triangle,
                                          const size_t n,
                                          const double alpha,
                                          const cl_mem ap_buffer, const size_t ap_offset,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const double beta,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastHspmv(const CLBlastLayout layout, const CLBlastTriangle triangle,
                                          const size_t n,
                                          const cl_half alpha,
                                          const cl_mem ap_buffer, const size_t ap_offset,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const cl_half beta,
                                          cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_command_queue* queue, cl_event* event);

// Triangular matrix-vector multiplication: STRMV/DTRMV/CTRMV/ZTRMV/HTRMV
CLBlastStatusCode  CLBlastStrmv(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose, const CLBlastDiagonal diagonal,
                                          const size_t n,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDtrmv(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose, const CLBlastDiagonal diagonal,
                                          const size_t n,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastCtrmv(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose, const CLBlastDiagonal diagonal,
                                          const size_t n,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastZtrmv(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose, const CLBlastDiagonal diagonal,
                                          const size_t n,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastHtrmv(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose, const CLBlastDiagonal diagonal,
                                          const size_t n,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);

// Triangular banded matrix-vector multiplication: STBMV/DTBMV/CTBMV/ZTBMV/HTBMV
CLBlastStatusCode  CLBlastStbmv(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose, const CLBlastDiagonal diagonal,
                                          const size_t n, const size_t k,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDtbmv(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose, const CLBlastDiagonal diagonal,
                                          const size_t n, const size_t k,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastCtbmv(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose, const CLBlastDiagonal diagonal,
                                          const size_t n, const size_t k,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastZtbmv(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose, const CLBlastDiagonal diagonal,
                                          const size_t n, const size_t k,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastHtbmv(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose, const CLBlastDiagonal diagonal,
                                          const size_t n, const size_t k,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);

// Triangular packed matrix-vector multiplication: STPMV/DTPMV/CTPMV/ZTPMV/HTPMV
CLBlastStatusCode  CLBlastStpmv(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose, const CLBlastDiagonal diagonal,
                                          const size_t n,
                                          const cl_mem ap_buffer, const size_t ap_offset,
                                          cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDtpmv(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose, const CLBlastDiagonal diagonal,
                                          const size_t n,
                                          const cl_mem ap_buffer, const size_t ap_offset,
                                          cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastCtpmv(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose, const CLBlastDiagonal diagonal,
                                          const size_t n,
                                          const cl_mem ap_buffer, const size_t ap_offset,
                                          cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastZtpmv(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose, const CLBlastDiagonal diagonal,
                                          const size_t n,
                                          const cl_mem ap_buffer, const size_t ap_offset,
                                          cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastHtpmv(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose, const CLBlastDiagonal diagonal,
                                          const size_t n,
                                          const cl_mem ap_buffer, const size_t ap_offset,
                                          cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);

// Solves a triangular system of equations: STRSV/DTRSV/CTRSV/ZTRSV
CLBlastStatusCode  CLBlastStrsv(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose, const CLBlastDiagonal diagonal,
                                          const size_t n,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDtrsv(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose, const CLBlastDiagonal diagonal,
                                          const size_t n,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastCtrsv(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose, const CLBlastDiagonal diagonal,
                                          const size_t n,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastZtrsv(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose, const CLBlastDiagonal diagonal,
                                          const size_t n,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);

// Solves a banded triangular system of equations: STBSV/DTBSV/CTBSV/ZTBSV
CLBlastStatusCode  CLBlastStbsv(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose, const CLBlastDiagonal diagonal,
                                          const size_t n, const size_t k,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDtbsv(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose, const CLBlastDiagonal diagonal,
                                          const size_t n, const size_t k,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastCtbsv(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose, const CLBlastDiagonal diagonal,
                                          const size_t n, const size_t k,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastZtbsv(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose, const CLBlastDiagonal diagonal,
                                          const size_t n, const size_t k,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);

// Solves a packed triangular system of equations: STPSV/DTPSV/CTPSV/ZTPSV
CLBlastStatusCode  CLBlastStpsv(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose, const CLBlastDiagonal diagonal,
                                          const size_t n,
                                          const cl_mem ap_buffer, const size_t ap_offset,
                                          cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDtpsv(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose, const CLBlastDiagonal diagonal,
                                          const size_t n,
                                          const cl_mem ap_buffer, const size_t ap_offset,
                                          cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastCtpsv(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose, const CLBlastDiagonal diagonal,
                                          const size_t n,
                                          const cl_mem ap_buffer, const size_t ap_offset,
                                          cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastZtpsv(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose, const CLBlastDiagonal diagonal,
                                          const size_t n,
                                          const cl_mem ap_buffer, const size_t ap_offset,
                                          cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          cl_command_queue* queue, cl_event* event);

// General rank-1 matrix update: SGER/DGER/HGER
CLBlastStatusCode  CLBlastSger(const CLBlastLayout layout,
                                         const size_t m, const size_t n,
                                         const float alpha,
                                         const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                         const cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                         cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                         cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDger(const CLBlastLayout layout,
                                         const size_t m, const size_t n,
                                         const double alpha,
                                         const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                         const cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                         cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                         cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastHger(const CLBlastLayout layout,
                                         const size_t m, const size_t n,
                                         const cl_half alpha,
                                         const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                         const cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                         cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                         cl_command_queue* queue, cl_event* event);

// General rank-1 complex matrix update: CGERU/ZGERU
CLBlastStatusCode  CLBlastCgeru(const CLBlastLayout layout,
                                          const size_t m, const size_t n,
                                          const cl_float2 alpha,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastZgeru(const CLBlastLayout layout,
                                          const size_t m, const size_t n,
                                          const cl_double2 alpha,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          cl_command_queue* queue, cl_event* event);

// General rank-1 complex conjugated matrix update: CGERC/ZGERC
CLBlastStatusCode  CLBlastCgerc(const CLBlastLayout layout,
                                          const size_t m, const size_t n,
                                          const cl_float2 alpha,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastZgerc(const CLBlastLayout layout,
                                          const size_t m, const size_t n,
                                          const cl_double2 alpha,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          cl_command_queue* queue, cl_event* event);

// Hermitian rank-1 matrix update: CHER/ZHER
CLBlastStatusCode  CLBlastCher(const CLBlastLayout layout, const CLBlastTriangle triangle,
                                         const size_t n,
                                         const float alpha,
                                         const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                         cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                         cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastZher(const CLBlastLayout layout, const CLBlastTriangle triangle,
                                         const size_t n,
                                         const double alpha,
                                         const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                         cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                         cl_command_queue* queue, cl_event* event);

// Hermitian packed rank-1 matrix update: CHPR/ZHPR
CLBlastStatusCode  CLBlastChpr(const CLBlastLayout layout, const CLBlastTriangle triangle,
                                         const size_t n,
                                         const float alpha,
                                         const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                         cl_mem ap_buffer, const size_t ap_offset,
                                         cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastZhpr(const CLBlastLayout layout, const CLBlastTriangle triangle,
                                         const size_t n,
                                         const double alpha,
                                         const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                         cl_mem ap_buffer, const size_t ap_offset,
                                         cl_command_queue* queue, cl_event* event);

// Hermitian rank-2 matrix update: CHER2/ZHER2
CLBlastStatusCode  CLBlastCher2(const CLBlastLayout layout, const CLBlastTriangle triangle,
                                          const size_t n,
                                          const cl_float2 alpha,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastZher2(const CLBlastLayout layout, const CLBlastTriangle triangle,
                                          const size_t n,
                                          const cl_double2 alpha,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          cl_command_queue* queue, cl_event* event);

// Hermitian packed rank-2 matrix update: CHPR2/ZHPR2
CLBlastStatusCode  CLBlastChpr2(const CLBlastLayout layout, const CLBlastTriangle triangle,
                                          const size_t n,
                                          const cl_float2 alpha,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_mem ap_buffer, const size_t ap_offset,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastZhpr2(const CLBlastLayout layout, const CLBlastTriangle triangle,
                                          const size_t n,
                                          const cl_double2 alpha,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_mem ap_buffer, const size_t ap_offset,
                                          cl_command_queue* queue, cl_event* event);

// Symmetric rank-1 matrix update: SSYR/DSYR/HSYR
CLBlastStatusCode  CLBlastSsyr(const CLBlastLayout layout, const CLBlastTriangle triangle,
                                         const size_t n,
                                         const float alpha,
                                         const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                         cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                         cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDsyr(const CLBlastLayout layout, const CLBlastTriangle triangle,
                                         const size_t n,
                                         const double alpha,
                                         const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                         cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                         cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastHsyr(const CLBlastLayout layout, const CLBlastTriangle triangle,
                                         const size_t n,
                                         const cl_half alpha,
                                         const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                         cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                         cl_command_queue* queue, cl_event* event);

// Symmetric packed rank-1 matrix update: SSPR/DSPR/HSPR
CLBlastStatusCode  CLBlastSspr(const CLBlastLayout layout, const CLBlastTriangle triangle,
                                         const size_t n,
                                         const float alpha,
                                         const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                         cl_mem ap_buffer, const size_t ap_offset,
                                         cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDspr(const CLBlastLayout layout, const CLBlastTriangle triangle,
                                         const size_t n,
                                         const double alpha,
                                         const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                         cl_mem ap_buffer, const size_t ap_offset,
                                         cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastHspr(const CLBlastLayout layout, const CLBlastTriangle triangle,
                                         const size_t n,
                                         const cl_half alpha,
                                         const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                         cl_mem ap_buffer, const size_t ap_offset,
                                         cl_command_queue* queue, cl_event* event);

// Symmetric rank-2 matrix update: SSYR2/DSYR2/HSYR2
CLBlastStatusCode  CLBlastSsyr2(const CLBlastLayout layout, const CLBlastTriangle triangle,
                                          const size_t n,
                                          const float alpha,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDsyr2(const CLBlastLayout layout, const CLBlastTriangle triangle,
                                          const size_t n,
                                          const double alpha,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastHsyr2(const CLBlastLayout layout, const CLBlastTriangle triangle,
                                          const size_t n,
                                          const cl_half alpha,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          cl_command_queue* queue, cl_event* event);

// Symmetric packed rank-2 matrix update: SSPR2/DSPR2/HSPR2
CLBlastStatusCode  CLBlastSspr2(const CLBlastLayout layout, const CLBlastTriangle triangle,
                                          const size_t n,
                                          const float alpha,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_mem ap_buffer, const size_t ap_offset,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDspr2(const CLBlastLayout layout, const CLBlastTriangle triangle,
                                          const size_t n,
                                          const double alpha,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_mem ap_buffer, const size_t ap_offset,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastHspr2(const CLBlastLayout layout, const CLBlastTriangle triangle,
                                          const size_t n,
                                          const cl_half alpha,
                                          const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                          const cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                          cl_mem ap_buffer, const size_t ap_offset,
                                          cl_command_queue* queue, cl_event* event);

// =================================================================================================
// BLAS level-3 (matrix-matrix) routines
// =================================================================================================

// General matrix-matrix multiplication: SGEMM/DGEMM/CGEMM/ZGEMM/HGEMM
CLBlastStatusCode  CLBlastSgemm(const CLBlastLayout layout, const CLBlastTranspose a_transpose, const CLBlastTranspose b_transpose,
                                          const size_t m, const size_t n, const size_t k,
                                          const float alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          const cl_mem b_buffer, const size_t b_offset, const size_t b_ld,
                                          const float beta,
                                          cl_mem c_buffer, const size_t c_offset, const size_t c_ld,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDgemm(const CLBlastLayout layout, const CLBlastTranspose a_transpose, const CLBlastTranspose b_transpose,
                                          const size_t m, const size_t n, const size_t k,
                                          const double alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          const cl_mem b_buffer, const size_t b_offset, const size_t b_ld,
                                          const double beta,
                                          cl_mem c_buffer, const size_t c_offset, const size_t c_ld,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastCgemm(const CLBlastLayout layout, const CLBlastTranspose a_transpose, const CLBlastTranspose b_transpose,
                                          const size_t m, const size_t n, const size_t k,
                                          const cl_float2 alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          const cl_mem b_buffer, const size_t b_offset, const size_t b_ld,
                                          const cl_float2 beta,
                                          cl_mem c_buffer, const size_t c_offset, const size_t c_ld,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastZgemm(const CLBlastLayout layout, const CLBlastTranspose a_transpose, const CLBlastTranspose b_transpose,
                                          const size_t m, const size_t n, const size_t k,
                                          const cl_double2 alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          const cl_mem b_buffer, const size_t b_offset, const size_t b_ld,
                                          const cl_double2 beta,
                                          cl_mem c_buffer, const size_t c_offset, const size_t c_ld,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastHgemm(const CLBlastLayout layout, const CLBlastTranspose a_transpose, const CLBlastTranspose b_transpose,
                                          const size_t m, const size_t n, const size_t k,
                                          const cl_half alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          const cl_mem b_buffer, const size_t b_offset, const size_t b_ld,
                                          const cl_half beta,
                                          cl_mem c_buffer, const size_t c_offset, const size_t c_ld,
                                          cl_command_queue* queue, cl_event* event);

// Symmetric matrix-matrix multiplication: SSYMM/DSYMM/CSYMM/ZSYMM/HSYMM
CLBlastStatusCode  CLBlastSsymm(const CLBlastLayout layout, const CLBlastSide side, const CLBlastTriangle triangle,
                                          const size_t m, const size_t n,
                                          const float alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          const cl_mem b_buffer, const size_t b_offset, const size_t b_ld,
                                          const float beta,
                                          cl_mem c_buffer, const size_t c_offset, const size_t c_ld,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDsymm(const CLBlastLayout layout, const CLBlastSide side, const CLBlastTriangle triangle,
                                          const size_t m, const size_t n,
                                          const double alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          const cl_mem b_buffer, const size_t b_offset, const size_t b_ld,
                                          const double beta,
                                          cl_mem c_buffer, const size_t c_offset, const size_t c_ld,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastCsymm(const CLBlastLayout layout, const CLBlastSide side, const CLBlastTriangle triangle,
                                          const size_t m, const size_t n,
                                          const cl_float2 alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          const cl_mem b_buffer, const size_t b_offset, const size_t b_ld,
                                          const cl_float2 beta,
                                          cl_mem c_buffer, const size_t c_offset, const size_t c_ld,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastZsymm(const CLBlastLayout layout, const CLBlastSide side, const CLBlastTriangle triangle,
                                          const size_t m, const size_t n,
                                          const cl_double2 alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          const cl_mem b_buffer, const size_t b_offset, const size_t b_ld,
                                          const cl_double2 beta,
                                          cl_mem c_buffer, const size_t c_offset, const size_t c_ld,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastHsymm(const CLBlastLayout layout, const CLBlastSide side, const CLBlastTriangle triangle,
                                          const size_t m, const size_t n,
                                          const cl_half alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          const cl_mem b_buffer, const size_t b_offset, const size_t b_ld,
                                          const cl_half beta,
                                          cl_mem c_buffer, const size_t c_offset, const size_t c_ld,
                                          cl_command_queue* queue, cl_event* event);

// Hermitian matrix-matrix multiplication: CHEMM/ZHEMM
CLBlastStatusCode  CLBlastChemm(const CLBlastLayout layout, const CLBlastSide side, const CLBlastTriangle triangle,
                                          const size_t m, const size_t n,
                                          const cl_float2 alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          const cl_mem b_buffer, const size_t b_offset, const size_t b_ld,
                                          const cl_float2 beta,
                                          cl_mem c_buffer, const size_t c_offset, const size_t c_ld,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastZhemm(const CLBlastLayout layout, const CLBlastSide side, const CLBlastTriangle triangle,
                                          const size_t m, const size_t n,
                                          const cl_double2 alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          const cl_mem b_buffer, const size_t b_offset, const size_t b_ld,
                                          const cl_double2 beta,
                                          cl_mem c_buffer, const size_t c_offset, const size_t c_ld,
                                          cl_command_queue* queue, cl_event* event);

// Rank-K update of a symmetric matrix: SSYRK/DSYRK/CSYRK/ZSYRK/HSYRK
CLBlastStatusCode  CLBlastSsyrk(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose,
                                          const size_t n, const size_t k,
                                          const float alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          const float beta,
                                          cl_mem c_buffer, const size_t c_offset, const size_t c_ld,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDsyrk(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose,
                                          const size_t n, const size_t k,
                                          const double alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          const double beta,
                                          cl_mem c_buffer, const size_t c_offset, const size_t c_ld,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastCsyrk(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose,
                                          const size_t n, const size_t k,
                                          const cl_float2 alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          const cl_float2 beta,
                                          cl_mem c_buffer, const size_t c_offset, const size_t c_ld,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastZsyrk(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose,
                                          const size_t n, const size_t k,
                                          const cl_double2 alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          const cl_double2 beta,
                                          cl_mem c_buffer, const size_t c_offset, const size_t c_ld,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastHsyrk(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose,
                                          const size_t n, const size_t k,
                                          const cl_half alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          const cl_half beta,
                                          cl_mem c_buffer, const size_t c_offset, const size_t c_ld,
                                          cl_command_queue* queue, cl_event* event);

// Rank-K update of a hermitian matrix: CHERK/ZHERK
CLBlastStatusCode  CLBlastCherk(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose,
                                          const size_t n, const size_t k,
                                          const float alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          const float beta,
                                          cl_mem c_buffer, const size_t c_offset, const size_t c_ld,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastZherk(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose,
                                          const size_t n, const size_t k,
                                          const double alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          const double beta,
                                          cl_mem c_buffer, const size_t c_offset, const size_t c_ld,
                                          cl_command_queue* queue, cl_event* event);

// Rank-2K update of a symmetric matrix: SSYR2K/DSYR2K/CSYR2K/ZSYR2K/HSYR2K
CLBlastStatusCode  CLBlastSsyr2k(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose ab_transpose,
                                           const size_t n, const size_t k,
                                           const float alpha,
                                           const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                           const cl_mem b_buffer, const size_t b_offset, const size_t b_ld,
                                           const float beta,
                                           cl_mem c_buffer, const size_t c_offset, const size_t c_ld,
                                           cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDsyr2k(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose ab_transpose,
                                           const size_t n, const size_t k,
                                           const double alpha,
                                           const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                           const cl_mem b_buffer, const size_t b_offset, const size_t b_ld,
                                           const double beta,
                                           cl_mem c_buffer, const size_t c_offset, const size_t c_ld,
                                           cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastCsyr2k(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose ab_transpose,
                                           const size_t n, const size_t k,
                                           const cl_float2 alpha,
                                           const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                           const cl_mem b_buffer, const size_t b_offset, const size_t b_ld,
                                           const cl_float2 beta,
                                           cl_mem c_buffer, const size_t c_offset, const size_t c_ld,
                                           cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastZsyr2k(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose ab_transpose,
                                           const size_t n, const size_t k,
                                           const cl_double2 alpha,
                                           const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                           const cl_mem b_buffer, const size_t b_offset, const size_t b_ld,
                                           const cl_double2 beta,
                                           cl_mem c_buffer, const size_t c_offset, const size_t c_ld,
                                           cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastHsyr2k(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose ab_transpose,
                                           const size_t n, const size_t k,
                                           const cl_half alpha,
                                           const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                           const cl_mem b_buffer, const size_t b_offset, const size_t b_ld,
                                           const cl_half beta,
                                           cl_mem c_buffer, const size_t c_offset, const size_t c_ld,
                                           cl_command_queue* queue, cl_event* event);

// Rank-2K update of a hermitian matrix: CHER2K/ZHER2K
CLBlastStatusCode  CLBlastCher2k(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose ab_transpose,
                                           const size_t n, const size_t k,
                                           const cl_float2 alpha,
                                           const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                           const cl_mem b_buffer, const size_t b_offset, const size_t b_ld,
                                           const float beta,
                                           cl_mem c_buffer, const size_t c_offset, const size_t c_ld,
                                           cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastZher2k(const CLBlastLayout layout, const CLBlastTriangle triangle, const CLBlastTranspose ab_transpose,
                                           const size_t n, const size_t k,
                                           const cl_double2 alpha,
                                           const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                           const cl_mem b_buffer, const size_t b_offset, const size_t b_ld,
                                           const double beta,
                                           cl_mem c_buffer, const size_t c_offset, const size_t c_ld,
                                           cl_command_queue* queue, cl_event* event);

// Triangular matrix-matrix multiplication: STRMM/DTRMM/CTRMM/ZTRMM/HTRMM
CLBlastStatusCode  CLBlastStrmm(const CLBlastLayout layout, const CLBlastSide side, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose, const CLBlastDiagonal diagonal,
                                          const size_t m, const size_t n,
                                          const float alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          cl_mem b_buffer, const size_t b_offset, const size_t b_ld,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDtrmm(const CLBlastLayout layout, const CLBlastSide side, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose, const CLBlastDiagonal diagonal,
                                          const size_t m, const size_t n,
                                          const double alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          cl_mem b_buffer, const size_t b_offset, const size_t b_ld,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastCtrmm(const CLBlastLayout layout, const CLBlastSide side, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose, const CLBlastDiagonal diagonal,
                                          const size_t m, const size_t n,
                                          const cl_float2 alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          cl_mem b_buffer, const size_t b_offset, const size_t b_ld,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastZtrmm(const CLBlastLayout layout, const CLBlastSide side, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose, const CLBlastDiagonal diagonal,
                                          const size_t m, const size_t n,
                                          const cl_double2 alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          cl_mem b_buffer, const size_t b_offset, const size_t b_ld,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastHtrmm(const CLBlastLayout layout, const CLBlastSide side, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose, const CLBlastDiagonal diagonal,
                                          const size_t m, const size_t n,
                                          const cl_half alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          cl_mem b_buffer, const size_t b_offset, const size_t b_ld,
                                          cl_command_queue* queue, cl_event* event);

// Solves a triangular system of equations: STRSM/DTRSM/CTRSM/ZTRSM
CLBlastStatusCode  CLBlastStrsm(const CLBlastLayout layout, const CLBlastSide side, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose, const CLBlastDiagonal diagonal,
                                          const size_t m, const size_t n,
                                          const float alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          cl_mem b_buffer, const size_t b_offset, const size_t b_ld,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDtrsm(const CLBlastLayout layout, const CLBlastSide side, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose, const CLBlastDiagonal diagonal,
                                          const size_t m, const size_t n,
                                          const double alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          cl_mem b_buffer, const size_t b_offset, const size_t b_ld,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastCtrsm(const CLBlastLayout layout, const CLBlastSide side, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose, const CLBlastDiagonal diagonal,
                                          const size_t m, const size_t n,
                                          const cl_float2 alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          cl_mem b_buffer, const size_t b_offset, const size_t b_ld,
                                          cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastZtrsm(const CLBlastLayout layout, const CLBlastSide side, const CLBlastTriangle triangle, const CLBlastTranspose a_transpose, const CLBlastDiagonal diagonal,
                                          const size_t m, const size_t n,
                                          const cl_double2 alpha,
                                          const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                          cl_mem b_buffer, const size_t b_offset, const size_t b_ld,
                                          cl_command_queue* queue, cl_event* event);

// =================================================================================================
// Extra non-BLAS routines (level-X)
// =================================================================================================

// Element-wise vector product (Hadamard): SHAD/DHAD/CHAD/ZHAD/HHAD
CLBlastStatusCode  CLBlastShad(const size_t n,
                                         const float alpha,
                                         const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                         const cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                         const float beta,
                                         cl_mem z_buffer, const size_t z_offset, const size_t z_inc,
                                         cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDhad(const size_t n,
                                         const double alpha,
                                         const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                         const cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                         const double beta,
                                         cl_mem z_buffer, const size_t z_offset, const size_t z_inc,
                                         cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastChad(const size_t n,
                                         const cl_float2 alpha,
                                         const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                         const cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                         const cl_float2 beta,
                                         cl_mem z_buffer, const size_t z_offset, const size_t z_inc,
                                         cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastZhad(const size_t n,
                                         const cl_double2 alpha,
                                         const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                         const cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                         const cl_double2 beta,
                                         cl_mem z_buffer, const size_t z_offset, const size_t z_inc,
                                         cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastHhad(const size_t n,
                                         const cl_half alpha,
                                         const cl_mem x_buffer, const size_t x_offset, const size_t x_inc,
                                         const cl_mem y_buffer, const size_t y_offset, const size_t y_inc,
                                         const cl_half beta,
                                         cl_mem z_buffer, const size_t z_offset, const size_t z_inc,
                                         cl_command_queue* queue, cl_event* event);

// Scaling and out-place transpose/copy (non-BLAS function): SOMATCOPY/DOMATCOPY/COMATCOPY/ZOMATCOPY/HOMATCOPY
CLBlastStatusCode  CLBlastSomatcopy(const CLBlastLayout layout, const CLBlastTranspose a_transpose,
                                              const size_t m, const size_t n,
                                              const float alpha,
                                              const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                              cl_mem b_buffer, const size_t b_offset, const size_t b_ld,
                                              cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDomatcopy(const CLBlastLayout layout, const CLBlastTranspose a_transpose,
                                              const size_t m, const size_t n,
                                              const double alpha,
                                              const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                              cl_mem b_buffer, const size_t b_offset, const size_t b_ld,
                                              cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastComatcopy(const CLBlastLayout layout, const CLBlastTranspose a_transpose,
                                              const size_t m, const size_t n,
                                              const cl_float2 alpha,
                                              const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                              cl_mem b_buffer, const size_t b_offset, const size_t b_ld,
                                              cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastZomatcopy(const CLBlastLayout layout, const CLBlastTranspose a_transpose,
                                              const size_t m, const size_t n,
                                              const cl_double2 alpha,
                                              const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                              cl_mem b_buffer, const size_t b_offset, const size_t b_ld,
                                              cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastHomatcopy(const CLBlastLayout layout, const CLBlastTranspose a_transpose,
                                              const size_t m, const size_t n,
                                              const cl_half alpha,
                                              const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                              cl_mem b_buffer, const size_t b_offset, const size_t b_ld,
                                              cl_command_queue* queue, cl_event* event);

// Im2col function (non-BLAS function): SIM2COL/DIM2COL/CIM2COL/ZIM2COL/HIM2COL
CLBlastStatusCode  CLBlastSim2col(const CLBlastKernelMode kernel_mode,
                                            const size_t channels, const size_t height, const size_t width, const size_t kernel_h, const size_t kernel_w, const size_t pad_h, const size_t pad_w, const size_t stride_h, const size_t stride_w, const size_t dilation_h, const size_t dilation_w,
                                            const cl_mem im_buffer, const size_t im_offset,
                                            cl_mem col_buffer, const size_t col_offset,
                                            cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDim2col(const CLBlastKernelMode kernel_mode,
                                            const size_t channels, const size_t height, const size_t width, const size_t kernel_h, const size_t kernel_w, const size_t pad_h, const size_t pad_w, const size_t stride_h, const size_t stride_w, const size_t dilation_h, const size_t dilation_w,
                                            const cl_mem im_buffer, const size_t im_offset,
                                            cl_mem col_buffer, const size_t col_offset,
                                            cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastCim2col(const CLBlastKernelMode kernel_mode,
                                            const size_t channels, const size_t height, const size_t width, const size_t kernel_h, const size_t kernel_w, const size_t pad_h, const size_t pad_w, const size_t stride_h, const size_t stride_w, const size_t dilation_h, const size_t dilation_w,
                                            const cl_mem im_buffer, const size_t im_offset,
                                            cl_mem col_buffer, const size_t col_offset,
                                            cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastZim2col(const CLBlastKernelMode kernel_mode,
                                            const size_t channels, const size_t height, const size_t width, const size_t kernel_h, const size_t kernel_w, const size_t pad_h, const size_t pad_w, const size_t stride_h, const size_t stride_w, const size_t dilation_h, const size_t dilation_w,
                                            const cl_mem im_buffer, const size_t im_offset,
                                            cl_mem col_buffer, const size_t col_offset,
                                            cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastHim2col(const CLBlastKernelMode kernel_mode,
                                            const size_t channels, const size_t height, const size_t width, const size_t kernel_h, const size_t kernel_w, const size_t pad_h, const size_t pad_w, const size_t stride_h, const size_t stride_w, const size_t dilation_h, const size_t dilation_w,
                                            const cl_mem im_buffer, const size_t im_offset,
                                            cl_mem col_buffer, const size_t col_offset,
                                            cl_command_queue* queue, cl_event* event);

// Col2im function (non-BLAS function): SCOL2IM/DCOL2IM/CCOL2IM/ZCOL2IM/HCOL2IM
CLBlastStatusCode  CLBlastScol2im(const CLBlastKernelMode kernel_mode,
                                            const size_t channels, const size_t height, const size_t width, const size_t kernel_h, const size_t kernel_w, const size_t pad_h, const size_t pad_w, const size_t stride_h, const size_t stride_w, const size_t dilation_h, const size_t dilation_w,
                                            const cl_mem col_buffer, const size_t col_offset,
                                            cl_mem im_buffer, const size_t im_offset,
                                            cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDcol2im(const CLBlastKernelMode kernel_mode,
                                            const size_t channels, const size_t height, const size_t width, const size_t kernel_h, const size_t kernel_w, const size_t pad_h, const size_t pad_w, const size_t stride_h, const size_t stride_w, const size_t dilation_h, const size_t dilation_w,
                                            const cl_mem col_buffer, const size_t col_offset,
                                            cl_mem im_buffer, const size_t im_offset,
                                            cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastCcol2im(const CLBlastKernelMode kernel_mode,
                                            const size_t channels, const size_t height, const size_t width, const size_t kernel_h, const size_t kernel_w, const size_t pad_h, const size_t pad_w, const size_t stride_h, const size_t stride_w, const size_t dilation_h, const size_t dilation_w,
                                            const cl_mem col_buffer, const size_t col_offset,
                                            cl_mem im_buffer, const size_t im_offset,
                                            cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastZcol2im(const CLBlastKernelMode kernel_mode,
                                            const size_t channels, const size_t height, const size_t width, const size_t kernel_h, const size_t kernel_w, const size_t pad_h, const size_t pad_w, const size_t stride_h, const size_t stride_w, const size_t dilation_h, const size_t dilation_w,
                                            const cl_mem col_buffer, const size_t col_offset,
                                            cl_mem im_buffer, const size_t im_offset,
                                            cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastHcol2im(const CLBlastKernelMode kernel_mode,
                                            const size_t channels, const size_t height, const size_t width, const size_t kernel_h, const size_t kernel_w, const size_t pad_h, const size_t pad_w, const size_t stride_h, const size_t stride_w, const size_t dilation_h, const size_t dilation_w,
                                            const cl_mem col_buffer, const size_t col_offset,
                                            cl_mem im_buffer, const size_t im_offset,
                                            cl_command_queue* queue, cl_event* event);

// Batched convolution as GEMM (non-BLAS function): SCONVGEMM/DCONVGEMM/HCONVGEMM
CLBlastStatusCode  CLBlastSconvgemm(const CLBlastKernelMode kernel_mode,
                                              const size_t channels, const size_t height, const size_t width, const size_t kernel_h, const size_t kernel_w, const size_t pad_h, const size_t pad_w, const size_t stride_h, const size_t stride_w, const size_t dilation_h, const size_t dilation_w, const size_t num_kernels, const size_t batch_count,
                                              const cl_mem im_buffer, const size_t im_offset,
                                              const cl_mem kernel_buffer, const size_t kernel_offset,
                                              cl_mem result_buffer, const size_t result_offset,
                                              cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDconvgemm(const CLBlastKernelMode kernel_mode,
                                              const size_t channels, const size_t height, const size_t width, const size_t kernel_h, const size_t kernel_w, const size_t pad_h, const size_t pad_w, const size_t stride_h, const size_t stride_w, const size_t dilation_h, const size_t dilation_w, const size_t num_kernels, const size_t batch_count,
                                              const cl_mem im_buffer, const size_t im_offset,
                                              const cl_mem kernel_buffer, const size_t kernel_offset,
                                              cl_mem result_buffer, const size_t result_offset,
                                              cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastHconvgemm(const CLBlastKernelMode kernel_mode,
                                              const size_t channels, const size_t height, const size_t width, const size_t kernel_h, const size_t kernel_w, const size_t pad_h, const size_t pad_w, const size_t stride_h, const size_t stride_w, const size_t dilation_h, const size_t dilation_w, const size_t num_kernels, const size_t batch_count,
                                              const cl_mem im_buffer, const size_t im_offset,
                                              const cl_mem kernel_buffer, const size_t kernel_offset,
                                              cl_mem result_buffer, const size_t result_offset,
                                              cl_command_queue* queue, cl_event* event);

// Batched version of AXPY: SAXPYBATCHED/DAXPYBATCHED/CAXPYBATCHED/ZAXPYBATCHED/HAXPYBATCHED
CLBlastStatusCode  CLBlastSaxpyBatched(const size_t n,
                                                 const float *alphas,
                                                 const cl_mem x_buffer, const size_t *x_offsets, const size_t x_inc,
                                                 cl_mem y_buffer, const size_t *y_offsets, const size_t y_inc,
                                                 const size_t batch_count,
                                                 cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDaxpyBatched(const size_t n,
                                                 const double *alphas,
                                                 const cl_mem x_buffer, const size_t *x_offsets, const size_t x_inc,
                                                 cl_mem y_buffer, const size_t *y_offsets, const size_t y_inc,
                                                 const size_t batch_count,
                                                 cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastCaxpyBatched(const size_t n,
                                                 const cl_float2 *alphas,
                                                 const cl_mem x_buffer, const size_t *x_offsets, const size_t x_inc,
                                                 cl_mem y_buffer, const size_t *y_offsets, const size_t y_inc,
                                                 const size_t batch_count,
                                                 cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastZaxpyBatched(const size_t n,
                                                 const cl_double2 *alphas,
                                                 const cl_mem x_buffer, const size_t *x_offsets, const size_t x_inc,
                                                 cl_mem y_buffer, const size_t *y_offsets, const size_t y_inc,
                                                 const size_t batch_count,
                                                 cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastHaxpyBatched(const size_t n,
                                                 const cl_half *alphas,
                                                 const cl_mem x_buffer, const size_t *x_offsets, const size_t x_inc,
                                                 cl_mem y_buffer, const size_t *y_offsets, const size_t y_inc,
                                                 const size_t batch_count,
                                                 cl_command_queue* queue, cl_event* event);

// Batched version of GEMM: SGEMMBATCHED/DGEMMBATCHED/CGEMMBATCHED/ZGEMMBATCHED/HGEMMBATCHED
CLBlastStatusCode  CLBlastSgemmBatched(const CLBlastLayout layout, const CLBlastTranspose a_transpose, const CLBlastTranspose b_transpose,
                                                 const size_t m, const size_t n, const size_t k,
                                                 const float *alphas,
                                                 const cl_mem a_buffer, const size_t *a_offsets, const size_t a_ld,
                                                 const cl_mem b_buffer, const size_t *b_offsets, const size_t b_ld,
                                                 const float *betas,
                                                 cl_mem c_buffer, const size_t *c_offsets, const size_t c_ld,
                                                 const size_t batch_count,
                                                 cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDgemmBatched(const CLBlastLayout layout, const CLBlastTranspose a_transpose, const CLBlastTranspose b_transpose,
                                                 const size_t m, const size_t n, const size_t k,
                                                 const double *alphas,
                                                 const cl_mem a_buffer, const size_t *a_offsets, const size_t a_ld,
                                                 const cl_mem b_buffer, const size_t *b_offsets, const size_t b_ld,
                                                 const double *betas,
                                                 cl_mem c_buffer, const size_t *c_offsets, const size_t c_ld,
                                                 const size_t batch_count,
                                                 cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastCgemmBatched(const CLBlastLayout layout, const CLBlastTranspose a_transpose, const CLBlastTranspose b_transpose,
                                                 const size_t m, const size_t n, const size_t k,
                                                 const cl_float2 *alphas,
                                                 const cl_mem a_buffer, const size_t *a_offsets, const size_t a_ld,
                                                 const cl_mem b_buffer, const size_t *b_offsets, const size_t b_ld,
                                                 const cl_float2 *betas,
                                                 cl_mem c_buffer, const size_t *c_offsets, const size_t c_ld,
                                                 const size_t batch_count,
                                                 cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastZgemmBatched(const CLBlastLayout layout, const CLBlastTranspose a_transpose, const CLBlastTranspose b_transpose,
                                                 const size_t m, const size_t n, const size_t k,
                                                 const cl_double2 *alphas,
                                                 const cl_mem a_buffer, const size_t *a_offsets, const size_t a_ld,
                                                 const cl_mem b_buffer, const size_t *b_offsets, const size_t b_ld,
                                                 const cl_double2 *betas,
                                                 cl_mem c_buffer, const size_t *c_offsets, const size_t c_ld,
                                                 const size_t batch_count,
                                                 cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastHgemmBatched(const CLBlastLayout layout, const CLBlastTranspose a_transpose, const CLBlastTranspose b_transpose,
                                                 const size_t m, const size_t n, const size_t k,
                                                 const cl_half *alphas,
                                                 const cl_mem a_buffer, const size_t *a_offsets, const size_t a_ld,
                                                 const cl_mem b_buffer, const size_t *b_offsets, const size_t b_ld,
                                                 const cl_half *betas,
                                                 cl_mem c_buffer, const size_t *c_offsets, const size_t c_ld,
                                                 const size_t batch_count,
                                                 cl_command_queue* queue, cl_event* event);

// StridedBatched version of GEMM: SGEMMSTRIDEDBATCHED/DGEMMSTRIDEDBATCHED/CGEMMSTRIDEDBATCHED/ZGEMMSTRIDEDBATCHED/HGEMMSTRIDEDBATCHED
CLBlastStatusCode  CLBlastSgemmStridedBatched(const CLBlastLayout layout, const CLBlastTranspose a_transpose, const CLBlastTranspose b_transpose,
                                                        const size_t m, const size_t n, const size_t k,
                                                        const float alpha,
                                                        const cl_mem a_buffer, const size_t a_offset, const size_t a_ld, const size_t a_stride,
                                                        const cl_mem b_buffer, const size_t b_offset, const size_t b_ld, const size_t b_stride,
                                                        const float beta,
                                                        cl_mem c_buffer, const size_t c_offset, const size_t c_ld, const size_t c_stride,
                                                        const size_t batch_count,
                                                        cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastDgemmStridedBatched(const CLBlastLayout layout, const CLBlastTranspose a_transpose, const CLBlastTranspose b_transpose,
                                                        const size_t m, const size_t n, const size_t k,
                                                        const double alpha,
                                                        const cl_mem a_buffer, const size_t a_offset, const size_t a_ld, const size_t a_stride,
                                                        const cl_mem b_buffer, const size_t b_offset, const size_t b_ld, const size_t b_stride,
                                                        const double beta,
                                                        cl_mem c_buffer, const size_t c_offset, const size_t c_ld, const size_t c_stride,
                                                        const size_t batch_count,
                                                        cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastCgemmStridedBatched(const CLBlastLayout layout, const CLBlastTranspose a_transpose, const CLBlastTranspose b_transpose,
                                                        const size_t m, const size_t n, const size_t k,
                                                        const cl_float2 alpha,
                                                        const cl_mem a_buffer, const size_t a_offset, const size_t a_ld, const size_t a_stride,
                                                        const cl_mem b_buffer, const size_t b_offset, const size_t b_ld, const size_t b_stride,
                                                        const cl_float2 beta,
                                                        cl_mem c_buffer, const size_t c_offset, const size_t c_ld, const size_t c_stride,
                                                        const size_t batch_count,
                                                        cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastZgemmStridedBatched(const CLBlastLayout layout, const CLBlastTranspose a_transpose, const CLBlastTranspose b_transpose,
                                                        const size_t m, const size_t n, const size_t k,
                                                        const cl_double2 alpha,
                                                        const cl_mem a_buffer, const size_t a_offset, const size_t a_ld, const size_t a_stride,
                                                        const cl_mem b_buffer, const size_t b_offset, const size_t b_ld, const size_t b_stride,
                                                        const cl_double2 beta,
                                                        cl_mem c_buffer, const size_t c_offset, const size_t c_ld, const size_t c_stride,
                                                        const size_t batch_count,
                                                        cl_command_queue* queue, cl_event* event);
CLBlastStatusCode  CLBlastHgemmStridedBatched(const CLBlastLayout layout, const CLBlastTranspose a_transpose, const CLBlastTranspose b_transpose,
                                                        const size_t m, const size_t n, const size_t k,
                                                        const cl_half alpha,
                                                        const cl_mem a_buffer, const size_t a_offset, const size_t a_ld, const size_t a_stride,
                                                        const cl_mem b_buffer, const size_t b_offset, const size_t b_ld, const size_t b_stride,
                                                        const cl_half beta,
                                                        cl_mem c_buffer, const size_t c_offset, const size_t c_ld, const size_t c_stride,
                                                        const size_t batch_count,
                                                        cl_command_queue* queue, cl_event* event);

// =================================================================================================
// General matrix-matrix multiplication with temporary buffer from user (optional, for advanced users): SGEMM/DGEMM/CGEMM/ZGEMM/HGEMM
CLBlastStatusCode  CLBlastSgemmWithTempBuffer(const CLBlastLayout layout, const CLBlastTranspose a_transpose, const CLBlastTranspose b_transpose,
                                                        const size_t m, const size_t n, const size_t k,
                                                        const float alpha,
                                                        const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                                        const cl_mem b_buffer, const size_t b_offset, const size_t b_ld,
                                                        const float beta,
                                                        cl_mem c_buffer, const size_t c_offset, const size_t c_ld,
                                                        cl_command_queue* queue, cl_event* event, cl_mem temp_buffer);
CLBlastStatusCode  CLBlastDgemmWithTempBuffer(const CLBlastLayout layout, const CLBlastTranspose a_transpose, const CLBlastTranspose b_transpose,
                                                        const size_t m, const size_t n, const size_t k,
                                                        const double alpha,
                                                        const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                                        const cl_mem b_buffer, const size_t b_offset, const size_t b_ld,
                                                        const double beta,
                                                        cl_mem c_buffer, const size_t c_offset, const size_t c_ld,
                                                        cl_command_queue* queue, cl_event* event, cl_mem temp_buffer);
CLBlastStatusCode  CLBlastCgemmWithTempBuffer(const CLBlastLayout layout, const CLBlastTranspose a_transpose, const CLBlastTranspose b_transpose,
                                                        const size_t m, const size_t n, const size_t k,
                                                        const cl_float2 alpha,
                                                        const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                                        const cl_mem b_buffer, const size_t b_offset, const size_t b_ld,
                                                        const cl_float2 beta,
                                                        cl_mem c_buffer, const size_t c_offset, const size_t c_ld,
                                                        cl_command_queue* queue, cl_event* event, cl_mem temp_buffer);
CLBlastStatusCode  CLBlastZgemmWithTempBuffer(const CLBlastLayout layout, const CLBlastTranspose a_transpose, const CLBlastTranspose b_transpose,
                                                        const size_t m, const size_t n, const size_t k,
                                                        const cl_double2 alpha,
                                                        const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                                        const cl_mem b_buffer, const size_t b_offset, const size_t b_ld,
                                                        const cl_double2 beta,
                                                        cl_mem c_buffer, const size_t c_offset, const size_t c_ld,
                                                        cl_command_queue* queue, cl_event* event, cl_mem temp_buffer);
CLBlastStatusCode  CLBlastHgemmWithTempBuffer(const CLBlastLayout layout, const CLBlastTranspose a_transpose, const CLBlastTranspose b_transpose,
                                                        const size_t m, const size_t n, const size_t k,
                                                        const cl_half alpha,
                                                        const cl_mem a_buffer, const size_t a_offset, const size_t a_ld,
                                                        const cl_mem b_buffer, const size_t b_offset, const size_t b_ld,
                                                        const cl_half beta,
                                                        cl_mem c_buffer, const size_t c_offset, const size_t c_ld,
                                                        cl_command_queue* queue, cl_event* event, cl_mem temp_buffer);

// =================================================================================================
// Retrieves the required size of the temporary buffer for the GEMM kernel: SGEMM/DGEMM/CGEMM/ZGEMM/HGEMM (optional)
CLBlastStatusCode  CLBlastSGemmTempBufferSize(const CLBlastLayout layout, const CLBlastTranspose a_transpose, const CLBlastTranspose b_transpose,
                                                        const size_t m, const size_t n, const size_t k,
                                                        const size_t a_offset, const size_t a_ld,
                                                        const size_t b_offset, const size_t b_ld,
                                                        const size_t c_offset, const size_t c_ld,
                                                        cl_command_queue* queue,
                                                        size_t* temp_buffer_size);

CLBlastStatusCode  CLBlastDGemmTempBufferSize(const CLBlastLayout layout, const CLBlastTranspose a_transpose, const CLBlastTranspose b_transpose,
                                                        const size_t m, const size_t n, const size_t k,
                                                        const size_t a_offset, const size_t a_ld,
                                                        const size_t b_offset, const size_t b_ld,
                                                        const size_t c_offset, const size_t c_ld,
                                                        cl_command_queue* queue,
                                                        size_t* temp_buffer_size);

CLBlastStatusCode  CLBlastCGemmTempBufferSize(const CLBlastLayout layout, const CLBlastTranspose a_transpose, const CLBlastTranspose b_transpose,
                                                        const size_t m, const size_t n, const size_t k,
                                                        const size_t a_offset, const size_t a_ld,
                                                        const size_t b_offset, const size_t b_ld,
                                                        const size_t c_offset, const size_t c_ld,
                                                        cl_command_queue* queue,
                                                        size_t* temp_buffer_size);

CLBlastStatusCode  CLBlastZGemmTempBufferSize(const CLBlastLayout layout, const CLBlastTranspose a_transpose, const CLBlastTranspose b_transpose,
                                                        const size_t m, const size_t n, const size_t k,
                                                        const size_t a_offset, const size_t a_ld,
                                                        const size_t b_offset, const size_t b_ld,
                                                        const size_t c_offset, const size_t c_ld,
                                                        cl_command_queue* queue,
                                                        size_t* temp_buffer_size);

CLBlastStatusCode  CLBlastHGemmTempBufferSize(const CLBlastLayout layout, const CLBlastTranspose a_transpose, const CLBlastTranspose b_transpose,
                                                        const size_t m, const size_t n, const size_t k,
                                                        const size_t a_offset, const size_t a_ld,
                                                        const size_t b_offset, const size_t b_ld,
                                                        const size_t c_offset, const size_t c_ld,
                                                        cl_command_queue* queue,
                                                        size_t* temp_buffer_size);

// =================================================================================================

// CLBlast stores binaries of compiled kernels into a cache in case the same kernel is used later on
// for the same device. This cache can be cleared to free up system memory or in case of debugging.
CLBlastStatusCode  CLBlastClearCache();

// The cache can also be pre-initialized for a specific device with all possible CLBLast kernels.
// Further CLBlast routine calls will then run at maximum speed.
CLBlastStatusCode  CLBlastFillCache(const cl_device_id device);

// =================================================================================================

// Overrides tuning parameters for a specific device-precision-kernel combination. The next time
// the target routine is called it will re-compile and use the new parameters from then on.
CLBlastStatusCode  CLBlastOverrideParameters(const cl_device_id device, const char* kernel_name,
                                                       const CLBlastPrecision precision, const size_t num_parameters,
                                                       const char** parameters_names, const size_t* parameters_values);

// =================================================================================================





// CLBLAST_CLBLAST_C_H_
#line 1708 "C:\\OpenCL\\CLBlast-1.5.2-Windows-x64\\include\\clblast_c.h"
#line 2 "clblastffi.c"
