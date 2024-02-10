#include <iostream>
#include <iterator>

template <typename T>
class Node {
public:
  T value;
  Node* next;

  Node(const T& value) : value(value), next(nullptr) {}
};

template <typename T>
class LinkedList {
public:
  using value_type = T;
  using iterator = Node<T>*;

  LinkedList() {
    head_ = nullptr;
    tail_ = nullptr;
  }

  void push_back(const T& value) {
    auto new_node = new Node<T>(value);
    if (tail_ == nullptr) {
      head_ = tail_ = new_node;
    } else {
      tail_->next = new_node;
      tail_ = new_node;
    }
  }

  iterator begin() {
    return head_;
  }

  iterator end() {
    return nullptr;
  }

  const T& operator*(iterator it) const {
    return it->value;
  }

private:
  Node<T>* head_;
  Node<T>* tail_;
};

int main() {
  LinkedList<int> list;
  list.push_back(1);
  list.push_back(2);
  list.push_back(3);

  for (auto it = list.begin(); it != list.end(); ++it) {
    std::cout << *it << std::endl;
  }

  return 0;
}
