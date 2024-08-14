class OuterClass {
public:
    class NestedClass {
    public:
        NestedClass& GetSelfInstance();
    };
};

OuterClass::NestedClass& OuterClass::NestedClass::GetSelfInstance()  {
    return *this;
}

int main() {
    OuterClass::NestedClass nestedObj;
    OuterClass::NestedClass& returnedObj = nestedObj.GetSelfInstance();
    return 0;
}
