We check for prime factors up to the square root of a number to determine if it's prime because any composite number, which isn't prime, must have at least one factor less than or equal to its square root. This makes checking beyond the square root unnecessary.  
  
**The Logic Behind the Square Root Method**  
  
A prime number is a natural number greater than 1 that has no positive divisors other than 1 and itself. A **composite number** is a natural number that can be formed by multiplying two smaller natural numbers.  
  
Let's say we have a number $n$. If $n$ is a composite number, it can be written as the product of two factors, $a$ and $b$:  
  
$$n = a \times b$$  
  
For example, if $n = 36$, the factors could be:  
  
⚬ $$1 \times 36$$  
⚬ $$2 \times 18$$  
⚬ $$3 \times 12$$  
⚬ $$4 \times 9$$  
⚬ $$6 \times 6$$  
  
Notice that in each pair of factors $(a, b)$, one factor is less than or equal to the square root of 36 (which is 6), and the other is greater than or equal to 6.  
  
This is true for all composite numbers:  
  
⚬     If both factors $a$ and $b$ were **greater** than $\sqrt{n}$, their product $a \times b$ would be greater than $\sqrt{n} \times \sqrt{n}$, which is $n$. This contradicts our initial assumption that $a \times b = n$.  
⚬     If both factors $a$ and $b$ were **less** than $\sqrt{n}$, their product $a \times b$ would be less than $\sqrt{n} \times \sqrt{n}$, which is also $n$. This also contradicts our assumption.  
  
Therefore, for any composite number $n$, at least one of its factors must be less than or equal to its square root.  
  
**Practical Application**  
  
This principle simplifies the process of checking for primality. To test if a number $n$ is prime, you only need to divide it by prime numbers starting from 2 up to $\sqrt{n}$. If none of these prime numbers divide $n$ evenly, then $n$ must be a prime number.  
  
For instance, to check if the number **97** is prime, you would only need to check for prime factors up to $\sqrt{97}$, which is approximately 9.85. The prime numbers to check are **2, 3, 5, and 7**. Since 97 isn't divisible by any of these, it's a prime number.  
