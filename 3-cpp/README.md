## Compile with g++

Run Pre-Processor:

```sh
clang -E hello.c > hello.i
```

Run Compiler:

```sh
clang -S hello.i
```

Run Assembler:

```sh
clang -o hello.o hello.s
```

Run Linker:

```sh
ld -o hello hello.o libs...
```

See what libraries required:
- run below command and search for `collect2` in the output file

```sh
g++ -Q -v -o hello hello.cpp
```

Alternatively, use `--save-temps` flag:

```sh
clang --save-temps hello.c
```

View object file:

```sh
otool -x hello.o > hello.b
otool -xv hello.o > hello.d
```

View hexdump of object file:

```sh
hexdump hello.b
```
