#include <complex.h>
#include <stdio.h>

#if _MSC_VER
typedef _Fcomplex complex_float_t;
typedef _Dcomplex complex_dobule_t;
typedef _Lcomplex complex_long_t;
#define complex_build_d(real,imag)  _Cbuild(real,imag)
#define complex_build_f(real,imag)  _FCbuild(real,imag)
#define complex_build_l(real,imag)  _LCbuild(real,imag)
#define complex_mul_d(x,y)          _Cmulcc(x,y)
#define complex_mul_f(x,y)          _FCmulcc(x,y)
#define complex_mul_l(x,y)          _LCmulcc(x,y)
#define complex_plus_d(x,y)         _Cbuild(x._Val[0]+y._Val[0],x._Val[1]+y._Val[1])
#define complex_plus_f(x,y)         _FCbuild(x._Val[0]+y._Val[0],x._Val[1]+y._Val[1])
#define complex_plus_l(x,y)         _LCbuild(x._Val[0]+y._Val[0],x._Val[1]+y._Val[1])
#endif

void main()
{
    complex_float_t a = complex_build_f(2.0, 1.0);
    complex_float_t b = complex_build_f(3.0, 1.0);
    complex_float_t c = complex_plus_f(a,b);
    complex_float_t d = complex_mul_f(a,b);

    printf("a+b=%f+%fi\n",crealf(c),cimagf(c));
    printf("a*b=%f+%fi\n",crealf(d),cimagf(d));
}