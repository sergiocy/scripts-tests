# ...mathematical operations...
import sympy as sym
#import logpy as log
#from logpy import run, var, fact
from kanren import var, run, fact
import kanren.assoccomm as la

# ...we define two operations...
add = 'addition'
mul = 'multiplication'

# ...and its properties (conmutativity)...
fact(la.commutative, mul)
fact(la.commutative, add)
fact(la.associative, mul)
fact(la.associative, add)

# ...we define logical variables...
a, b, c = var('a'), var('b'), var('c')
expression_orig = (add, (mul, 3, -2), (mul, (add, 1, (mul, 2, 3)), -1))
expression1 = (add, (mul, (add, 1, (mul, 2, a)), b), (mul, 3, c))
expression2 = (add, (mul, c, 3), (mul, b, (add, (mul, 2, a), 1)))
expression3 = (add, (add, (mul, (mul, 2, a), b), b), (mul, 3, c))

# Compare expressions
print(run(0, (a, b, c), la.eq_assoccomm(expression1, expression_orig)))
print(run(0, (a, b, c), la.eq_assoccomm(expression2, expression_orig)))
print(run(0, (a, b, c), la.eq_assoccomm(expression3, expression_orig)))
