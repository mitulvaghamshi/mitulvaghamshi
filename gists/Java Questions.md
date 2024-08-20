# Java Questions

| No | Topic                                                           |
| -- | --------------------------------------------------------------- |
| 1  | [Core Java concepts](#core-java-concepts)                       |
| 2  | [Object-Oriented programming](#object-oriented-programming)     |
| 3  | [Data Structure and Algorithms](#data-structure-and-algorithms) |
| 4  | [Exception handling](#exception-handling)                       |
| 5  | [Multithreading](#multithreading)                               |

## Core Java concepts

### Index

| No | Question                                                                    |
| -- | --------------------------------------------------------------------------- |
| 1  | What is the difference between JDK and JRE?                                 |
| 2  | Why is the Java platform an independent language?                           |
| 3  | What is the difference between abstract class and an interface?             |
| 4  | What is the difference between final, finally, and finalize?                |
| 5  | What is the difference between Heap memory?                                 |
| 6  | What is the difference between method overloading and method overriding?    |
| 7  | What is the difference between private and protected modifier?              |
| 8  | What is the constructor overloading in Java?                                |
| 9  | What is the use of super keywords?                                          |
| 10 | What is the difference between static method, variable, and class in Java?  |
| 11 | What exactly is System.out.println() in Java?                               |
| 12 | What part of memory - Stack or Heap - is cleaned in the garbage collection? |

What is the difference between JDK and JRE?

- JDK stands for Java Development Kit, which is a software development environment for building Java applications.
- JRE stands for Java Runtime Environment, which is required to run the Java application.

Why is the Java platform an independent language?

- By relying on a Virtual Machine, Java achieves platform independence.
- In practice, this means that both the Java programming language and its associated APIs are first compiled into the bytecode that can run on multiple platforms.
- Then, the Virtual Machine handles any variations in how these bytecodes are executed across different platforms.

What is the difference between abstract class and an interface?

- An abstract class is a class that cannot be initialized and can only be inherited.
- An interface is a blueprint of a class that contains only abstract methods and constants.
- An abstract class can have both abstract and concrete methods, while an interface can only have abstract methods.
- A class can extend only one abstract class, but it can implement multiple interfaces.

What is the difference between final, finally, and finalize?

- The final keyword is used to make a variable or a method constant and cannot be changed later.
- The finally keyword is used in try-catch block to execute a block of code regardless of whether an exception is thrown or not.
- The finalize is a method that is called by the garbage collector when an object is no longer in use.

What is the difference between Heap memory?

- Stack is used for storing local variables and function calls, while Heap is used for storing objects and their instance variables.

What is the difference between method overloading and method overriding?

- Method overloading is the process of creating multiple methods in a class with the same names, but different number and type parameters.
- Method overriding involves creating a method in a subclass with the same name and parameters as a method in its superclass.

What is the difference between private and protected modifier?

- A private modifier makes a member accessible only within the same class, while a protected modifier makes a member accessible within the same class and its subclasses (derived classes).

What is the constructor overloading in Java?

- Constructor overloading is a concept in object-oriented programming where a class can have multiple constructors with different sets of parameters.
- Each constructor provides a different way to initialize an object of that class.

What is the use of super keywords?

- The super keyword is used to access data member of the immediate parent class when the data member names of the parent class and its child subclass are the same, to call the default parameterized constructor of the parent class inside the child subclass and to access parent class methods when the child subclasses have overridden them.

What is the difference between static method, variable, and class in Java?

- The static methods and variables are those that belong to the class of the Java program, and not to any individual instance (object) of that class.
- The memory for static members is being initialized when the class is first loaded, and can be directly called using class name.
- A class in the Java program cannot be static except it is the inner (nested) class.
- If it is an inner static class, then it exactly works like other static members of the class.

What exactly is System.out.println() in Java?

- The System.out.println() is a method to print a message to the standard output (console).
- System - is a class present in java.lang package.
- Out - is the static variable of type PrintStream class present in the System class.
- printlh() - is the method present in the PrintStream class.

What part of memory - Stack or Heap - is cleaned in the garbage collection?

- Garbage collection is done on a Heap memory to free the resources used by the objects that do not have any reference.
- Any object created in the Heap space has global access and can be referenced from anywhere in the same application.

## Object-Oriented programming

### Index

| No | Question                                                                      |
| -- | ----------------------------------------------------------------------------- |
| 1  | What are the object oriented features supported by Java?                      |
| 2  | What are the different access specifiers used in Java?                        |
| 3  | What is the difference between composition and inheritance?                   |
| 4  | What is the purpose of an abstract class?                                     |
| 5  | What is the difference between a constructor and a method of a class in Java? |
| 6  | What is the Diamond problem in Java and how is it solved?                     |
| 7  | What is the difference between a local and an instance variable in Java?      |
| 8  | What is a Marker interface in Java?                                           |

What are the object oriented features supported by Java?

- Java is an object-oriented programming language and supports the following object-oriented features:
- Encapsulation - Java allows encapsulation, which is the practice of hiding the implementation details of an object from other objects. This is achieved through the use of access modifiers.
- Inheritance - Java supports inheritance, which allows a new class to be based on an existing class, inheriting its attributes and methods. This enables code reuse and makes it easier to create new classes that have common properties with existing classes.
- Polymorphism - Java supports polymorphism, which allows objects of different classes to be treated as if they were objects of a common superclass. This can be achieved through method overriding and method overloading.
- Abstraction - Java allows abstraction, which is the process of hiding complex implementation details and providing a simplified interface for the user. This can be achieved through abstract classes and interfaces.
- Classes and Objects - Java is a class-based language, which means that it provides constructs for defining classes and creating objects from those classes.

What are the different access specifiers used in Java?

- Java has four access specifiers as follow:
- Public - Can be accessed by any class or method.
- Protected - Can be accessed by the class of the same package, or by the subclass of this class, or within the same class.
- Default - Are accessible only within the package, is the default option for all classes, methods and variables.
- Private - Can be accessed only within the same class only.

What is the difference between composition and inheritance?

- Composition is a "has-a" relationship, where a class contains an object of another class as a member variable.
- Inheritance is an "is-a" relationship, where a subclass extends a superclass to inherit its attributes and methods.

What is the purpose of an abstract class?

- An abstract class is a class that cannot be instantiated and is used as a base class for other classes to inherit from.
- It can contain abstract methods, which are declared but not implemented in the abstract class and must be implemented in the subclasses.

What is the difference between a constructor and a method of a class in Java?

- Constructor is used for initializing the object state whereas method is used for exposing the object's behavior.
- Constructors have no return type but methods should have a return type.
- Even if it does not return anything, in that case the return type is void.
- If the constructor is not defined, then a default constructor is provided by the Java compiler.
- The constructor name should be equal to the class name.
- A constructor cannot be marked as final because whenever a class is inherited, the constructors are not inherited.
- A method can be defined as a final but it cannot be overridden in its subclasses.

What is the Diamond problem in Java and how is it solved?

- The diamond problem is an issue that can arise in programming languages that support the multiple inheritance, where a class can inherit from two or more classes that have a common ancestor.
- This can cause ambiguity in the method resolution order, leading to unpredictable behavior.
- In Java multiple inheritance is not supported directly, but it can be simulated using interfaces.
- A class can implement one or more interfaces, effectively inheriting their properties and methods.

What is the difference between a local and an instance variable in Java?

- Instance variables are accessible by all the methods in the class.
- They are declared outside the methods and inside the class.
- These variables describe the properties of an object and remain bound to it.
- Local variables are those variables that are present within a block, function, or constructor and can be accessed only inside them.
- The utilization of the variable is restricted to the block scope.

What is a Marker interface in Java?

- Marker interfaces or tagging interfaces are those which have no methods and constants defined in them.
- They help the compiler and JVM get run-time related object information.

## Data Structure and Algorithms

### Index

| No | Question                                                                    |
| -- | --------------------------------------------------------------------------- |
| 1  | Why are the Strings immutable in Java?                                      |
| 2  | What is the difference between creating a String using new() and a literal? |
| 3  | What is the Collections framework?                                          |
| 4  | What is the difference between an ArrayList and a LinkedList?               |
| 5  | What is the difference between a HashMap and a TreeMap?                     |
| 6  | What is the difference between a HashSet and a TreeSet?                     |
| 7  | What is the difference between an Iterator and a ListIterator?              |
| 8  | What is the purpose of the Comparable interface?                            |
| 9  | What is the purpose of the java.util.concurrent package?                    |

Why are the Strings immutable in Java?

- This storage area in Java is specifically used to store String literals, with the aim of reducing the creation of temporary String objects through sharing.
- For sharing to be possible, an immutable class is required.
- Also no external synchronization of threads is required if the String objects are immutable.
- In HashTable and HashMap, keys are the String objects and should thus be immutable to avoid modifications.

What is the difference between creating a String using new() and a literal?

- If you create a String using new(), then a new object is created in the Heap memory even if that value is already present in the Heap memory.
- If we create a String using String literal ("") and its value already exists in the String pool, then that String variable also points to that same value in the String pool without the creation of a new String with that value.

What is the Collections framework?

- The Collection framework is a set of classes and interfaces that provides common data structures such as List, Set, and Map.

What is the difference between an ArrayList and a LinkedList?

- An ArrayList is a dynamic array that can grow or shrink as needed, while LinkedList is a doubly linked list that allows fast insertion and deletion of elements.
- Accessing an element in a LinkedList is O(n) on average.

What is the difference between a HashMap and a TreeMap?

- HashMap is a hash table that stores key-value pairs, while TreeMap is a red-black tree that stores key-value pairs in sorted order.

What is the difference between a HashSet and a TreeSet?

- A HashSet is a set that stores unique elements in an unordered manner, while a TreeSet is a set that stores unique elements in a sorted manner.
- HashSet uses a hash table to store its elements, while TreeSet uses a balanced binary tree.

What is the difference between an Iterator and a ListIterator?

- Iterator is used to traverse a collection in a forward direction, while ListIterator is used to traverse a list in both forward and backward directions.

What is the purpose of the Comparable interface?

- The Comparable interface is used to provide a natural ordering for a class.
- It contains a single method compareTo() that compares the current object with another object of the same type and returns a negative integer, zero, or a positive integer depending on whether the current object is less than, equal to, or greater than the other object, respectively.

What is the purpose of the java.util.concurrent package?

- The java.util.concurrent package provides classes for concurrent programming, including thread pools, locks, atomic variables, and concurrent collections.
- It is designed to improve performance and scalability in multi-threaded applications.

## Exception handling

### Index

| No | Question                                                                 |
| -- | ------------------------------------------------------------------------ |
| 1  | What is an Exception?                                                    |
| 2  | How does the exception propagate throughout the Java code?               |
| 3  | What is the difference between the checked and unchecked exceptions?     |
| 4  | What is the use of try-catch block in Java?                              |
| 5  | What is the difference between throw and throws keywords in Java?        |
| 6  | What is the use of the finally block in Java?                            |
| 7  | What is the base class of all the exception classes?                     |
| 8  | What is the Java Enterprise Edition (Java EE)?                           |
| 9  | What is the difference between a Servlet and a JSP?                      |
| 10 | What is the purpose of the Java Persistence API (JPA)?                   |
| 11 | What is the difference between a stateful and a stateless session beans? |

What is an Exception?

- An Exception is an event that occurs during the execution of a program that disrupts the normal flow of instructions.

How does the Exception propagate throughout the Java code?

- When an Exception occurs, it tries to locate the matching catch block.
- If the matching catch block is located, then that block is executed.
- Otherwise, the Exception propagates through the method call stack and goes into the caller method where the process of matching the catch block is performed.
- This happens until the matching catch block is found.
- In case the match is not found, the program gets terminated in the main method.

What is the difference between the checked and unchecked exceptions?

- Checked exceptions are checked at compile-time, while unchecked exceptions are handled at runtime.

What is the use of try-catch block in Java?

- The try-catch block is used to handle exceptions in Java.

What is the difference between throw and throws keywords in Java?

- The throw is used to explicitly throw an Exception, while throws is used to annotate a method that can potentially throw an Exception.

What is the use of the finally block in Java?

- The finally block is used to execute a block of code regardless of whether an Exception is thrown or not.

What is the base class of all the Exception classes?

- In Java, java.lang.Throwable is the super class of all Exception classes and all Exception classes are derived from this base class.

What is the Java Enterprise Edition (Java EE)?

- Java Enterprise Edition (Java EE) is a set of specifications and APIs for developing enterprise applications in Java.
- It includes a range of technologies, such as Servlet, JSP, EJB, JPA, JMS, and JNDI.

What is the difference between a Servlet and a JSP?

- A Servlet is a Java class that processes HTTP requests and generates HTTP responses.
- A JSP (Java Server Pages) is a text-based document that is compiled into Servlet.
- JSP allows for a separation of presentation and business logic.

What is the purpose of the Java Persistence API (JPA)?

- The Java Persistence API (JPA) is a specification for object-relational-mapping (ORM) in Java.
- It provides a set of interfaces and annotations for mapping Java objects to relational database tables and vice-versa.

What is the difference between a stateful and a stateless session beans?

- Stateful session beans maintain a conversational state with the client, while stateless session beans do not.
- Stateful session beans are used for long-running conversations with a client, while stateless session beans are short-lived tasks.

## Multithreading

### Index

| No | Question                                                                   |
| -- | -------------------------------------------------------------------------- |
| 1  | What is a thread and what are the different life-cycle stages?             |
| 2  | What is the difference between a process and a thread?                     |
| 3  | What are the different thread priorities available in Java?                |
| 4  | What is context switching in Java?                                         |
| 5  | What is the difference between a User thread and a Daemon thread?          |
| 6  | What is a Deadlock?                                                        |
| 7  | What is synchronization in Java?                                           |
| 8  | What is the use of the wait() and notify() methods in Java?                |
| 9  | What is the difference between wait() and sleep() methods in Java?         |
| 10 | What is the difference between synchronized and volatile keywords in Java? |
| 11 | What is the purpose of the sleep() method in Java?                         |
| 12 | What is the difference between notify() and notifyAll() method in Java?    |

What is a thread and what are the different life-cycle stages?

- A thread is a lightweight process that can run concurrently with other threads in a program.
- Java thread life-cycle has 5 stages as: New, Runnable, Running, Waiting (Blocked, Non-Runnable), Terminated.

What is the difference between a process and a thread?

- A process is a program in execution, while a thread is a subset of a process.
- Threads share memory while processes do not.
- A process is an independent program that runs in its own memory space, while a thread is a subset of a process that runs concurrently with other threads in the same process.

What are the different thread priorities available in Java?

- There are total 3 different thread priorities available in Java as:
- MIN_PRIORITY: Integer value of 1.
- NORM_PRIORITY: Integer value of 5.
- MAX_PRIORITY: Integer value of 10.

What is context switching in Java?

- Context switching in Java is the process of switching from one thread to another by the operating-system (process scheduler).
- During context switching, the current thread's context (including its register values, program counter), are saved, and the next thread's context is restored.

What is the difference between a User thread and a Daemon thread?

- In Java, user threads have a specific life-cycle and its life is independent of any other thread and are used for critical tasks.
- Daemon thread is basically referred to as a service provider that provides services and support to user threads.
- JVM does not wait for daemon thread to finish its tasks before termination.
- But, wait for the user thread.

What is a Deadlock?

- A Deadlock is a situation where two or more threads are blocked waiting for each other to release the resources they need to process.

What is synchronization in Java?

- Synchronization is the mechanism that ensures that only one thread can access a shared resource at a time.

What is the use of the wait() and notify() methods in Java?

- The wait() and notify() methods are used for inter-thread communication in Java.

What is the difference between wait() and sleep() methods in Java?

- The wait() is the method from the Object class that is used to pause the execution of a thread and release the lock on an object, while sleep() is the method of the Thread class that is used to pause the execution of a thread without releasing any locks.

What is the difference between synchronized and volatile keywords in Java?

- A synchronized keyword is used to provide exclusive access to a shared resource by allowing only one thread to access it at a time, while volatile keyword is used to ensure visibility of changes made to a shaded variable by guaranteeing that all threads see the same value.

What is the purpose of the sleep() method in Java?

- The sleep() method is used to pause the execution of a thread for a specified amount of time, allowing other threads to execute in the meantime.

What is the difference between notify() and notifyAll() method in Java?

- The notify() is used to wake-up a single thread that is waiting on an object, while notifyAll() is used to wake-up all threads that are waiting on an object.
