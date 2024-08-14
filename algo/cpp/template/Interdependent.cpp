
template <typename T>
class NestedClass {
public:
    OuterClass<T> *outer_;
    NestedClass& GetSelfInstance(OuterClass* a);
};

template <typename T>
class OuterClass {
public:
    OuterClass<T> *outer_;
    OuterClass& GetSelfInstance(NestedClass<T> *outer);
};

template <typename T>
NestedClass<T>& NestedClass<T>::GetSelfInstance(OuterClass* a)  { /// compile error
    outer_ = outer;
    return *this;
}
template <typename T>
OuterClass<T>& OuterClass<T>::GetSelfInstance(NestedClass<T> *outer)  {
    outer_ = outer;
    return *this;
}

int main() {
    NestedClass<int> nestedObj;
    OuterClass<int> outerObj;
    NestedClass<int> returnedObj = nestedObj.GetSelfInstance(&outerObj);
    return 0;
}
