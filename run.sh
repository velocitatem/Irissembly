avr-as -mmcu=atmega328p -o output.o test.asm
avr-ld -o output.elf output.o
avr-objcopy -O ihex output.elf output.hex
# open new shell in local as daemon and run the following command avg-gdb output.elf
xfce4-terminal -e "avr-gdb output.elf" &
echo "target remote localhost:1234"
simavr -f 16000000 -m atmega328p output.elf -g # to add the -g flag for debuggineeg
# avrdude -c arduino -p m328p -P /dev/ttyACM1 -b 115200 -U flash:w:output.hex
