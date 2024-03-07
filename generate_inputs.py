"""
examples:
pl,pw,sl
[['0x1d6', '0x8c', '0x2bc'],
 ['0x96', '0x28', '0x23a'],
 ['0x8c', '0x14', '0x208'],
 ['0x12c', '0x6e', '0x1fe'],
 ['0x1fe', '0xbe', '0x244']]
"""
# ['0x1d6', '0x8c', '0x2bc']
pl, pw, sl = 0x1d6, 0x8c, 0x2bc
print(hex(pl), hex(pw), hex(sl))

"""
target format string:
    .equ petal_length, 0xea
    .equ petal_width, 0x55
    .equ sepal_length, 0x1e
"""

print(f".equ petal_length, {hex(pl)}")
print(f".equ petal_width, {hex(pw)}")
print(f".equ sepal_length, {hex(sl)}")
