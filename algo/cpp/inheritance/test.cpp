#include <iostream>
#include <memory>

template <typename T>
class INDArray {
  public:
    virtual T& at(int index) = 0;

    //virtual typename INDArray<T>::iterator begin() = 0;
    //virtual typename INDArray<T>::iterator end() = 0;

  protected:
    virtual int size() = 0;

  public:
    class iterator {
      public:
        virtual ~iterator() {}

        virtual iterator& operator++() = 0;

        virtual const T& operator*() const = 0;
    };
};

template <typename T>
class Vector : public INDArray<T> {
  private:
    int _size;
    T* _data;

  public:
    Vector(int size) {
      _data = new T[size];
      _size = size;
    }

    T& at(int index) override {
      if (index < 0 || index > _size) {
        throw std::out_of_range("index out of range");
      }
      return _data[index];
    }

    ~Vector() { delete[] _data; }

    class iterator : public INDArray<T>::iterator {
      private:
        Vector<T>* _my_self;
        int _index;

      public:
        iterator(Vector<T>* my_self, int index) : _my_self(my_self), _index(index) {}

        iterator& operator++() override {
          ++_index;
          return *this;
        }

        const T& operator*() const override { return _my_self->_data[_index]; }
    };

    iterator begin() override { return iterator(this, 0); }

    iterator end() override { return iterator(this, _size); }
};

int main() {
  auto a = std::make_shared<Vector<int>>(3);
  a->at(0) = 1;
  a->at(1) = 2;
  a->at(2) = 3;

  for (const auto& v : *a) {
    std::cout << v << ",";
  }
  std::cout << std::endl;

  return 0;
}
