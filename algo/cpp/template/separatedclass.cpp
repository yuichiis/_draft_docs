template <typename T>
class OuterClass {
public:
    OuterClass<T>& GetSelfInstance();
};

template <typename T>
OuterClass<T>& OuterClass<T>::GetSelfInstance() {
    return *this;
}

int main() {
    OuterClass<int> outerObj;
    OuterClass<int>& returnedObj = outerObj.GetSelfInstance();
    return 0;
}
