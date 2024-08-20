# JavaScript Generators

- JavaScript generators are special functions that can be paused and resumed
  during execution.
- They use the `yield` keyword to produce values and control the flow of
  iteration.
- Regular functions return only one, single value, but generators can return
  ("yield") multiple values.

## Example

- To create a generator, first define a generator function with `function*`
  symbol.
- When it's called, it doesn't immediately run its code. Instead, it returns a
  special object known as a "generator object".

```js
function* myGenerator() {
  yield 1;
  yield 2;
  yield 3;
}

const gen = myGenerator();

console.log(gen.next()); // { value: 1, done: false }
console.log(gen.next()); // { value: 2, done: false }
console.log(gen.next()); // / value: 3, done: false }
console.log(gen.next()); // / value: undefined, done: true }
```

# Passing Arguments

- Generators are not only great at producing values, but they're also excellent
  listeners!
- They can receive values and send them back too.

```js
function* twoWayGenerator() {
  const value = yield "Please provide a value";
  yield `You provided: ${value}`;
}

const gen = twoWayGenerator();

console.log(gen.next()); // { value: "Please provide a value", done: false }
console.log(gen.next(42)); // { value: "You provided: 42", done: false }
console.log(gen.next()); // { value: undefined, done: true }
```

# Iterating with Generators

- Generators can create custom iterators!
- It's like giving them the power to control the flow of iteration.
- Here's an example of how you can build custom iterators using generators.
- We can loop over their values using for..of construct.

```js
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

# Generator Delegation

- Generators can join and delegate tasks among themselves.
- It's like assembling a dream team of generators.

```js
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

# Error Handling

- Error handling is essential, and generators provide mechanisms to handle
  errors using `try...catch`.

```js
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

# Summary

- Generators are created by generator functions `function* f(...) {..}`.
- Inside generators (only) there exists a yield operator.
- The outer code and the generator may exchange results via next/yield calls.
- As always, I hope you enjoyed the post and learned something new.
- If you have any queries then let me know in the comment box.
