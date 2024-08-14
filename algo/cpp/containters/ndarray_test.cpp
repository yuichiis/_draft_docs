#include "ndarray.h"

using rindow::math::NDArray;

void sub();

void main()
{
    using ndarray_t = NDArray<int>::ndarray_t;
    try {
        //auto a = NDArray<int>::alloc({2,2});
        ndarray_t a = NDArray<int>::alloc({2,3});
        std::cout << "ndim: " << a->ndim() << std::endl;
        std::cout << "shape: "; for(auto&v:a->shape()){std::cout << v << ",";}; std::cout << std::endl;
        std::cout << "offset: " << a->offset() << std::endl;
        std::cout << "size: " << a->size() << std::endl;
        std::cout << "num_items: " << a->num_items() << std::endl;
        a->at(0)->at(0)->scalar() = 1;
        a->at(0)->at(1)->scalar() = 2;
        a->at(0)->at(2)->scalar() = 3;
        a->at(1)->at(0)->scalar() = 4;
        a->at(1)->at(1)->scalar() = 5;
        a->at(1)->at(2)->scalar() = 6;
        //// a->at(2)->at(0)->scalar() = 9; out of range
        ////std::cout << "a->scalar():" << a->scalar() << std::endl;
        //std::cout << "(*a)[{1,1}]: " << (*a)[{1,1}] << std::endl;
        //std::cout << "(*a)[{1,1}] = 9;" << std::endl;
        //(*a)[{1,1}] = 9;
        //auto buffer = a->buffer();
        //for(const auto& v: *buffer) {
        //    std::cout << v << ",";
        //}
        //std::cout << std::endl;
        //auto addr = a->data();
        //auto size = a->num_items();
        //for(int i=0;i<size;i++) {
        //    std::cout << addr[i] << ",";
        //}
        //std::cout << std::endl;

        //std::cout << "row size:" << a->size() << std::endl;
        std::cout << "===for(auto& v: *a)===" << std::endl;
        for(const auto& v: *a) {
            for(const auto& vv: *v) {
                if(!vv->is_scalar()) {
                    std::cout << "not scalar" << std::endl;
                }
                std::cout << "[" << vv->offset() << "]=" << vv->scalar() << ",";
            }
            std::cout << std::endl;
        }
        //std::cout << "===end for()===" << std::endl;

        std::cout << "(*a)[{i,j}]" << std::endl;
        for(NDArray<int>::index_t i=0;i<2;++i) {
            for(NDArray<int>::index_t  j=0;j<3;++j) {
                std::cout << a->at({i,j}) << ",";
            }
        }
        std::cout << std::endl;

        std::cout << "for(auto i=a->begin();i!=a->end();++i)" << std::endl;
        for(auto i=a->begin();i!=a->end();++i) {
            auto v = a->at(i);
            for(auto j=v->begin();j!=v->end(); ++j) {
                auto vv = v->at(j);
                if(!vv->is_scalar()) {
                    std::cout << "nscalar:";
                }
                std::cout << "[" << vv->offset() << "]=" << vv->scalar() << ",";
            }
            std::cout << std::endl;
        }

        std::cout << "fill" << std::endl;
        auto b = NDArray<int>::fill({2,2},123);
        for(auto& i: *b) {
            for(auto& j: *i) {
                std::cout << j->scalar() << ",";
            }
        }
        std::cout << std::endl;

        auto zeros = NDArray<int>::zeros({2,2});
        for(auto& i: *zeros) {
            for(auto& j: *i) {
                std::cout << j->scalar() << ",";
            }
        }
        std::cout << std::endl;

        auto ones = NDArray<int>::ones({2,2});
        for(auto& i: *ones) {
            for(auto& j: *i) {
                std::cout << j->scalar() << ",";
            }
        }
        std::cout << std::endl;

        int sum = std::accumulate(a->vbegin(),a->vend(),0);
        std::cout << "sum=" << sum << std::endl;
        int sum2 = 0;
        std::for_each(a->vbegin(),a->vend(),[&sum2] (int v) mutable {
            sum2 += v;
        });
        std::cout << "sum2=" << sum2 << std::endl;
        int plus = 10;
        std::for_each(a->vbegin(),a->vend(),[plus] (int& v) mutable {
            v += plus;
        });
        for(auto& i: *a) {
            for(auto& j: *i) {
                std::cout << j->scalar() << ",";
            }
        }

    } catch(std::out_of_range& e) {
        std::cout << "out_of_range: " << e.what() << std::endl;
    } catch(std::runtime_error& e) {
        std::cout << "runtime_error: " << e.what() << std::endl;
    } catch(std::logic_error& e) {
        std::cout << "logic_error: " << e.what() << std::endl;
    } catch(...) {
        std::cout << "Some Exception!" << std::endl;
    }

    sub();
}
