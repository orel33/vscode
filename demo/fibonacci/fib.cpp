
#include <iostream>
using namespace std;

template <int T>
struct Fibonacci
{
    enum { value = (Fibonacci<T - 1>::value + Fibonacci<T - 2>::value) };
};

template <>
struct Fibonacci<0>
{
    enum { value = 1 };
};

template <>
struct Fibonacci<1>
{
    enum { value = 1 };
};

int main()
{
    int sum = Fibonacci<10>::value;
    cout << sum << endl;
}