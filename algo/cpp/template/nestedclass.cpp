template <typename T>
class OuterClass {
public:
    class NestedClass {
    public:
        NestedClass& GetSelfInstance()  {
            return *this;
        }
    };
};

int main() {
    OuterClass<int>::NestedClass nestedObj;
    OuterClass<int>::NestedClass& returnedObj = nestedObj.GetSelfInstance();
    return 0;
}
