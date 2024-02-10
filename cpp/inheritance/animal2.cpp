#include <iostream>

class IAnimal {
public:
  virtual IAnimal* speak() = 0;
};

class Cat : public IAnimal {
public:
  IAnimal* speak() override {
    std::cout << "nyaa!" << std::endl;
    return this;
  }
};

class Dog : public IAnimal {
public:
  IAnimal* speak() override {
    std::cout << "wan!" << std::endl;
    return this;
  }
};

void main() {
    Cat c;
    Dog d;
    c.speak()->speak();
    d.speak()->speak();
}