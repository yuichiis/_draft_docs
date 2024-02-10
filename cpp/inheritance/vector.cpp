#include <iostream>
#include <memory>

template <typename T>
class Vect {
private:
    int size_;
    T *data_;
public:
    Vect(int size) {
        data_ = new T[size];
        size_ = size;
    }
    ~Vect() {
        delete[] data_;
    }
    T& at(int index) {
        if(index<0 || index > size_) {
            throw std::out_of_range("index out of range");
        }
        return data_[index];
    }

    class iterator {
    private:
        Vect<T>* my_self_;
        int index_;
    public:
        iterator(Vect<T>* my_self, int index) : my_self_(my_self), index_(index) {}

        iterator& operator++() {
            ++index_;
            return *this;
        }
        const T& operator*() {
            return my_self_->data_[index_];
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
};

void main()
{
    auto a = std::make_shared<Vect<int>>(3);
    a->at(0) = 1;
    a->at(1) = 2;
    a->at(2) = 3;

    for(const auto& v: *a) {
        std::cout << v << ",";
    }
}
