# Ruby lets you have a comma separated list of rvalues.
# If Ruby sees more than one rvalue in an assignment, the rules of
# parallel assignment come into play.
# 1) rvalues are evaluated, left to right, and collected into an array
# 2) lvalues are inspected. If it is a single element, array is
#   assigned to that element:

a = 1, 2, 3, 4 # a=[1, 2, 3, 4]
b = [1, 2, 3, 4] # b=[1, 2, 3, 4]

# 3) if lvalues contain a comma, Ruby matches rvalues against successive
# lvalues. Excess values are discarded

a, b = 1, 2, 3, 4 # a=1, b=2
c, = 1, 2, 3, 4 # c=1

# 4) if Ruby sees splats on the right hand side, each is expanded before
# evaluation and assignment

a, b, c, d, e = *(1..2), 3, *[4, 5]
# a=1, b=2, c=3, d=4, e=5

# Exactly one lvalue may be a splat. It is a greedy splat and will
# eat as many values as it can get its hands on.

a, *b = 1, 2, 3 # a=1, b=[2, 3]
a, *b = 1 # a=1, b=[]

# if the splat is not the last values, Ruby ensures that remaining lvalues
# each get one assignment

*a, b = 1, 2, 3, 4 # a=[1, 2, 3], b=4
c, *d, e = 1, 2, 3, 4 # c=1, d=[2, 3], e=4
f, *g, h, i, j = 1, 2, 3, 4 # f=1, h=2, i=3, j=4

# as with method parameters, a raw asterisk allows ignoring of some rvalues

first, *, last = 1, 2, 3, 4, 5, 6 # first=1, last=6

# lvalues in (parentheses) are treated as one block - one rvalue is unpacked
# into the parenthesis

a, (b, c), d = 1, 2, 3, 4 # a=1, b=2, c=nil, d=3
a, (b, c), d = [1, 2, 3, 4] # a=1, b=2, c=nil, d=4
a, (b, c), d = 1, [2, 3], 4 # a=1, b=2, c=3, d=4
a, (b, c), d = 1, [2, 3, 4], 5 # a=1, b=2, c=3, d=5
a, (b, *c), d = 1, [2, 3, 4], 5 # a=1, b=2, c=[3, 4], d=5
