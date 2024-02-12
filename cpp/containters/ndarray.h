#ifndef RINDOW_MATH_NDARRAY_H
#define RINDOW_MATH_NDARRAY_H

#include <iostream>
#include <memory>
#include <initializer_list>
#include <numeric>
#include <vector>
#include <algorithm>

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

        if(ndim()==0 && size()!=0) {
            std::cout  << std::endl << "size=" << size() << std::endl;
            throw std::runtime_error("invalid size");
        }
        //std::cout << "alloc(" << offset_ << ")";
    }
    ~NDArray() {
        //std::cout << "delete(" << offset_ << ")";
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

    T& at(std::initializer_list<index_t> indexes) {
        return data_->at(vector_index(indexes));
    }
    const T& at(std::initializer_list<index_t> indexes) const {
        return data_->at(vector_index(indexes));
    }

    T& operator[](index_t index) {
        return at(index);
    }
    T& operator[](std::initializer_list<index_t> indexes) {
        return at(indexes);
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
        iterator(NDArray<T>* my_self, index_t index) : my_self_(my_self), index_(index) {
            //std::cout << "operator(),";
        }

        iterator& operator++() {
            //std::cout << "operator+,";
            ++index_;
            return *this;
        }

        const ndarray_t operator*() {
            //std::cout << "operator*,";
            auto array = my_self_->at(index_);
            return array;
        }

        bool operator!=(const iterator& iter) {
            //std::cout << "operator!=,";
            return index_ != iter.index_;
        }

        index_t index(void) {
            return index_;
        }

        NDArray<T>* debug(void) {
            return my_self_;
        }
    };

    iterator begin() {
        return iterator(this, 0);
    }

    iterator end() {
        return iterator(this, size_);
    }

    ndarray_t at(iterator index) {
        return at(index.index());
    }

    class viterator {
    private:
        NDArray<T>* my_self_;
        index_t index_;
    public:
        viterator(NDArray<T>* my_self, index_t index) : my_self_(my_self), index_(index) {
            //std::cout << "operator(),";
        }

        viterator& operator++() {
            //std::cout << "operator+,";
            ++index_;
            return *this;
        }

        const T& operator*() const {
            //std::cout << "operator*,";
            index_t index = my_self_->offset_+index_;
            if(index>=my_self_->data_->size()) {
                throw std::runtime_error("The index makes overflow");
            }
            return my_self_->data_->at(index);
        }
        T& operator*() {
            index_t index = my_self_->offset_+index_;
            if(index>=my_self_->data_->size()) {
                throw std::runtime_error("The index makes overflow");
            }
            return my_self_->data_->at(index);
        }

        bool operator!=(const viterator& iter) {
            //std::cout << "operator!=,";
            return index_ != iter.index_;
        }

        index_t index(void) {
            return index_;
        }

        NDArray<T>* debug(void) {
            return my_self_;
        }
    };

    viterator vbegin() {
        return viterator(this, 0);
    }

    viterator vend() {
        return viterator(this, num_items_);
    }

private:
    shape_t shape_;
    index_t offset_;
    index_t size_;
    index_t num_items_;
    std::shared_ptr<std::vector<T>> data_;

    index_t vector_index(std::initializer_list<index_t> indexes)
    {
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
        return offset_+index;
    }
};

#endif // RINDOW_MATH_NDARRAY_H
