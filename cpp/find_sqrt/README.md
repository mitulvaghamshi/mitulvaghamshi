# Find Square Root

- Find square root of a number using C++.
- Learn how to use cmake to build, test and install applications.
- The source is reference to official [cmake.org](https://cmake.org/) and
  [Gitlab/CMake](https://gitlab.kitware.com/cmake/cmake) repo.
- The [LICENSE](./LICENSE) file in this repository is used only for
  demonstration purpose.

## Configure

Configure CMake in a 'build' subdirectory.

`CMAKE_BUILD_TYPE` is only required if you are using a single-configuration
generator such as make.

```console
cmake -B ./cmake_tutorial/build -DCMAKE_BUILD_TYPE=Release
-- The C compiler identification is GNU 11.3.0
-- The CXX compiler identification is GNU 11.3.0
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working C compiler: /usr/bin/cc - skipped
-- Detecting C compile features
-- Detecting C compile features - done
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Check for working CXX compiler: /usr/bin/c++ - skipped
-- Detecting CXX compile features
-- Detecting CXX compile features - done
-- Configuring done
-- Generating done
-- Build files have been written to: ./cmake_tutorial/build
```

## Build

Build your program with the given configuration

```console
cmake --build ./cmake_tutorial/build --config Release
[ 11%] Building CXX object MathFunctions/CMakeFiles/MakeTable.dir/MakeTable.cxx.o
[ 22%] Linking CXX executable ../MakeTable
[ 22%] Built target MakeTable
[ 33%] Generating Table.h
[ 44%] Building CXX object MathFunctions/CMakeFiles/SqrtLibrary.dir/mysqrt.cxx.o
[ 55%] Linking CXX static library ../libSqrtLibrary.a
[ 55%] Built target SqrtLibrary
[ 66%] Building CXX object MathFunctions/CMakeFiles/MathFunctions.dir/MathFunctions.cxx.o
[ 77%] Linking CXX shared library ../libMathFunctions.so
[ 77%] Built target MathFunctions
[ 88%] Building CXX object CMakeFiles/Tutorial.dir/tutorial.cxx.o
[100%] Linking CXX executable Tutorial
[100%] Built target Tutorial
```

## Test

Execute tests defined by the CMake configuration.

```console
ctest -C Release
Test project ./cmake_tutorial/build
    Start 1: Runs
1/9 Test #1: Runs .............................   Passed    0.00 sec
    Start 2: Usage
2/9 Test #2: Usage ............................   Passed    0.00 sec
    Start 3: Comp4
3/9 Test #3: Comp4 ............................   Passed    0.00 sec
    Start 4: Comp9
4/9 Test #4: Comp9 ............................   Passed    0.00 sec
    Start 5: Comp5
5/9 Test #5: Comp5 ............................   Passed    0.00 sec
    Start 6: Comp7
6/9 Test #6: Comp7 ............................   Passed    0.00 sec
    Start 7: Comp25
7/9 Test #7: Comp25 ...........................   Passed    0.00 sec
    Start 8: Comp-25
8/9 Test #8: Comp-25 ..........................   Passed    0.00 sec
    Start 9: Comp0.0001
9/9 Test #9: Comp0.0001 .......................   Passed    0.00 sec

100% tests passed, 0 tests failed out of 9

Total Test time (real) =   0.11 sec
```
