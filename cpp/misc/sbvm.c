#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

#define PROGRAM_SIZE (sizeof(program) / sizeof(Inst))
#define STACK_CAPACITY 1024

typedef enum { INST_PUSH, INST_ADD, INST_PRINT } Inst_Type;

typedef struct {
    Inst_Type type;
    int operand;
} Inst;

Inst program[] = {{.type = INST_PUSH, .operand = 10},
                  {.type = INST_PUSH, .operand = 20},
                  {.type = INST_ADD},
                  {.type = INST_PRINT}};

int stack[STACK_CAPACITY];
size_t stack_pointer = 0;

void push(int value) {
    assert(stack_pointer < STACK_CAPACITY);
    stack[stack_pointer++] = value;
}

int pop(void) {
    assert(stack_pointer > 0);
    return stack[--stack_pointer];
}

void dump(const char *filename) {
    FILE *file = fopen(filename, "wb");
    fwrite(program, sizeof(Inst), PROGRAM_SIZE, file);
    fclose(file);
}

FILE *read_instructions(const char *filename) {
    unsigned buffer[sizeof(Inst)];
    FILE *file = fopen(filename, "rb");
    fread(buffer, sizeof(Inst), 1, file);
    printf("%u\n", buffer);
    fclose(file);
}

int main() {
    printf("Stack Based Virtual Machine in C\n");
    const char *filename = "program.bin";
    read_instructions(filename);
    // dump(filename);

    for (size_t i = 0; i < PROGRAM_SIZE; i++) {
        switch (program[i].type) {
        case INST_PUSH:
            push(program[i].operand);
            break;
        case INST_ADD: {
            int a = pop();
            int b = pop();
            push(a + b);
        } break;
        case INST_PRINT:
            printf("Result: %d\n", pop());
            break;
        default:
            assert(0 && "Invalid instruction.");
            break;
        }
    }
    return 0;
}
