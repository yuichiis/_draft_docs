// complex_abs.cpp
// compile with: /EHsc
#include <complex>
#include <iostream>

int main( )
{
   double pi = 3.14159265359;

   // Complex numbers can be entered in polar form with
   // modulus and argument parameter inputs but are
   // stored in Cartesian form as real & imag coordinates
   std::complex <double> c1 ( std::polar ( 5.0 ) );   // Default argument = 0
   std::complex <double> c2 ( std::polar ( 5.0 , pi / 6 ) );
   std::complex <double> c3 ( std::polar ( 5.0 , 13 * pi / 6 ) );
   std::cout << "c1 = polar ( 5.0 ) = " << c1 << std::endl;
   std::cout << "c2 = polar ( 5.0 , pi / 6 ) = " << c2 << std::endl;
   std::cout << "c3 = polar ( 5.0 , 13 * pi / 6 ) = " << c3 << std::endl;

   // The modulus and argument of a complex number can be recovered
   // using abs & arg member functions
   double absc1 = std::abs ( c1 );
   double argc1 = std::arg ( c1 );
   std::cout << "The modulus of c1 is recovered from c1 using: abs ( c1 ) = "
        << absc1 << std::endl;
   std::cout << "Argument of c1 is recovered from c1 using:\n arg ( c1 ) = "
        << argc1 << " radians, which is " << argc1 * 180 / pi
        << " degrees." << std::endl;

   double absc2 = std::abs ( c2 );
   double argc2 = std::arg ( c2 );
   std::cout << "The modulus of c2 is recovered from c2 using: abs ( c2 ) = "
        << absc2 << std::endl;
   std::cout << "Argument of c2 is recovered from c2 using:\n arg ( c2 ) = "
        << argc2 << " radians, which is " << argc2 * 180 / pi
        << " degrees." << std::endl;

   // Testing if the principal angles of c2 and c3 are the same
   if ( (std::arg ( c2 ) <= ( std::arg ( c3 ) + .00000001) ) ||
        (std::arg ( c2 ) >= ( std::arg ( c3 ) - .00000001) ) )
      std::cout << "The complex numbers c2 & c3 have the "
           << "same principal arguments."<< std::endl;
   else
      std::cout << "The complex numbers c2 & c3 don't have the "
           << "same principal arguments." << std::endl;
}
