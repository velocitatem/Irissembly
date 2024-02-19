.section .text
.global main
.global is_lower



main:
    ; A
    LDI R20, 0xCCC & 0xFF  ; Lower byte of the first number (0x1234)
    LDI R21, 0xCCC >> 8  ; Upper byte of the first number (0x1234)
    ; B
    LDI R22, 0xCCC & 0xFF  ; Lower byte of the second number (0xABCD)
    LDI R23, 0xCCC >> 8  ; Upper byte of the second number (0xABCD)

    ; Call the is_lower subroutine
    CALL is_lower

    ; Your test script continues...



; Subroutine to compare 16-bit numbers
; A (R20:R21), B (R22:R23)
; Result in R19 = 0 if A < B, else R19 = 1

is_lower:
    CP R21, R23      ; Compare upper bytes (A' and B')
    BRLO a_is_lower  ; If A' < B', branch to a_is_lower

    ; If upper bytes are equal, compare lower bytes
    CP R20, R22      ; Compare lower bytes (A and B)
    BRGE a_is_higher

    CP R20, R22
    BRLT a_is_lower
    BRGE a_is_higher

a_is_higher:
    LDI R19, 1       ; A is not lower than B
    RET

a_is_lower:
    LDI R19, 0       ; A is lower than B
    RET

.end
