#include <iostream>
#include <memory>
#include <initializer_list>
#include <numeric>
#include <vector>
#include <algorithm>
#include <cstdint>

template <typename T>
class NDArray {
public:
    using ndarray_t = std::shared_ptr<NDArray<T>>;
    using index_t = std::uint32_t;
    using shape_t = std::vector<index_t>;
    static ndarray_t alloc(std::initializer_list<index_t> shape)
    {
        shape_t shape2;
        std::copy(shape.begin(), shape.end(), std::back_inserter(shape2));
        return std::make_shared<NDArray<T>>(&shape2);
    }

    static ndarray_t fill(std::initializer_list<index_t> shape, T value)
    {
        auto array = alloc(shape);
        auto buffer = array->buffer();
        std::fill(buffer->begin(), buffer->end(), value);
        return array;
    }

    static ndarray_t zeros(std::initializer_list<index_t> shape)
    {
        return fill(shape,(T)0);
    }

    static ndarray_t ones(std::initializer_list<index_t> shape)
    {
        return fill(shape,(T)1);
    }

    NDArray(shape_t* shape) : NDArray(
        std::make_shared<std::vector<T>>(
            std::accumulate(shape->begin(), shape->end(), 1, std::multiplies<index_t>())),
        shape,
        0
    ) {}

    NDArray(std::shared_ptr<std::vector<T>> data, shape_t* shape, index_t offset) {
        num_items_ = std::accumulate(shape->begin(), shape->end(), 1, std::multiplies<index_t>());
        data_ = data;
        if(offset >= data->size()) {
            throw std::out_of_range("index out of range");
        }
        offset_ = offset;
        if(shape->size()==0) {
            size_ = 0;
        } else {
            size_ = shape->front();
        }
        std::copy(shape->begin(), shape->end(), std::back_inserter(shape_));
    }

    const size_t ndim(void) {
        return shape_.size();
    }

    const shape_t& shape(void) {
        return shape_;
    }

    const index_t offset(void) {
        return offset_;
    }

    const index_t size(void) {
        return size_;
    }

    const index_t num_items(void) {
        return num_items_;
    }

    const std::shared_ptr<std::vector<T>> buffer(void) {
        return data_;
    }

    const T* data(void) {
        return &(data_->data()[offset_]);
    }

    ndarray_t at(index_t index) {
        if(shape_.size()==0) {
            throw std::out_of_range("Indexes cannot be applied to scalars.");
        }
        if(index >= size_) {
            throw std::out_of_range("index out of range");
        }
        shape_t shape;
        std::copy(shape_.begin()+1, shape_.end(), std::back_inserter(shape));
        index_t num_items = std::accumulate(shape.begin(), shape.end(), 1, std::multiplies<index_t>());
        index_t offset = offset_+index*num_items;
        auto array = std::make_shared<NDArray<T>>(data_, &shape, offset);
        return array;
    }

    T& operator[](std::initializer_list<index_t> indexes) {
        if(shape_.size()!=indexes.size()) {
            throw std::out_of_range("The index and array dimensions do not match.");
        }
        auto s = shape_.begin();
        auto i = indexes.begin();
        index_t index = 0;
        index_t scale = 1;
        for(;s!=shape_.end();++s,++i) {
            if(*i>=*s) {
                throw std::out_of_range("index out of range");
            }
            index *= scale;
            index += *i;
            scale = *s;
        }
        if(index>=num_items_) {
            throw std::runtime_error("invalid index");
        }
        if(offset_+index>=data_->size()) {
            throw std::runtime_error("The index makes overflow");
        }
        return data_->at(offset_+index);
    }

    bool is_scalar(void) {
        return size_ == 0;
    }

    T& scalar(void) {
        if(!is_scalar()) {
            throw std::out_of_range("It's not a scalar variable.");
        }
        auto array = &data_->at(offset_);
        return *array;
    }

    class iterator {
    private:
        NDArray<T>* my_self_;
        index_t index_;
    public:
        iterator(NDArray<T>* my_self, index_t index) : my_self_(my_self), index_(index) {}

        iterator& operator++() {
            ++index_;
            return *this;
        }

        const ndarray_t operator*() {
            auto array = my_self_->at(index_);
            return array;
        }

        bool operator!=(iterator& iter) {
            return index_ != iter.index_;
        }
    };

    iterator begin() {
        return iterator(this, 0);
    }

    iterator end() {
        return iterator(this, size_);
    }
private:
    shape_t shape_;
    index_t offset_;
    index_t size_;
    index_t num_items_;
    std::shared_ptr<std::vector<T>> data_;
};

void main()
{
    try {
        //auto a = NDArray<int>::alloc({2,2});
        NDArray<int>::ndarray_t a = NDArray<int>::alloc({2,2});
        std::cout << "ndim: " << a->ndim() << std::endl;
        std::cout << "shape: "; for(auto&v:a->shape()){std::cout << v << ",";}; std::cout << std::endl;
        std::cout << "offset: " << a->offset() << std::endl;
        std::cout << "size: " << a->size() << std::endl;
        std::cout << "num_items: " << a->num_items() << std::endl;
        a->at(0)->at(0)->scalar() = 1;
        a->at(0)->at(1)->scalar() = 2;
        a->at(1)->at(0)->scalar() = 3;
        a->at(1)->at(1)->scalar() = 4;
        // a->at(2)->at(0)->scalar() = 5; out of range
        //std::cout << "a->scalar():" << a->scalar() << std::endl;
        std::cout << "(*a)[{1,1}]: " << (*a)[{1,1}] << std::endl;
        std::cout << "(*a)[{1,1}] = 5;" << std::endl;
        (*a)[{1,1}] = 5;
        auto buffer = a->buffer();
        for(const auto& v: *buffer) {
            std::cout << v << ",";
        }
        std::cout << std::endl;
        auto addr = a->data();
        auto size = a->num_items();
        for(int i=0;i<size;i++) {
            std::cout << addr[i] << ",";
        }
        std::cout << std::endl;

        //std::cout << "===for()===" << std::endl;
        //std::cout << "row size:" << a->size() << std::endl;
        for(const auto& v: *a) {
            //std::cout << "col size:" << v->size() << std::endl;
            for(const auto& vv: *v) {
                //std::cout << "item size:" << vv->size() << std::endl;
                if(vv->is_scalar()) {
                    std::cout << "[" << vv->offset() << "]=" << vv->scalar() << ",";
                }
            }
            std::cout << std::endl;
        }
        //std::cout << "===end for()===" << std::endl;

        for(unsigned int i=0;i<2;++i) {
            for(unsigned int j=0;j<2;++j) {
                std::cout << (*a)[{i,j}] << ",";
            }
        }
        std::cout << std::endl;

        auto b = NDArray<int>::fill({2,2},123);
        for(unsigned int i=0;i<2;++i) {
            for(unsigned int j=0;j<2;++j) {
                std::cout << (*b)[{i,j}] << ",";
            }
        }
        std::cout << std::endl;

        auto zeros = NDArray<int>::zeros({2,2});
        for(unsigned int i=0;i<2;++i) {
            for(unsigned int j=0;j<2;++j) {
                std::cout << (*zeros)[{i,j}] << ",";
            }
        }
        std::cout << std::endl;

        auto ones = NDArray<int>::ones({2,2});
        for(unsigned int i=0;i<2;++i) {
            for(unsigned int j=0;j<2;++j) {
                std::cout << (*ones)[{i,j}] << ",";
            }
        }
        std::cout << std::endl;

    } catch(std::out_of_range& e) {
        std::cout << "out_of_range: " << e.what() << std::endl;
    } catch(std::runtime_error& e) {
        std::cout << "runtime_error: " << e.what() << std::endl;
    } catch(std::logic_error& e) {
        std::cout << "logic_error: " << e.what() << std::endl;
    } catch(...) {
        std::cout << "Some Exception!" << std::endl;
    }
}
