#include <iostream>

class Some
{
public:
    std::string* a_;
    std::string* b_;

    Some(std::string a, std::string b) : a_(new std::string(a)), b_(new std::string(b))
    {
        std::cout << "new(a=" << *a_ << ",b=" << *b_ << ")" << std::endl;
    }
    Some() : a_(new std::string("Hello")), b_(new std::string("World"))
    {
    }
    // copy constructor
    Some(const Some& other)
    {
        this->a_ = new std::string(*other.a_);
        this->b_ = new std::string(*other.b_);
        std::cout << "copy(a=" << *a_ << ",b=" << *b_ << ")" << std::endl;
    }
    // move constructor
    Some(Some&& other)
    {
        this->a_ = other.a_;
        this->b_ = other.b_;
        other.a_ = nullptr;
        other.b_ = nullptr;
        std::cout << "move(a=" << *a_ << ",b=" << *b_ << ")" << std::endl;
    }
    ~Some()
    {
        std::cout << "free(";
        if(a_!=nullptr) {
            std::cout << "a=" << *a_ << ",";
            delete a_;
        }
        if(b_!=nullptr) {
            std::cout << "b=" << *b_ ;
            delete b_;
        }
        std::cout << ")" << std::endl;
    }
    const std::string& a()
    {
        return *a_;
    }
    const std::string& b()
    {
        return *b_;
    }
};
std::ostream& operator<<(std::ostream &s, const Some &some) {
    return s << "(" + *some.a_ + "," + *some.b_ + ")";
}

class factory
{
public:
    Some* some_; 
    Some someinst_ = {"inst","member"};
 
    factory() : some_(new Some("made","member"))
    {
    }
    const Some make()
    {
        // move
        Some a("made","obj");
        return a;
    }
    const Some& getinstconstref()
    {
        return someinst_;
    }
    const Some getinstconst()
    {
        return someinst_;
    }
    const Some& getptrconstref()
    {
        return *some_;
    }
    const Some getptrconst()
    {
        return *some_;
    }
    Some& getinstref()
    {
        return someinst_;
    }
    Some getinst()
    {
        return someinst_;
    }
};

void main()
{
    Some obj;
    std::cout << "obj:" << obj << std::endl;
    Some obj2("new","obj2");
    std::cout << "obj2:" << obj2 << std::endl;
    Some obj3 = obj;
    std::cout << "obj3:" << obj3 << std::endl;
    Some obj4 = std::move(obj);
    std::cout << "obj4:" << obj4 << std::endl;
    factory f;

    // Move constructor works when local variable is used as return value
    Some obj5 = f.make();
    std::cout << "obj5:" << obj5 << std::endl;

    // Even though the return value is a reference type, it is copied
    const Some obj6 = f.getinstconstref();
    std::cout << "obj6:" << obj6 << std::endl;
    // Reference type variables can avoid copying
    const Some& obj7 = f.getinstconstref();
    std::cout << "obj7:" << obj7 << std::endl;

    // If the return value is not a reference type, it will be copied regardless of the receiving variable.
    const Some obj8 = f.getinstconst();
    std::cout << "obj8:" << obj8 << std::endl;
    const Some& obj9 = f.getinstconst();
    std::cout << "obj9:" << obj9 << std::endl;

    // The behavior is the same even with the auto declaration.
    auto autoobj = f.getinstconstref();
    std::cout << "autoobj:" << autoobj << std::endl;
    auto& autoobjref = f.getinstconstref();
    std::cout << "autoobjref:" << autoobjref << std::endl;

    // The behavior is the same when the return value is a pointer converted to a reference.
    const Some pobj6 = f.getptrconstref();
    std::cout << "pobj6:" << pobj6 << std::endl;
    const Some& pobj7 = f.getptrconstref();
    std::cout << "pobj7:" << pobj7 << std::endl;
    const Some pobj8 = f.getptrconst();
    std::cout << "pobj8:" << pobj8 << std::endl;
    const Some& pobj9 = f.getptrconst();
    std::cout << "pobj9:" << pobj9 << std::endl;

    // The behavior is the same for non-const return values.
    const Some robj6 = f.getinstref();
    std::cout << "robj6:" << robj6 << std::endl;
    const Some& robj7 = f.getinstref();
    std::cout << "robj7:" << robj7 << std::endl;
    const Some robj8 = f.getinst();
    std::cout << "robj8:" << robj8 << std::endl;
    const Some& robj9 = f.getinst();
    std::cout << "robj9:" << robj9 << std::endl;

    // The behavior is the same even if the received variable is not const.
    Some vrobj6 = f.getinstref();
    std::cout << "vrobj6:" << vrobj6 << std::endl;
    Some& vrobj7 = f.getinstref();
    std::cout << "vrobj7:" << vrobj7 << std::endl;
    Some vrobj8 = f.getinst();
    std::cout << "vrobj8:" << vrobj8 << std::endl;
    Some& vrobj9 = f.getinst();
    std::cout << "vrobj9:" << vrobj9 << std::endl;
}