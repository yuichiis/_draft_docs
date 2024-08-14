
class NestedClass {
public:
    OuterClass *outer_;   // compile error
    NestedClass& GetSelfInstance(OuterClass* outer);
};
class OuterClass {
public:
    NestedClass *nested_;
    OuterClass& GetSelfInstance(NestedClass *nested);
};

NestedClass& NestedClass::GetSelfInstance(OuterClass* outer)  { 
    outer_ = outer;
    return *this;
}
OuterClass& OuterClass::GetSelfInstance(NestedClass *nested) {
    nested_ = nested;
    return *this;
}

int main() {
    NestedClass nestedObj;
    OuterClass outerObj;
    NestedClass returnedObj = nestedObj.GetSelfInstance(&outerObj);
    return 0;
}
