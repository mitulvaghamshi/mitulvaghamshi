# Rust

![][image1]

## Introduction

- With the Rust programming language, you can build reliable and efficient systems software. Developers use Rust for networking software like web servers, mail servers, and web browsers. Rust is also present in compilers and interpreters, virtualization and software containers, databases, operating systems, and cryptography. You can use Rust to build games, command-line programs, web-assembly programs, and applications for embedded devices.
- Rust is a safe alternative to existing systems software languages like C and C++. Like C and C++, Rust doesn't have a large runtime or garbage collector, which contrasts it with almost all other modern languages. However, unlike C and C++, Rust guarantees memory safety. Rust prevents many of the bugs related to incorrect use of memory you might see in C and C++.
- Rust strikes a unique balance among performance, safety, and implementation expressions. No matter what your programming background, you'll likely find Rust has something to offer!
- Rust allows for control over the performance and resource consumption of programs and libraries written in the language on par with C and C++, while still being memory safe by default. This level of control eliminates entire classes of common bugs.
- Rust has rich abstraction features that allow developers to encode many of the invariants of their program into code. The code is then checked by the compiler instead of relying on convention or documentation. This feature can often lead to the feeling of "if it compiles, it works."

## What is Rust?

- Rust is an open-source, systems programming language that you can use to develop efficient, safe software. With Rust, you can manage memory and control other low-level details. But you can also take advantage of high-level concepts like iteration and interfaces. These features set Rust apart from low-level languages like C and C++.
- Rust also offers the following advantages that make it a great fit for a wide range of applications:
  - Type safe: The compiler assures that no operation will be applied to a variable of a wrong type.
  - Memory safe: Rust pointers (known as references) always refer to valid memory.
  - Data race free: Rust's borrow checker guarantees thread-safety by ensuring that multiple parts of a program can't mutate the same value at the same time.
  - Zero-cost abstractions: Rust allows the use of high-level concepts, like iteration, interfaces, and functional programming, with minimal to no performance costs. The abstractions perform as well, as if you wrote the underlying code by hand.
  - Minimal runtime: Rust has a minimal and optional runtime. The language also has no garbage collector to manage memory efficiently. In this way, Rust is most similar to languages like C and C++.
  - Targets bare metal: Rust can target embedded and "bare metal" programming, making it suitable to write an operating system kernel or device drivers.

## Rust module system

- Crates: A Rust crate is a compilation unit. It's the smallest piece of code the
- Rust compiler can run. The code in a crate is compiled together to create a binary executable or a library. In Rust, only crates are compiled as reusable units. A crate contains a hierarchy of Rust modules with an implicit, unnamed top-level module.
- Modules: Rust modules help you organize your program by letting you manage the scope of the individual code items inside a crate. Related code items or items that are used together can be grouped into the same module. Recursive code definitions can span other modules.
- Paths: In Rust, you can use paths to name items in your code. For example, a path can be a data definition like a vector, a code function, or even a module.
- The module feature also helps you control the privacy of your paths. You can specify the parts of your code that are accessible publicly versus parts that are private. This feature lets you hide the implementation details.

## What is ownership?

- Rust includes an ownership system to manage memory. At compile time, the ownership system checks a set of rules to ensure that the ownership features allow your program to run without slowing down.
- In Rust, "variables" are often called "bindings". This is because "variables" in
- Rust aren't very variable - they don't change that often since they're unchangeable by default. Instead, we often think about names being "bound" to data, hence the name "binding".

## Tests

- The cfg attribute controls conditional compilation and will only compile the thing it's attached to if the predicate is true. The test compilation flag is issued automatically by Cargo whenever we execute the command $ cargo test, so it will always be true when we run our tests.
- The should_panic attribute makes it possible to check for a panic!. If we add this attribute to our test function, the test passes when the code in the function panics. The test fails when the code doesn't panic.
- A function annotated with the [test] attribute can also be annotated with the [ignore] attribute. This attribute causes that test function to be skipped during tests. The [ignore] attribute may optionally be written with a reason why the test is ignored.

## References

The difference between `let mut ref_x: &i32` and `let ref_x: &mut i32`. The first one represents a **mutable reference** which can be bound to different values, while the second represents a reference to a **mutable value**.

## Copying and Cloning

Copying and cloning are not the same thing:
- Copying refers to bitwise copies of memory regions and does not work on arbitrary objects.
- Copying does not allow for custom logic (unlike copy constructors in C++).
- Cloning is a more general operation and also allows for custom behavior by implementing the Clone trait.
- Copying does not work on types that implement the Drop trait.

## Lifetime

Read &'a Point as “a borrowed Point which is valid for at least the lifetime a”.

## Box

- Box is an owned pointer to data on the heap Box implements `Deref<Target = T>`, which means that you can call methods from T directly on a Box. Box is like std::unique_ptr in C++, except that it’s guaranteed to be not null. In the above example, you can even leave out the * in the println! statement thanks to Deref.
- A Box can be useful when you: have a type whose size can't be known at compile time, but the Rust compiler wants to know an exact size. want to transfer ownership of a large amount of data. To avoid copying large amounts of data on the stack, instead store the data on the heap in a Box so only the pointer is moved. Recursive data types or data types with dynamic sizes need to use a Box
- If Box was not used and we attempted to embed a List directly into the List, the compiler would not compute a fixed size of the struct in memory (List would be of infinite size). Box solves this problem as it has the same size as a regular pointer and just points at the next element of the List in the heap. Remove the
- Box in the List definition and show the compiler error. “Recursive with indirection” is a hint you might want to use a Box or reference of some kind, instead of storing a value directly. A Box cannot be empty, so the pointer is always valid and non-null. This allows the compiler to optimize the memory layout

## Rc

- Rc is a reference-counted shared pointer. Use this when you need to refer to the same data from multiple places See Arc and Mutex if you are in a multi-threaded context. You can downgrade a shared pointer into a Weak pointer to create cycles that will get dropped. Rc’s count ensures that its contained value is valid for as long as there are references. Rc in Rust is like std::shared_ptr in C++.
- Rc::clone is cheap: it creates a pointer to the same allocation and increases the reference count. Does not make a deep clone and can generally be ignored when looking for performance issues in code. make_mut actually clones the inner value if necessary (“clone-on-write”) and returns a mutable reference. Use
- Rc::strong_count to check the reference count. Rc::downgrade gives you a weakly reference-counted object to create cycles that will be dropped properly (likely in combination with RefCell, on the next slide).

## Arc

- Arc allows shared read-only access via Arc::clone Arc stands for “Atomic Reference Counted”, a thread safe version of Rc that uses atomic operations. Arc implements Clone whether or not T does. It implements Send and Sync if and only if T implements them both. Arc::clone() has the cost of atomic operations that get executed, but after that the use of the T is free. Beware of reference cycles, Arc does not use a garbage collector to detect them. std::sync::Weak can help.

## Mutex

Mutex ensures mutual exclusion and allows mutable access to T behind a read-only interface Mutex in Rust looks like a collection with just one element - the protected data. It is not possible to forget to acquire the mutex before accessing the protected data. You can get an &mut T from an &Mutex by taking the lock. The MutexGuard ensures that the &mut T doesn’t outlive the lock being held. Mutex implements both Send and Sync iff (if and only if) T implements Send. A read-write lock counterpart - RwLock. Why does lock() return a Result? If the thread that held the Mutex panicked, the Mutex becomes “poisoned” to signal that the data it protected might be in an inconsistent state. Calling lock() on a poisoned mutex fails with a PoisonError. You can call into_inner() on the error to recover the data regardless.

## Cell and RefCell

Cell and RefCell implement what Rust calls interior mutability: mutation of values in an immutable context. Cell is typically used for simple types, as it requires copying or moving values. More complex interior types typically use RefCell, which tracks shared and exclusive references at runtime and panics if they are misused. If we were using Cell instead of RefCell in this example, we would have to move the Node out of the Rc to push children, then move it back in. This is safe because there’s always one, un-referenced value in the cell, but it’s not ergonomic. To do anything with a Node, you must call a RefCell method, usually borrow or borrow_mut. Demonstrate that reference loops can be created by adding root to subtree.children (don’t try to print it!). To demonstrate a runtime panic, add a fn inc(&mut self) that increments self.value and calls the same method on its children. This will panic in the presence of the reference loop, with thread 'main' panicked at 'already borrowed: BorrowMutError'.

## Send and Sync

- Send: a type T is Send if it is safe to move a T across a thread boundary. The effect of moving ownership to another thread is that destructors will run in that thread. So the question is when you can allocate a value in one thread and deallocate it in another. As an example, a connection to the SQLite library must only be accessed from a single thread.
- Sync: a type T is Sync if it is safe to move a &T across a thread boundary. T is Sync if and only if &T is Send This statement is essentially a shorthand way of saying that if a type is thread-safe for shared use, it is also thread-safe to pass references of it across threads. This is because if a type is Sync it means that it can be shared across multiple threads without the risk of data races or other synchronization issues, so it is safe to move it to another thread. A reference to the type is also safe to move to another thread, because the data it references can be accessed from any thread safely.
- Send and Sync are unsafe traits. The compiler will automatically derive them for your types as long as they only contain Send and Sync types. You can also implement them manually when you know it is valid. One can think of these traits as markers that the type has certain thread-safety properties. They can be used in the generic constraints as normal traits.

## Traits

- Rust lets you abstract over types with traits. They’re similar to interfaces
- Trait objects allow for values of different types, for instance in a collection
- Types that implement a given trait may be of different sizes. This makes it impossible to have things like Vec in the example above. dyn Pet is a way to tell the compiler about a dynamically sized type that implements Pet. In the example, pets are allocated on the stack and the vector data is on the heap. The two vector elements are fat pointers: A fat pointer is a double-width pointer.
- It has two components: a pointer to the actual object and a pointer to the virtual method table (vtable) for the Pet implementation of that particular object. The data for the Dog named Fido is the name and age fields. The Cat has a lives field.

## Drop

Note that std::mem::drop is not the same as std::ops::Drop::drop. Values are automatically dropped when they go out of scope. When a value is dropped, if it implements std::ops::Drop then its Drop::drop implementation will be called. All its fields will then be dropped too, whether or not it implements Drop. std::mem::drop is just an empty function that takes any value. The significance is that it takes ownership of the value, so at the end of its scope it gets dropped. This makes it a convenient way to explicitly drop values earlier than they would otherwise go out of scope. This can be useful for objects that do some work on drop: releasing locks, closing files, etc. Discussion points: Why doesn’t Drop::drop take self? Short-answer: If it did, std::mem::drop would be called at the end of the block, resulting in another call to Drop::drop, and a stack overflow! Try replacing drop(a) with a.drop().

## Closures

Closures or lambda expressions have types which cannot be named. However, they implement special Fn, FnMut, and FnOnce traits An Fn (e.g. add_3) neither consumes nor mutates captured values, or perhaps captures nothing at all. It can be called multiple times concurrently. An FnMut (e.g. accumulate) might mutate captured values. You can call it multiple times, but not concurrently. If you have an FnOnce (e.g. multiply_sum), you may only call it once. It might consume captured values. FnMut is a subtype of FnOnce. Fn is a subtype of FnMut and FnOnce. I.e. you can use an FnMut wherever an FnOnce is called for, and you can use an Fn wherever an FnMut or FnOnce is called for. The compiler also infers Copy (e.g. for add_3) and Clone (e.g. multiply_sum), depending on what the closure captures. By default, closures will capture by reference if they can. The move keyword makes them capture by value.

## Unsafe Rust

The Rust language has two parts:
- Safe Rust: memory safe, no undefined behavior possible. Unsafe Rust: can trigger undefined behavior if preconditions are violated. We will be seeing mostly safe
- Rust in this course, but it’s important to know what Unsafe Rust is.
- Unsafe code is usually small and isolated, and its correctness should be carefully documented. It is usually wrapped in a safe abstraction layer.
- Unsafe Rust gives you access to five new capabilities:
- Dereference raw pointers. Access or modify mutable static variables. Access union fields. Call unsafe functions, including extern functions. Implement unsafe traits.
- Unsafe Rust does not mean the code is incorrect. It means that developers have turned off the compiler safety features and have to write correct code by themselves. It means the compiler no longer enforced Rust’s memory-safety rules.

## Dereferencing Raw Pointers

Creating pointers is safe, but dereferencing them requires unsafe

```rust
let mut num = 5;

let r1 = &mut num as *mut i32;
let r2 = r1 as *const i32;

// Safe because r1 and r2 were obtained from references and so are
// guaranteed to be non-null and properly aligned, the objects underlying
// the references from which they were obtained are live throughout the
// whole unsafe block, and they are not accessed either through the
// references or concurrently through any other pointers.
unsafe {
    println!("r1 is: {}", *r1);
    *r1 = 10;
    println!("r2 is: {}", *r2);
}
```

In the case of pointer dereferences, this means that the pointers must be valid, i.e.:
- The pointer must be non-null. The pointer must be dereferenceable (within the bounds of a single allocated object). The object must not have been deallocated.
- There must not be concurrent accesses to the same location. If the pointer was obtained by casting a reference, the underlying object must be alive and no reference may be used to access the memory. In most cases the pointer must also be properly aligned.

## C Interop

```rust
extern "C" {
    fn abs(input: i32) -> i32;
}

fn main() {
    unsafe {
        // Undefined behavior if abs misbehaves.
        println!("Absolute value of -3 according to C: {}", abs(-3));
    }
}
```

## Safe FFI Wrapper

Rust has great support for calling functions through a foreign function interface (FFI). We will use this to build a safe wrapper for the libc functions you would use from C to read the names of files in a directory.

You will want to consult the manual pages:
- [opendir(3)](https://man7.org/linux/man-pages/man3/opendir.3.html)
- [readdir(3)](https://man7.org/linux/man-pages/man3/readdir.3.html)
- [closedir(3)](https://man7.org/linux/man-pages/man3/closedir.3.html)

You will also want to browse the [std::ffi](https://doc.rust-lang.org/std/ffi/) module. There you find a number of string types which you need for the exercise:

| Types              | Encoding        | Use                            |
| :----------------- | :-------------- | :----------------------------- |
| str and String     | UTF-8           | Text processing in Rust        |
| CStr and CString   | NULL-terminated | Communicating with C functions |
| OsStr and OsString | OS-specific     | Communicating with the OS      |

You will convert between all these types:

- &str to CString: you need to allocate space for a trailing \0 character,
- CString to *const i8: you need a pointer to call C functions,
- *const i8 to &CStr: you need something which can find the trailing \0 character,
- &CStr to &[u8]: a slice of bytes is the universal interface for “some unknown data”,
- &[u8] to &OsStr: &OsStr is a step towards OsString, use OsStrExt to create it,
- &OsStr to OsString: you need to clone the data in &OsStr to be able to return it and call readdir again.

## String types

- OsStr and OsString may show up when working with file systems or system calls.
- CStr and CString may show up when working with FFI.
- The differences between [Os|C]Str and [Os|C]String are generally the same as the normal types.

## OsString & OsStr

- These types represent platform native strings.
- This is necessary because Unix and Windows strings have different characteristics.
- Behind the OsString Scenes Unix strings are often arbitrary non-zero sequences, usually interpreted as UTF-8.
- Windows strings are often arbitrary non-zero sequences, usually interpreted as UTF-16.
- Rust strings are always valid UTF-8, and may contain zeros.
- OsString and OsStr bridge this gap and allow for cheap conversion to and from String and str.

## CString & CStr

- These types represent valid C compatible strings.
- They are predominantly used when doing FFI with external code.
- It is strongly recommended you read all of the documentation on these types before using them.
- Behind the OsString Scenes Unix strings are often arbitrary non-zero sequences, usually interpreted as UTF-8.
- Windows strings are often arbitrary non-zero sequences, usually interpreted as UTF-16.
- Rust strings are always valid UTF-8, and may contain zeros.
- OsString and OsStr bridge this gap and allow for cheap conversion to and from String and str.

Common String Tasks Splitting:

```rust
fn main() {
    let words = "Cow says moo";
    let each: Vec<_> = words.split(" ").collect();
    println!("{:?}", each);
}
```

Useful when using C naming convention in rust:

```rust
#![allow(non_camel_case_types, non_upper_case_globals, non_snake_case)]
```

## Macros

The `($value:expr)` part says that:
- The macro accepts one parameter which is an expression.
- Parameter types can be restricted.
- For example, `$foo:ty` only accepts a type.
- The parameters are prepended with a $ to distinguish them.
- Both in the input and output.

```rust
macro_rules! double {
  // Input params => Output*
  ($value:expr) => ($value * 2);
}

fn main() {
    let doubled = double!(5);
    println!("{}", doubled);
    // Alternatives:*
    double!{5};
    double![5];
}
```

When we see `$(...)*` This is signaling a repetition. It communicates:
- This portion of the macro takes a variable number of arguments.
- Each repetition in the input should have a matching one in the output.

```rust
macro_rules! implement_foo_for {
    [
        // This is a repetition!*
        $($implement_for:ty,)*
    ] => {
        // This iterates over the repetition!*
        $(impl Foo for $implement_for {})*
    }
}

implement_foo_for![u8, u16, u32, u64, usize,];
implement_foo_for! { i8, i16, i32, i64, isize, }
implement_foo_for!(f32, f64,);

trait Foo {
    fn foo(&self) {
        println!("Foo!");
    }
}

fn main() {
    1_u8.foo();
    1_u16.foo();
}
```

## Macro custom syntax

```rust
macro_rules! email {
    ($user:expr => $domain:expr) => {
        format!("{}@{}", $user, $domain);
    }
}

fn main() {
    let address = email!("me" => "example.org");
    println!("{}", address);
}

fn main() {
    let post = Post {
        content: String::from("Blah"),
        ..Post::default()
    };
    (0..5).for_each(|_| post.view());
    println!("{:?}", post);
}
```

## Cell

```rust
use std::cell::Cell;

#[derive(Debug, Default)]
struct Post {
    content: String,
    viewed_times: Cell<usize>,
}

impl Post {
    fn view(&self) {
        // Note how we are making a copy, then replacing the original.*
        let current_views = self.viewed_times.get();
        self.viewed_times.set(current_views \+ 1);
    }
}

fn main() {
    let post = Post {
        content: String::from("Blah"),
        ..Post::default()
    };
    (0..5).for_each(|_| post.view());
    println!("{:?}", post);
}
```

## RefCell

```rust
use std::cell::RefCell;

#[derive(Debug, Default)]
struct Post {
    content: String,
    viewed_times: RefCell<usize>,
}

impl Post {
    fn view(&self) {
        // Note how we're mutating a value.*
        // Interior mutability is something of a last resort.*
        *self.viewed_times.borrow_mut() \+= 1;
    }
}
```

## WASM

- High performance: WASM is built with speed in mind and executes almost as fast as native code.
- The WASM sandbox: In its initial state, WASM does only provide memory and execution, no functionality.
- This can be added through the host system in various ways.

### Hello World:

![][image2]

### Rust ships 3 Wasm targets:

- wasm32-unknown-emscripten (legacy) ships with implementations of libc for WASM.
- wasm32-unknown-unknown (stable) direct compilation to WASM, with no additional tooling.
- wasm32-wasi (in development) WASM with support for interface types, a structured way of adding capabilities.

### Installation

- rustup allows installing multiple compilation targets:

```sh
$ rustup target install wasm32-unknown-unknown
$ rustup target install wasm32-wasi
```

- [https://ferrous-systems.github.io/teaching-material/dynamic-and-static-libs.html](https://ferrous-systems.github.io/teaching-material/dynamic-and-static-libs.html)
- [https://ferrous-systems.github.io/teaching-material/ffi.html](https://ferrous-systems.github.io/teaching-material/ffi.html)

[image1]: rust-fib.webp
[image2]: rust-wasm.webp
