#include <iostream>
#include <vector>
#include <array>
#include <iterator>

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
    vec.at(2) = 10;
    std::cout << "vec.at(2)=10 =" << vec.at(2) << std::endl;
    vec[2] = 100;
    std::cout << "vec[2]=100 =" << vec[2] << std::endl;

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
    std::cout << "vec.swap(vec2)=";
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

    std::cout << "vector<int> vec(3): ";
    std::vector<int> vec3(3);
    vec3[0] = 1;
    vec3[1] = 2;
    vec3[2] = 3;
    for(const auto& value : vec3) {
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
    arr.at(2) = 10;
    std::cout << "arr.at(2)=10 =" << arr.at(2) << std::endl;
    arr[2] = 20;
    std::cout << "arr[2]=20 =" << arr[2] << std::endl;
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
    std::cout << "arr.swap(arr2)=";
    arr.swap(arr2);
    for(const auto& value : arr) {
        std::cout << value << ",";
    }
    std::cout << std::endl;
}

void pointer_sample(void)
{
    std::cout << "====pointer====" << std::endl;
    int* arr = new int(4);
    std::initializer_list<int> init = {1,2,3,4};
    std::copy_n(init.begin(),4,arr);
    //std::cout << "arr.size()=" << arr.size() << std::endl;
    //std::cout << "arr.max_size()=" << arr.max_size() << std::endl;
    //std::cout << "arr.at(2)=" << arr.at(2) << std::endl;
    std::cout << "arr[2]=" << arr[2] << std::endl;
    //std::cout << "arr.front()=" << arr.front() << std::endl;
    //std::cout << "arr.back()=" << arr.back() << std::endl;
    //arr.at(2) = 10;
    //std::cout << "arr.at(2)=10 =" << arr.at(2) << std::endl;
    arr[2] = 20;
    std::cout << "arr[2]=20 =" << arr[2] << std::endl;
    //std::cout << "for(const auto& value : arr)=";
    //for(const auto& value : arr) {
    //    std::cout << value << ",";
    //}
    //std::cout << std::endl;
    std::cout << "for(auto i=arr;i!=arr+4;i++)=";
    for(auto i=arr;i!=arr+4;i++) {
        std::cout << *i << ",";
    }
    std::cout << std::endl;
    std::cout << "for(auto i=v.rbegin();i!=v.rend();i++)=";
    for(auto i=arr+4-1;i!=arr-1;i--) {
        std::cout << *i << ",";
    }
    std::cout << std::endl;
    std::cout << "int *arr_p=arr; *arr_p++=";
    int *arr_p=arr;
    for(int i=0;i<4;i++) {
        std::cout << *arr_p++ << ",";
    }
    std::cout << std::endl;
    //arr.fill(3);
    //std::cout << "arr.fill(3)=";
    //for(const auto& value : arr) {
    //    std::cout << value << ",";
    //}
    //std::cout << std::endl;
    //std::cout << "arr.empty()=" << arr.empty() << std::endl;
    //std::array<int,4> arr2 = {5,6,7,8};
    //std::cout << "arr.swap(arr2)=";
    //arr.swap(arr2);
    //for(const auto& value : arr) {
    //    std::cout << value << ",";
    //}
    //std::cout << std::endl;
    int arr1d[4] = {1,2,3,4};
    std::cout << "for(const auto& value : arr1d)=";
    for(const auto& value : arr1d) {
        std::cout << value << ",";
    }
    std::cout << std::endl;
    std::cout << "for(auto i=std::begin(arr1d);i!=std::end(arr1d);i++)=";
    for(auto i=std::begin(arr1d);i!=std::end(arr1d);i++) {
        std::cout << *i << ",";
    }
    std::cout << std::endl;
    int arr2d[2][2] = {{1,2},{3,4}};
    std::cout << "for(const auto& i : arr2d)=";
    for(const auto& i : arr2d) {
        for(const auto& value : i) {
            std::cout << value << ",";
        }
    }
    std::cout << std::endl;
    std::cout << "for(auto i=std::begin(arr2d);i!=std::end(arr2d);i++)=";
    for(auto i=std::begin(arr2d);i!=std::end(arr2d);i++) {
        for(auto j=std::begin(*i);j!=std::end(*i);j++) {
            std::cout << *j << ",";
        }
    }
    std::cout << std::endl;
}

int main()
{
    try {
        vector_sample();
        array_sample();
        pointer_sample();
    } catch(std::out_of_range& e) {
        std::cout << "out_of_range: " << e.what() << std::endl;
    } catch(std::runtime_error& e) {
        std::cout << "runtime_error: " << e.what() << std::endl;
    } catch(std::logic_error& e) {
        std::cout << "logic_error: " << e.what() << std::endl;
    } catch(...) {
        std::cout << "Some Exception!" << std::endl;
    }
}
