#ifndef RINDOW_MATH_NDARRAY_H
#define RINDOW_MATH_NDARRAY_H

#include <initializer_list>
#include <memory>
#include <cstdint>
#include <vector>

namespace rindow {
template <typename T>
class NDArray {
public:
    using ndarray_t = std::shared_ptr<NDArray<T>>;
    using index_t = std::uint32_t;
    using shape_t = std::vector<index_t>;
    static ndarray_t alloc(std::initializer_list<index_t> shape);
    static ndarray_t fill(std::initializer_list<index_t> shape, T value);
    static ndarray_t zeros(std::initializer_list<index_t> shape);
    static ndarray_t ones(std::initializer_list<index_t> shape);
    NDArray(shape_t* shape);
    NDArray(std::shared_ptr<std::vector<T>> data, shape_t* shape, index_t offset);
    ~NDArray();
    const size_t ndim(void);
    const shape_t& shape(void);
    const index_t offset(void);
    const index_t size(void);
    const index_t num_items(void);
    const std::shared_ptr<std::vector<T>> buffer(void);
    const T* data(void);
    ndarray_t at(index_t index);
    T& at(std::initializer_list<index_t> indexes);
    const T& at(std::initializer_list<index_t> indexes) const;
    T& operator[](index_t index);
    T& operator[](std::initializer_list<index_t> indexes);
    bool is_scalar(void);
    T& scalar(void);
    class iterator {
    public:
        iterator(NDArray<T>* my_self, index_t index);
        typename iterator& operator++(void);
        const ndarray_t operator*(void);
        bool operator!=(const iterator& iter);
        index_t index(void);
        NDArray<T>* debug(void);
    private:
        NDArray<T>* my_self_;
        index_t index_;
    };
    iterator begin();
    iterator end();
    ndarray_t at(iterator index);
    class viterator {
    public:
        viterator(NDArray<T>* my_self, index_t index);
        viterator& operator++();
        const T& operator*() const;
        T& operator*();
        bool operator!=(const viterator& iter);
        index_t index(void);
        NDArray<T>* debug(void);
    };
    viterator vbegin();
    viterator vend();
private:
    shape_t shape_;
    index_t offset_;
    index_t size_;
    index_t num_items_;
    std::shared_ptr<std::vector<T>> data_;
};
}
#endif // RINDOW_MATH_NDARRAY_H
