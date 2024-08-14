template <typename T>
class INDArray
{
public:
    virtual T& at(int index) = 0;

    class iterator {
    public:
        virtual iterator& operator++() = 0;
        virtual const T& operator*() = 0;
        virtual bool operator!=(iterator& iter) = 0;
    };
    virtual iterator begin() = 0;
    virtual iterator end() = 0;
};
