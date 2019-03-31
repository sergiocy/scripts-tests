
import itertools as it
import kanren.core as lc
from sympy.ntheory.generate import prime, isprime
from kanren import membero

# ...function to check if a number is prime...
def check_prime(x):
    if lc.isvar(x):
        return lc.condeseq([lc.eq, x, p] for p in map(prime, it.count(1)))
    else:
        return lc.success if isprime(x) else lc.fail

# ...declare the variable...
x = lc.var()

# Check if an element in the list is a prime number
list_nums = (23, 4, 27, 17, 13, 10, 21, 29, 3, 32, 11, 19)
print('\nList of primes in the list:')
print(set(lc.run(0, x, (membero, x, list_nums), (check_prime, x))))
