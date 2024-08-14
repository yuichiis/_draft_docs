#ifndef _UNITTEST_H
#define _UNITTEST_H

namespace testing
{

class Test {
};


template <typename... Ts>
struct ProxyTypeList {
  using type = Types<Ts...>;
};

#define EXPECT_EQ(x,y) { if(x!=y) { std::cout << "ERROR" << std::endl; } }
#define TYPED_TEST(classname,methodname) \
template <typename TypeParam> \
void classname::methodname()

}
#endif // _UNITTEST_H
