thresh = 0x104
test = 0x12C

def lower_upper_split(any_number):
    lower = any_number & 0xFF
    upper = any_number >> 8
    return lower, upper


test_l, test_u = lower_upper_split(test)
thresh_l, thresh_u = lower_upper_split(thresh)

# compare if test > thresh
if test_u > thresh_u:
    print("test > thresh")
elif test_u < thresh_u:
    print("test < thresh")
else:
    if test_l > thresh_l:
        print("test > thresh")
    elif test_l < thresh_l:
        print("test < thresh")
    else:
        print("test = thresh")

def a_lt_b(a, b):
    a_l, a_u = lower_upper_split(a)
    b_l, b_u = lower_upper_split(b)
    print(a_l, a_u, b_l, b_u)
    if a_u < b_u:
        return True
    elif a_u > b_u:
        return False
    if kj
        return a_l < b_l
import random
size = 10000
a = [random.randint(0, 0xFFFF) for _ in range(size)]
b = [random.randint(0, 0xFFFF) for _ in range(size)]
same = []
for i in range(size):
    r1 = a_lt_b(a[i], b[i])
    r2 = a[i] < b[i]
    same.append(r1 == r2)
print(all(same))
