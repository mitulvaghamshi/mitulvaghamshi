// A functions that can be *paused* and *resumed* during execution.
// Generate values and control the iteration using `yield` keyword.
// Unlike regular functions, generators can return multiple values.

// Syntex
// -----------------------------------------------------------------
function* myGenerator() {
  yield 1;
  yield 2;
  yield 3;
}

const v1 = myGenerator();

console.log(v1.next()); // { value: 1, done: false }
console.log(v1.next()); // { value: 2, done: false }
console.log(v1.next()); // { value: 3, done: false }
console.log(v1.next()); // { value: undefined, done: true }
// -----------------------------------------------------------------

// Arguments
// -----------------------------------------------------------------
// Generators can receive values and send them back.
function* twoWayGenerator() {
  const value = yield "Please provide a value";
  yield `You provided: ${value}`;
}

const v2 = twoWayGenerator();

console.log(v2.next());   // { value: "Please provide a value", done: false }
console.log(v2.next(42)); // { value: "You provided: 42", done: false }
console.log(v2.next());   // { value: undefined, done: true }
// -----------------------------------------------------------------

// Enumeration
// -----------------------------------------------------------------
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
// -----------------------------------------------------------------

// Delegation
// -----------------------------------------------------------------
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

const v3 = composedGenerator();

console.log(v3.next()); // { value: 1, done: false }
console.log(v3.next()); // { value: 2, done: false }
console.log(v3.next()); // { value: 3, done: false }
console.log(v3.next()); // { value: 4, done: false }
console.log(v3.next()); // { value: undefined, done: true }
// -----------------------------------------------------------------

// Exception
// -----------------------------------------------------------------
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

const v4 = errorGenerator();

console.log(v4.next()); // { value: 1, done: false }
console.log(v4.next()); // { value: 2, done: false }
console.log(v4.next()); // { value: "Error!", done: false }
console.log(v4.next()); // { value: undefined, done: true }
// -----------------------------------------------------------------
