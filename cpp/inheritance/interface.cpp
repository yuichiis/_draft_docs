template <typename T,typename I>
class IA
{
public:
    virtual const T& calc(I value) = 0;
};

template <typename T,typename I>
class A : IA<T,I>
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
    const T& calc(I value) override {
        return data_[value];
    }
};

void main()
{
    A<int,int> a(1);
}