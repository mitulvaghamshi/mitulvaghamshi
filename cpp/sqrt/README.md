# Find Square Root

- Find square root of a number using C++.
- Learn how to use `cmake` to build, test and install applications.
- The [LICENSE](./LICENSE) file in this repository is used only for demonstration purpose.
- Source [cmake.org](https://cmake.org/) and [Gitlab/CMake](https://gitlab.kitware.com/cmake/cmake).

## Configure

Configure `cmake` in a 'build' subdirectory.

```sh
cmake -B ./sqrt/build -DCMAKE_BUILD_TYPE=Release
```

`CMAKE_BUILD_TYPE` is only required if you are using a single-config generator such as make.

## Build

Build your program with the given config

```sh
cmake --build ./sqrt/build --config Release
```

## Test

Execute tests defined by the `cmake` config.

```sh
ctest -C Release
```
