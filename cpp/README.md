## Compile steps

```sh
# Run Pre-Processor:
clang -E hello.c > hello.i
# Run Compiler:
clang -S hello.i
# Run Assembler:
clang -o hello.o hello.s
# Run Linker:
ld -o hello hello.o libs...
# Or use --save-temps flag
clang --save-temps hello.c
# See what libraries required
g++ -Q -v -o hello hello.cpp && cat hello.cpp | grep 'collect2'
# View object file:
otool -x hello.o > hello.b
otool -xv hello.o > hello.d
# View hexdump of object file:
hexdump hello.b
```
