#include <iostream>

///////interface classes //////////

template <typename T>
class IA
{
public:
    class IAA
    {
    //private:
    //    int value_;
    public:
        virtual const T& get() = 0;
        virtual void set(T value) = 0;
    };
    virtual IAA* get(int index) = 0;
};

///////instance classes //////////


template <typename T>
class A : public IA<T>
{
private:
    int size_;
    T *data_;
public:
    A(int size) {
        data_ = new T[size];
        size_ = size;
    }
    ~A() {
        delete[] data_;
    }

    class AA : public IA::IAA
    {
    private:
        T value_;
    public:
        AA(T value) {
            value_ = value;
        }
        const T& get() override {
            return value_;
        }
        void set(T value) override {
            value_ = value;
        }
    };

    IAA* get(int index) override
    {
        if(index<0 || index > size_) {
            throw std::out_of_range("index out of range");
        }
        return new AA(data_[index]);  /// compile error
    }
};


int main()
{
    A<int> a(0);
    //Cat cat;
    //IAnimal *c = &cat;
}