### Read strings from console

```c
char str[50];
scanf("%s", str); // read from stdin
printf("You've entered: %s", str);
```

```c
char str[50];
fgets(str, sizeof(str), stdin);
printf("You entered: ");
puts(str);
```

## String Functions

C in-built string functions to manipulate null-terminated strings.

| Function name      | Description                                                                                                 |
| :----------------- | :---------------------------------------------------------------------------------------------------------- |
| strlen(str)        | to return the length of string str                                                                          |
| strcat(str1, str2) | to concatenate string str2 onto the end of string str1.                                                     |
| strcpy(str1, str2) | To copy string str2 into string str1.                                                                       |
| strcmp(str1, str2) | returns 0 if str1 and str2 are the same and less than 0 if str1 < str2 and a positive number if str1 > str2 |
| strchr(str, c)     | Returns a pointer to the first occurrence of character c in string str                                      |
| strstr(str1, str2) | Returns a pointer to the first occurrence of string str2 in string str1                                     |

### Examples

```c
#include <stdio.h>
#include <string.h>

int main () {
	char str1[20] = "Happy";
  	char str2[20] = "learning";
   	char str3[20];
   	char str4[20] = "learning";
   	char str[50] = "Hello world, learning is fun.";

   	int length, cmp, cmp1;
   	int *ptr, * ptr1;

   	length = strlen(str1); // find length of a string
   	printf("length of string is : %d\n", length);

   	strcat(str1, str2); // concatenates str1 and str2
   	printf("Concatenation of str1 and str2: %s\n", str1);
   	strcpy(str3, str1); // to copy a string into another
   	printf("string copy of str1 to str3 : %s\n", str3);
   	cmp = strcmp(str2,str4); // to compare two strings
   	printf("string compare result : %d\n", cmp);
   	cmp1 = strcmp(str1,str4); // to compare two strings
   	printf("string compare result : %d\n", cmp1);

   	ptr = strchr(str1, 'p'); // usage of strchr
   	printf("pointer to the first occurrence of p in string Happy : %p\n", (void*)ptr);

   	ptr1 = strstr(str, str2); // usage of strstr
   	printf("pointer to the first occurrence of str2 in str : %p\n", (void*)ptr1);

	return 0;
}
```

## Buffer Overflow

- String operations in C can lead to buffer overflows if not handled carefully.
- Here are common risks and safer alternatives:

### Unsafe vs Safe String Operations

```c
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int main() {
    char buffer[10];
    char large_input[50] = "This string is too long for the buffer";

    // UNSAFE: strcpy doesn't check buffer size
    // strcpy(buffer, large_input);  // This would cause buffer overflow!

    // SAFE: Use strncpy with size limit
    strncpy(buffer, large_input, sizeof(buffer) - 1);
    buffer[sizeof(buffer) - 1] = '\0';  // Ensure null termination
    printf("Safe copy: %s\n", buffer);

    // UNSAFE: strcat doesn't check buffer size
    char dest[20] = "Hello ";
    char src[] = "World, this is a long string";
    // strcat(dest, src);  // This could cause buffer overflow!

    // SAFE: Use strncat with size limit
    strncat(dest, src, sizeof(dest) - strlen(dest) - 1);
    printf("Safe concatenation: %s\n", dest);

    return 0;
}
```

## Safe String Handling

### 1. Always Check Buffer Bounds

```c
#include <stdio.h>
#include <string.h>

// Safe string copy function
void safe_strcpy(char *dest, const char *src, size_t dest_size) {
    if (dest_size > 0) {
        strncpy(dest, src, dest_size - 1);
        dest[dest_size - 1] = '\0';
    }
}

// Safe string concatenation function
void safe_strcat(char *dest, const char *src, size_t dest_size) {
    size_t dest_len = strlen(dest);
    if (dest_len < dest_size - 1) {
        strncat(dest, src, dest_size - dest_len - 1);
    }
}

int main() {
    char buffer[20];

    safe_strcpy(buffer, "Hello", sizeof(buffer));
    printf("After safe copy: %s\n", buffer);

    safe_strcat(buffer, " World!", sizeof(buffer));
    printf("After safe concatenation: %s\n", buffer);

    return 0;
}
```

### 2. Input Validation and Length Checking

```c
#include <stdio.h>
#include <string.h>

int main() {
    char input[50];

    printf("Enter a string (max 49 characters): ");

    // SAFER: Use fgets instead of scanf for string input
    if (fgets(input, sizeof(input), stdin) != NULL) {
        // Remove newline character if present
        size_t len = strlen(input);
        if (len > 0 && input[len - 1] == '\n') {
            input[len - 1] = '\0';
        }

        printf("You entered: %s\n", input);
        printf("Length: %zu characters\n", strlen(input));
    } else {
        printf("Input error\n");
    }

    return 0;
}
```

### 3. Dynamic Memory Allocation for Strings

```c
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* safe_string_duplicate(const char* source) {
    if (source == NULL) return NULL;

    size_t len = strlen(source);
    char* copy = malloc(len \+ 1);

    if (copy != NULL) {
        strcpy(copy, source);
    }

    return copy;
}

int main() {
    const char* original = "Hello, World!";
    char* copy = safe_string_duplicate(original);

    if (copy != NULL) {
        printf("Original: %s\n", original);
        printf("Copy: %s\n", copy);

        // Don't forget to free allocated memory
        free(copy);
    } else {
        printf("Memory allocation failed\n");
    }

    return 0;
}
```

### 4. Modern C String Functions (C11)

If your compiler supports C11, you can use safer string functions:

```c
#include <stdio.h>
#include <string.h>

#define _STDC_LIB_EXT1_ 1

int main() {
    char dest[20];
    const char* src = "Hello, World!";

    // C11 safe string functions (if available)
    #ifdef _STDC_LIB_EXT1_
        if (strcpy_s(dest, sizeof(dest), src) == 0) {
            printf("Safe copy successful: %s\n", dest);
        } else {
            printf("Safe copy failed\n");
        }
    #else
        // Fallback to manual safe copy
        if (strlen(src) < sizeof(dest)) {
            strcpy(dest, src);
            printf("Manual safe copy: %s\n", dest);
        } else {
            printf("Source string too long\n");
        }
    #endif

    return 0;
}
```

## Best Practices

- Always specify buffer sizes when using string functions
- Use `strncpy()` instead of `strcpy()` and ensure null termination
- Use `strncat()` instead of `strcat()` and check remaining space
- Use `fgets()` instead of `scanf()` for reading strings
- Validate input lengths before processing
- Initialize buffers and always null-terminate strings
- Free dynamically allocated memory to prevent memory leaks
- Consider using safer alternatives like `snprintf()` for formatted strings

# Data Types

- As the name suggests, data-type specifies the type of the data present in the variable.
- Variables must be declared with a data-type.
- There are four different types of Data types in C.

| Types       | Data-type                        |
| :---------- | :------------------------------- |
| Basic       | int, char, float, double         |
| Derived     | array, pointer, structure, union |
| Enumeration | enum                             |
| Void        | void                             |

## 1. Basic data types

- Basic data types are generally arithmetic types which are based on integer and float data types.
- They support both signed and unsigned values.
- Below are some of the commonly used data types:

| Data type          | Description                               | Range                                                   | Memory Size  | Format specifier |
| :----------------- | :---------------------------------------- | :------------------------------------------------------ | :----------- | :--------------- |
| int                | used to store whole numbers               | -2,147,483,648 to 2,147,483,647                         | 4 bytes      | %d               |
| short int          | used to store whole numbers               | -32,768 to 32,767                                       | 2 bytes      | %hd              |
| long int           | used to store whole numbers               | -2,147,483,648 to 2,147,483,647                         | 4 bytes      | %li              |
| float              | used to store fractional numbers          | 6 to 7 decimal digits                                   | 4 bytes      | %f               |
| double             | used to store fractional numbers          | 15 decimal digits                                       | 8 bytes      | %lf              |
| char               | used to store a single character          | -128 to 127 (signed) or 0 to 255 (unsigned)             | 1 byte       | %c               |
| unsigned char      | used to store a single character          | 0 to 255                                                | 1 byte       | %c               |
| unsigned int       | used to store positive whole numbers      | 0 to 4,294,967,295                                      | 4 bytes      | %u               |
| unsigned long      | used to store positive whole numbers      | 0 to 4,294,967,295 (minimum)                            | 4 or 8 bytes | %lu              |
| long long int      | used to store very large whole numbers    | -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807 | 8 bytes      | %lld             |
| unsigned long long | used to store very large positive numbers | 0 to 18,446,744,073,709,551,615                         | 8 bytes      | %llu             |
| _Bool or bool      | used to store boolean values              | 0 or 1                                                  | 1 byte       | %d               |

### Additional Data Types: `size_t` and `ptrdiff_t`

- `size_t`: An unsigned integer type used to represent the size of objects in bytes and is guaranteed to be able to store the maximum size of any object.
  - Format specifier: `%zu`
- `ptrdiff_t`: A signed integer type used to represent the difference between two pointers.
  - Format specifier: `%td`

### Fixed-width Integer Types (from `stdint.h`)

C99 introduced fixed-width integer types that guarantee exact sizes across different platforms:

| Data type | Description             | Size    | Format specifier                |
| :-------- | :---------------------- | :------ | :------------------------------ |
| int8_t    | Signed 8-bit integer    | 1 byte  | %d (after casting) or use PRId8 |
| uint8_t   | Unsigned 8-bit integer  | 1 byte  | %u (after casting) or use PRIu8 |
| int16_t   | Signed 16-bit integer   | 2 bytes | %d or use PRId16                |
| uint16_t  | Unsigned 16-bit integer | 2 bytes | %u or use PRIu16                |
| int32_t   | Signed 32-bit integer   | 4 bytes | %d or use PRId32                |
| uint32_t  | Unsigned 32-bit integer | 4 bytes | %u or use PRIu32                |
| int64_t   | Signed 64-bit integer   | 8 bytes | %lld or use PRId64              |
| uint64_t  | Unsigned 64-bit integer | 8 bytes | %llu or use PRIu64              |

### Examples

```c
#include <stdio.h>
#include <float.h>
#include <stdbool.h>
#include <stdint.h>
#include <inttypes.h>

int main() {
	// Basic types with proper sizeof usage (note: sizeof returns size_t)
	int x = 90;
	printf("size of int: %zu bytes\n",sizeof(int));
	printf("value of x: %d\n", x);

	// Unsigned types
	unsigned int ui = 4294967295U;
	printf("size of unsigned int: %zu bytes\n",sizeof(unsigned int));
	printf("max unsigned int: %u\n", ui);

	// Long long
	long long ll = 9223372036854775807LL;
	printf("size of long long: %zu bytes\n",sizeof(longlong));
	printf("max long long: %lld\n", ll);

	// Float and double
	float f = 3.14f;
	printf("size of float: %zu bytes\n",sizeof(float));

	double d = 2.25507e-308;
	printf("size of double: %zu bytes\n",sizeof(double));

	// Character types
	char c = 'a';
	unsigned char uc = 255;
	printf("size of char: %zu byte\n",sizeof(char));
	printf("char value: %c, unsigned char value: %u\n", c, uc);

	// Boolean type
	bool flag = true;
	printf("size of bool: %zu byte\n",sizeof(bool));
	printf("bool value: %d\n", flag);

	// Fixed-width types
	int32_t fixed32 = 2147483647;
	uint64_t fixed64u = 18446744073709551615ULL;
	printf("int32_t value: %" PRId32 "\n", fixed32);
	printf("uint64_t value: %" PRIu64 "\n", fixed64u);

	// size_t and ptrdiff_t
	size_t size =sizeof(int);
	printf("size_t example: %zu\n", size);

	return 0;
}
```

## 2. Derived Data types

- Derived Data types are the ones which are derived from fundamental data types.
- Arrays, Pointers, Structures, etc. are examples of derived data types.
- Let's learn more about them in the next chapters.

## 3. Enumeration Data types

- Enumeration Data type is a user-defined data type in C.
- `enum` keyword is used to declare a new enumeration type in C.

### Syntax:

```c
enum name { constant1, constant2, constantN };
```

### Example

```c
#include<stdio.h>

enum month { Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec };

int main() {
	enum month name;
	name = June;

	printf("%d",name);
	return 0;
}
```

## 4. Void Data types

Void specifies that there is no return value. Generally `void` is used in the below situations:

- If the function has a return type mentioned as Void, then it specifies that the function returns no value.
- A function without any parameters can accept `void`. For example, `char greetings(void)`
- A pointer with type specified as `void` represents the address of an object but not its type.

# Pointers

A pointer is a variable which holds the memory information(address) of another variable of the same data type.

- Pointers help in dynamic memory management.
- Improves execution time.
- More efficient while handling arrays and structures.
- You can pass a function as an argument to another function only with the help of pointers.

### Syntax

The pointer data type should match with the data type of the variable which is getting pointed. `data_type *pointer_name;`

### Example

```c
#include <stdio.h>

int main() {
	int num = 10;
	int *ptr;// pointer variable
	ptr = &num;
	printf("Value of the variable: %d\n", *ptr);
	printf("Address stored in pointer: %p\n", (void*)ptr);
	return 0;
}
```

### Example:

```c
#include <stdio.h>

int main() {
	int x = 10, *ptr;

	// *ptr = x; // Error because ptr is adress and x is value
	// *ptr = &x;  // Error because x is adress and ptr is value

	ptr = &x; // valid because &x and ptr are addresses
	*ptr = x; // valid because both x and *ptr values

	printf("Value of *ptr: %d\n", *ptr);
	printf("Address of x: %p\n", (void*)&x);
	printf("Address stored in ptr: %p\n", (void*)ptr);
	printf("Value of x: %d\n", x);
}
```

## Null Pointer Checking

Always check if a pointer is `NULL` before dereferencing it to avoid segmentation faults:

```c
#include <stdio.h>
#include <stdlib.h>

int main() {
	int *ptr = NULL; // Initialize to NULL

	// Check before dereferencing
	if (ptr != NULL) {
		printf("Value: %d\n", *ptr);
	} else {
		printf("Pointer is NULL, cannot dereference\n");
	}

	// Allocate memory
	ptr = (int*) malloc(sizeof(int));

	if (ptr == NULL) {
		printf("Memory allocation failed\n");
		return 1;
	}

	*ptr = 42;
	printf("Value: %d\n", *ptr);

	free(ptr);
	ptr = NULL;

	return 0;
}
```

## Pointer Arithmetic

Pointers can be incremented, decremented, and used in arithmetic operations:

```c
#include <stdio.h>

int main() {
	int arr[5] = {10, 20, 30, 40, 50};
	int *ptr = arr; // Points to first element

	printf("Array elements using pointer arithmetic:\n");

	for (int i = 0; i < 5; i++) {
		printf("arr[%d] = %d, address: %p\n", i, *(ptr \+ i), (void*) (ptr \+ i));
	}

	// Pointer increment
	ptr++; // Now points to second element

	printf("\nAfter ptr++: value = %d, address: %p\n", *ptr, (void*) ptr);

	// Pointer difference
	int *ptr2 = &arr[4];

	printf("Difference between ptr2 and ptr: %ld elements\n", ptr2 - ptr);

	return 0;
}
```

## Void Pointers

Void pointers can point to any data type but must be cast before dereferencing:

```c
#include <stdio.h>

int main() {
	int num = 10;
	float f = 3.14f;
	char c = 'A';
	void *void_ptr;

	// Void pointer can point to any type
	void_ptr = &num;
	printf("Integer value: %d\n", *(int*) void_ptr);

	void_ptr = &f;
	printf("Float value: %.2f\n", *(float*) void_ptr);

	void_ptr = &c;
	printf("Character value: %c\n", *(char*) void_ptr);

	return 0;
}
```

## Function Pointers

Function pointers allow you to store and call functions dynamically:

```c
#include <stdio.h>

// Function prototypes
int add(int a, int b);
int multiply(int a, int b);
void processArray(int arr[], int size, int (*operation) (int, int));

// Function implementation
int add(int a, int b) {
	return a \+ b;
}

int multiply(int a, int b) {
	return a * b;
}

void processArray(int arr[], int size, int (*operation)(int, int)) {
	printf("Processing array with function pointer:\n");

	for (int i = 0; i < size - 1; i++) {
		int result = operation(arr[i], arr[i \+ 1]);
		printf("%d op %d = %d\n", arr[i], arr[i \+ 1], result);
	}
}

int main() {
	// Declare function pointer
	int (*func_ptr) (int, int);

	// Assign function to pointer
	func_ptr = add;
	printf("Using function pointer for addition: %d\n", func_ptr(5, 3));

	// Change function
	func_ptr = multiply;
	printf("Using function pointer for multiplication: %d\n", func_ptr(5, 3));

	// Array of function pointers
	int (*operations[])(int, int) = {add, multiply};
	printf("Add: %d, Multiply: %d\n", operations[0](4, 2), operations[1](4, 2));

	// Pass function pointer to another function
	int arr[] = {1, 2, 3, 4, 5};
	processArray(arr, 5, add);

	return 0;
}
```

# Files IO

Why are files required?

- To store or retrieve large volumes of data as limited data can be displayed on console.
- Usually data gets lost when a program is terminated. You can access the data present in a file even when the program is terminated.
- Handling and transferring data from one system to another is quite easier using files

## File handling in C

- File operations like create, update, read, and deleting files which are stored on the local file system can be performed in C.

## Create or Update

First, you need to open a file in order to create or update.

#### Open

```c
FILE *fptr = fopen("filename","mode");
```

Modes of opening files

| Mode | Description                                          |
| :--- | :--------------------------------------------------- |
| r    | Open for reading.                                    |
| rb   | Opens for reading in binary mode.                    |
| r+   | Opens for both reading and writing.                  |
| w    | Open for writing.                                    |
| wb   | Opens for writing in binary mode.                    |
| a    | Opens for append.                                    |
| ab   | Opens for append in binary mode.                     |
| w+   | Opens for both reading and writing.                  |
| wb+  | Opens for both reading and writing in binary mode.   |
| rb+  | Opens for both reading and writing in binary mode.   |
| a+   | Opens for both reading and appending.                |
| ab+  | Opens for both reading and appending in binary mode. |

#### Example:

```c
FILE *fptr = fopen("/Users/name/sample.txt", "w");
```

Consider `sample.txt` is not present in the above path then it creates a file named `sample.txt` and opens it for writing.

## Read and Write

`fprintf()` and `fscanf()` are used to read and write to a file. They are similar to `printf()` and `scanf()` but they are file versions and expect a pointer to the structure file.

### Read

```c
FILE *fptr = fopen("fileName.txt", "r");
fscanf(fptr, "format specifier", data);
```

### Write

```c
FILE *fptr = fopen("fileName.txt", "w");
fprintf(fptr, "format specifier", data);
```

### Close

```c
fclose(fptr);
```

# Error Handling

- C doesn't support error or exception handling directly but there are some ways to implement error handling in C.
- A developer is expected to prevent the errors from occurring by checking if the program works fine for all possible scenarios and doesn't end in infinite loops.
- You can handle errors based on return values of the function.
- In most of the cases functions return `-1` or `NULL` in case of any errors.

## 1. By using `errno`

- `errno` is set by system calls and some library functions in the event of an error to tell if something goes wrong.
- You need to include `<errno.h>` header to use the external variable `errno`.
- Below are the different return codes of errno for different types of errors.

| errno code | Error Description         |
| :--------- | :------------------------ |
| 1          | Operation not permitted   |
| 2          | No such file or directory |
| 3          | No such process           |
| 4          | Interrupted system call   |
| 5          | I/O error                 |
| 6          | No such device or address |
| 7          | Argument list too long    |
| 8          | Exec format error         |
| 9          | Bad file number           |
| 10         | No child processes        |
| 11         | Try again                 |
| 12         | Out of memory             |
| 13         | Permission denied         |

### Example

```c
#include <stdio.h>
#include <errno.h>
#include <string.h>

extern int errno;

int main () {
	FILE *f = fopen("example.txt", "r");

	if( f == NULL) {
		fprintf(stderr, "errno value: %d\n", errno);
	fprintf(stderr, "Error info: %s\n", strerror(errno));
		perror("perror info: ");
	} else {
		// code goes here…
	}

	return(0);
}
```

**Note**: You can either use `strerror` or `perror` to display the error information.

## 2. By using EXIT CONSTANTS

- `EXIT_SUCCESS` and `EXIT_FAILURE` are two macros defined in `<stdlib.h>` which can be passed to `exit()` function to indicate successful or unsuccessful termination.
- If you write anything after the `exit()` function, it will not get executed.

```c
#include <stdio.h>	// to use fprintf and stderr
#include <errno.h>	// to use errno
#include <string.h>	// to use perror and strerror
#include <stdlib.h>	// to use EXIT_SUCCESS and EXIT_FAILURE

extern int errno;

int main () {
	FILE *f = fopen("example.txt", "r"); // consider this file doesn't exist.

	if(f == NULL) {
		fprintf(stderr, "errno value: %d\n", errno);
		fprintf(stderr, "Error info: %s\n", strerror(errno));
		perror("perror info: ");
		exit(EXIT_FAILURE);
	} else {
		// Code goes here...
		exit(EXIT_SUCCESS);
	}

	return(0);
}
```

## 3. Division by zero

- There might be certain situations where a divisor can become zero which will produce runtime error.
- It is always advisable to check if the divisor is zero in your program.

```c
#include <stdio.h>
#include <stdlib.h>

int main() {
	int dividend = 100;
	int divisor = 0;
	int result;

	if (divisor == 0) {
		fprintf(stderr, "Abort!! Division by zero\n");
		exit(EXIT_FAILURE);
	} else {
		result = dividend / divisor;
		exit(EXIT_SUCCESS);
	}
}
```
