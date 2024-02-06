#include <iostream>
#include <vector>
#include <array>

void vector_sample(void)
{
    std::cout << "====vector====" << std::endl;
    std::vector<int> vec = {1,2,3,4};
    std::cout << "vec.size()=" << vec.size() << std::endl;
    std::cout << "vec.max_size()=" << vec.max_size() << std::endl;
    std::cout << "vec.at(2)=" << vec.at(2) << std::endl;
    std::cout << "vec[2]=" << vec[2] << std::endl;
    std::cout << "vec.front()=" << vec.front() << std::endl;
    std::cout << "vec.back()=" << vec.back() << std::endl;

    std::cout << "for(const auto& value : vec)=";
    for(const auto& value : vec) {
        std::cout << value << ",";
    }
    std::cout << std::endl;

    std::cout << "for(auto i=v.begin();i!=v.end();i++)=";
    for(auto i=vec.begin();i!=vec.end();i++) {
        std::cout << *i << ",";
    }
    std::cout << std::endl;

    std::cout << "for(auto i=v.rbegin();i!=v.rend();i++)=";
    for(auto i=vec.rbegin();i!=vec.rend();i++) {
        std::cout << *i << ",";
    }
    std::cout << std::endl;

    std::cout << "int *vec_p=vec.data(); *vec_p++=";
    int *vec_p=vec.data();
    for(int i=0;i<4;i++) {
        std::cout << *vec_p++ << ",";
    }
    std::cout << std::endl;

    std::cout << "Unsupported:: vec.fill(3)=" << std::endl;

    std::cout << "vec.empty()=" << vec.empty() << std::endl;
    std::vector<int> vec2 = {5,6,7,8};
    vec.swap(vec2);
    for(const auto& value : vec) {
        std::cout << value << ",";
    }
    std::cout << std::endl;

    std::cout << "vec.empty()=" << vec.empty() << std::endl;

    vec.pop_back();
    std::cout << "vec.pop_back()=";
    for(const auto& value : vec) {
        std::cout << value << ",";
    }
    std::cout << std::endl;

    vec.pop_back();
    vec.pop_back();
    vec.pop_back();
    std::cout << "vec.pop_back() x 3=";
    for(const auto& value : vec) {
        std::cout << value << ",";
    }
    std::cout << std::endl;
    std::cout << "vec.empty()=" << vec.empty() << std::endl;

    vec.push_back(1);
    vec.push_back(2);
    vec.push_back(3);
    std::cout << "vec.push_back() x 3=";
    for(const auto& value : vec) {
        std::cout << value << ",";
    }
    std::cout << std::endl;
    
    vec.insert(vec.begin()+2,5);
    std::cout << "vec.insert(+2,5)=";
    for(const auto& value : vec) {
        std::cout << value << ",";
    }
    std::cout << std::endl;
    vec.insert(vec.begin()+2,2,6);
    std::cout << "vec.insert(+2,2,6)=";
    for(const auto& value : vec) {
        std::cout << value << ",";
    }
    std::cout << std::endl;
    vec.erase(vec.begin()+1);
    std::cout << "vec.erase(+1)=";
    for(const auto& value : vec) {
        std::cout << value << ",";
    }
    std::cout << std::endl;
    vec.erase(vec.begin()+1,vec.begin()+3);
    std::cout << "vec.erase(+1,+3)=";
    for(const auto& value : vec) {
        std::cout << value << ",";
    }
    std::cout << std::endl;
    vec.erase(vec.begin()+1,vec.end());
    std::cout << "vec.erase(+1,end)=";
    for(const auto& value : vec) {
        std::cout << value << ",";
    }
    std::cout << std::endl;
    vec.clear();
    std::cout << "vec.clear()=";
    for(const auto& value : vec) {
        std::cout << value << ",";
    }
    std::cout << std::endl;
}

void array_sample(void)
{
    std::cout << "====array====" << std::endl;
    std::array<int,4> arr = {1,2,3,4};
    std::cout << "arr.size()=" << arr.size() << std::endl;
    std::cout << "arr.max_size()=" << arr.max_size() << std::endl;
    std::cout << "arr.at(2)=" << arr.at(2) << std::endl;
    std::cout << "arr[2]=" << arr[2] << std::endl;
    std::cout << "arr.front()=" << arr.front() << std::endl;
    std::cout << "arr.back()=" << arr.back() << std::endl;
    std::cout << "for(const auto& value : arr)=";
    for(const auto& value : arr) {
        std::cout << value << ",";
    }
    std::cout << std::endl;
    std::cout << "for(auto i=v.begin();i!=v.end();i++)=";
    for(auto i=arr.begin();i!=arr.end();i++) {
        std::cout << *i << ",";
    }
    std::cout << std::endl;
    std::cout << "for(auto i=v.rbegin();i!=v.rend();i++)=";
    for(auto i=arr.rbegin();i!=arr.rend();i++) {
        std::cout << *i << ",";
    }
    std::cout << std::endl;
    std::cout << "int *arr_p=arr.data(); *arr_p++=";
    int *arr_p=arr.data();
    for(int i=0;i<4;i++) {
        std::cout << *arr_p++ << ",";
    }
    std::cout << std::endl;
    arr.fill(3);
    std::cout << "arr.fill(3)=";
    for(const auto& value : arr) {
        std::cout << value << ",";
    }
    std::cout << std::endl;
    std::cout << "arr.empty()=" << arr.empty() << std::endl;
    std::array<int,4> arr2 = {5,6,7,8};
    arr.swap(arr2);
    for(const auto& value : arr) {
        std::cout << value << ",";
    }
    std::cout << std::endl;
}
int main()
{
    vector_sample();
    array_sample();
}
