.section .text
.global main

;; |--- petal length (cm) <= 2.60
;; |   |--- class: 0
;; |--- petal length (cm) >  2.60
;; |   |--- petal width (cm) <= 1.75
;; |   |   |--- petal length (cm) <= 4.95
;; |   |   |   |--- class: 1
;; |   |   |--- petal length (cm) >  4.95
;; |   |   |   |--- class: 2
;; |   |--- petal width (cm) >  1.75
;; |   |   |--- petal length (cm) <= 4.85
;; |   |   |   |--- class: 1
;; |   |   |--- petal length (cm) >  4.85
;; |   |   |   |--- class: 2
  ;; define the constants
.equ petal_length_threshold, 0x104
.equ petal_width_threshold, 0xAF
.equ petal_length_threshold_2, 0x1EF
.equ petal_length_threshold_3, 0x1E5


main:
    ; Initialize registers with test values

    ;; 24-31 for inputs
    ;; 24-5 petal length
    ;; 26-7 petal width
    ;; 28-9 sepal length
    .equ petal_length, 0x12C
    .equ petal_width, 0x55
    .equ sepal_length, 0x1e


    LDI R24, petal_length & 0xFF
    LDI R25, (petal_length >> 8)

    LDI R26, petal_width & 0xFF
    LDI R27, (petal_width >> 8) & 0xFF

    LDI R28, sepal_length & 0xFF
    LDI R29, (sepal_length >> 8) & 0xFF



    ldi R19, 0    ; Initialize result to 0




;;;  threshold load
    LDI R20, petal_length_threshold_2 & 0xFF
    LDI R21,  (petal_length_threshold_2 >> 8) & 0xFF
;;;  input load
    MOV R22, R24
    MOV R23, R25
    call is_lower
    ;; R9 contains the result of the comparison
    ;; if R9 = 0, petal_length <= 2.60
    ;; if R9 = 1, petal_length > 2.60
    CP R19, 0x0
    brne ptl_gt_260  ; petal_length > 2.60, R19 = 1

    brge ptl_lt_260  ; petal_length <= 2.60, R19 = 0


    rjmp end  ; petal_width <= 0.80, R19 = 0


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











ptl_lt_260:

  rjmp end  ; petal_length <= 2.60, R19 = 0

ptl_gt_260:
    ; Assuming R16 and R17 hold the value you want to compare
    ; First, load the value from petal_width_threshold

    rjmp end  ; petal_width > 1.75, R19 = 2



end:
    ; R19 contains the classification result
    ; Implement output method here
  ;;  output r19

    ret

.end
