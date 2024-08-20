# JS Generator

- A functions that can be *paused* and *resumed* during execution.
- Generate values and control the iteration using `yield` keyword.
- Unlike regular functions, generators can return multiple values.

## Syntex

```js
function* myGenerator() {
  yield 1;
  yield 2;
  yield 3;
}

const gen = myGenerator();

console.log(gen.next()); // { value: 1, done: false }
console.log(gen.next()); // { value: 2, done: false }
console.log(gen.next()); // { value: 3, done: false }
console.log(gen.next()); // { value: undefined, done: true }
```

## Arguments

```js
// Generators can receive values and send them back.
function* twoWayGenerator() {
  const value = yield "Please provide a value";
  yield `You provided: ${value}`;
}

const gen = twoWayGenerator();

console.log(gen.next());   // { value: "Please provide a value", done: false }
console.log(gen.next(42)); // { value: "You provided: 42", done: false }
console.log(gen.next());   // { value: undefined, done: true }
```

## Enumeration

```js
// Generators can create custom iterators.
function* range(start, end, step) {
  let current = start;
  while (current < end) {
    yield current;
    current += step;
  }
}

const numbers = range(1, 10, 2);
for (const num of numbers) {
  console.log(num); // 1, 3, 5, 7, 9
}
```

## Delegation

```js
// Generators can join and delegate tasks among themselves.
function* generatorOne() {
  yield 1;
  yield 2;
}

function* generatorTwo() {
  yield 3;
  yield 4;
}

function* composedGenerator() {
  yield* generatorOne();
  yield* generatorTwo();
}

const gen = composedGenerator();

console.log(gen.next()); // { value: 1, done: false }
console.log(gen.next()); // { value: 2, done: false }
console.log(gen.next()); // { value: 3, done: false }
console.log(gen.next()); // { value: 4, done: false }
console.log(gen.next()); // { value: undefined, done: true }
```

## Exception

```js
// Generators can handle errors using try/catch.
function* errorGenerator() {
  try {
    yield 1;
    yield 2;
    throw new Error("Error!");
    yield 3; // This line will not be reached
  } catch (error) {
    yield `Error: ${error.message}`;
  }
}

const gen = errorGenerator();

console.log(gen.next()); // { value: 1, done: false }
console.log(gen.next()); // { value: 2, done: false }
console.log(gen.next()); // { value: "Error!", done: false }
console.log(gen.next()); // { value: undefined, done: true }
```
