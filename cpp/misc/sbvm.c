#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

#define STACK_CAPACITY 1024
#define PROGRAM_SIZE (sizeof(program) / sizeof(Instruction))

typedef enum { PUSH, ADD, PRINT, DUMP, LOAD } OpCode;
typedef unsigned short Value;
typedef struct {
  OpCode opcode;
  Value value;
} Instruction;

Instruction program[] = {{.opcode = PUSH, .value = 10},
                         {.opcode = PUSH, .value = 20},
                         {.opcode = ADD},
                         {.opcode = PRINT},
                         {.opcode = DUMP},
                         {.opcode = LOAD}};

int stack[STACK_CAPACITY];
size_t stack_pointer = 0;

void push(Value value) {
  assert(stack_pointer < STACK_CAPACITY);
  stack[stack_pointer++] = value;
}

int pop(void) {
  assert(stack_pointer > 0);
  return stack[--stack_pointer];
}

void dump(const char *filename) {
  FILE *file = fopen(filename, "wb");
  fwrite(program, sizeof(Instruction), PROGRAM_SIZE, file);
  fclose(file);
}

void load(const char *filename) {
  unsigned buffer[sizeof(Instruction)];
  FILE *file = fopen(filename, "rb");
  fread(buffer, sizeof(Instruction), 1, file);
  fclose(file);
}

int main(void) {
  printf("Stack Based Virtual Machine in C\n");

  const char *filename = "program.bin";

  for (size_t i = 0; i < PROGRAM_SIZE; i++) {
    switch (program[i].opcode) {
    case PUSH:
      push(program[i].value);
      break;
    case ADD:
      push(pop() + pop());
      break;
    case PRINT: {
      Value v = pop();
      push(v);
      printf("Result: %0X\n", v);
    } break;
    case DUMP:
      dump(filename);
      break;
    case LOAD:
      load(filename);
      break;
    default:
      assert(0 && "Unrecognized instruction encountered!");
      break;
    }
  }

  return 0;
}
