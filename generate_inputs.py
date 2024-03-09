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
def generate_gdb_commands(petal_length, petal_width, sepal_length):
    commands = []
    commands.append(f'set $r24 = {petal_length & 0xFF}')
    commands.append(f'set $r25 = {(petal_length >> 8) & 0xFF}')
    commands.append(f'set $r26 = {petal_width & 0xFF}')
    commands.append(f'set $r27 = {(petal_width >> 8) & 0xFF}')
    commands.append(f'set $r28 = {sepal_length & 0xFF}')
    commands.append(f'set $r29 = {(sepal_length >> 8) & 0xFF}')
    return commands

commands = generate_gdb_commands(pl, pw, sl); cstring = '\n'.join(commands)
with open('inputs.gdb', 'w') as f:
    f.write(cstring)
