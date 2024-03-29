;; This is a decision tree classifier for the iris dataset
;; Written for the AVR architecture of the ATmega328P
;; Written by: Daniel Alves Rosel
;; -------------------------------------
;; The decision tree was obtained by training a DecisionTreeClassifier from the sklearn library
;; The classification result is primarily written to memory and under register r31, but the output_int interupt can be used to output the result to the Arduino pins 8, 9, 10


.section .text
.global main

;; |--- petal length (cm) <= 2.60
;; |   |--- class: 0 + 1
;; |--- petal length (cm) >  2.60
;; |   |--- petal width (cm) <= 1.75
;; |   |   |--- petal length (cm) <= 4.95
;; |   |   |   |--- class: 1 + 1
;; |   |   |--- petal length (cm) >  4.95
;; |   |   |   |--- class: 2 + 1
;; |   |--- petal width (cm) >  1.75
;; |   |   |--- petal length (cm) <= 4.85
;; |   |   |   |--- class: 1 + 1
;; |   |   |--- petal length (cm) >  4.85
;; |   |   |   |--- class: 2 + 1

.equ petal_length_threshold, 0x104
.equ petal_width_threshold, 0xAF
.equ petal_length_threshold_2, 0x1EF
.equ petal_length_threshold_3, 0x1E5


main:
    ;; 24-31 for inputs
    ;; 24-5 petal length
    ;; 26-7 petal width
    ;; 28-9 sepal length

    ;; For the sake of simulating the AVR this is the simplest way to pass the inputs
    ;; For a live implementation, one could read data straight from inputs
    .equ petal_length, 0x1d6
    .equ petal_width, 0x8c
    .equ sepal_length, 0x2bc    ; under current logic this is unused but can be used for further branching => higher acc


    LDI R24, petal_length & 0xFF
    LDI R25, (petal_length >> 8)
    LDI R26, petal_width & 0xFF
    LDI R27, (petal_width >> 8)
    LDI R28, sepal_length & 0xFF
    LDI R29, (sepal_length >> 8)
    ;; Another option would be to use buffers XYZ but for operations on these values
    ;; it is easier to use this step

    ldi R19, 0x0    ; Initialize result to 0

    LDI R22, petal_length_threshold & 0xFF
    LDI R23,  (petal_length_threshold >> 8)
    MOV R20, R24
    MOV R21, R25
    call is_lower               ; input < threshold ?

    CP R19, 0
    BRNE ptl_gt_260             ; means input > threshold
    BREQ ptl_lt_260             ; means input <= threshold
    RET


is_lower:
    ;; Inputs: A,A',B,B' (R20,R21,R22,R23) where A' and B' are the upper bytes
    CP R21, R23      ; Compare upper bytes (A' and B')
    BRLO a_is_lower  ; If A' < B', branch to a_is_lower

    ; If upper bytes are equal, compare lower bytes
    CP R20, R22      ; Compare lower bytes (A and B)
    BRGE a_is_higher ; If A >= B, branch to a_is_higher

    CP R20, R22
    BRSH a_is_higher ; If R20 >= R22, branch to a_is_higher
    RJMP a_is_lower  ; If not, jump to a_is_lower (R20 < R22)
    RET

a_is_higher:
    LDI R19, 1       ; A is not lower than B
    RET

a_is_lower:
    LDI R19, 0       ; A is lower than B
    RET

ptl_lt_260:
;; set result to 0 + 1
    LDI R31, 1
    RJMP classified

ptl_gt_260:
;; |   |--- petal width (cm) <= 1.75
;; |   |   |--- petal length (cm) <= 4.95
;; |   |   |   |--- class: 1 + 1
;; |   |   |--- petal length (cm) >  4.95
;; |   |   |   |--- class: 2 + 1
;; |   |--- petal width (cm) >  1.75
;; |   |   |--- petal length (cm) <= 4.85
;; |   |   |   |--- class: 1 + 1
;; |   |   |--- petal length (cm) >  4.85
;; |   |   |   |--- class: 2 + 1

    LDI R22, petal_width_threshold & 0xFF
    LDI R23,  (petal_width_threshold >> 8) & 0xFF
    MOV R20, R26
    MOV R21, R27
    call is_lower               ; input < threshold ?

    CP R19, 0  ; R19 = 0 means input < threshold
    ;; |   |   |--- petal width (cm) >  1.75
    BRNE ptl_gt_175             ; means input > threshold
    ;; |   |   |--- petal width (cm) <= 1.75
    CP R19, 0                   ; not sure if like this or not but just to be sure I run it twice - not like it will be a problem ... I hope...
    BREQ ptl_lt_175             ; means input <= threshold
    RET


ptl_lt_175:
;; |   |   |--- petal length (cm) <= 4.95
;; |   |   |   |--- class: 1 + 1
;; |   |   |--- petal length (cm) >  4.95
;; |   |   |   |--- class: 2 + 1
;; threshold 2 applies to first case of second sub branch of case of <= 1.75
    LDI R22, petal_length_threshold_2 & 0xFF
    LDI R23,  (petal_length_threshold_2 >> 8) & 0xFF
    MOV R20, R24
    MOV R21, R25
    call is_lower               ; input < threshold ?

    CP R19, 0
    ;; |   |   |--- petal length (cm) >  4.95
    BRNE ptl_gt_495             ; means input > threshold
    ;; |   |   |--- petal length (cm) <= 4.95
    BREQ ptl_lt_495             ; means input <= threshold
    RET

ptl_gt_495:
;; TODO : validate if this is the correct target class mapping
;; |   |   |--- petal length (cm) >  4.95
    LDI R31, 3
    RJMP classified
ptl_lt_495:
;; |   |   |--- petal length (cm) <= 4.95
    LDI R31, 2
    RJMP classified
ptl_gt_175:
    ;; |   |--- petal width (cm) >  1.75
    ;; |   |   |--- petal length (cm) <= 4.85
    LDI R22, petal_length_threshold_3 & 0xFF
    LDI R23,  (petal_length_threshold_3 >> 8) & 0xFF
    MOV R20, R24
    MOV R21, R25
    call is_lower               ; input < threshold ?
    CP R19, 0
    BRNE ptl_gt_485             ; means input > threshold
    BREQ ptl_lt_485             ; means input <= threshold
    RET
ptl_gt_485:
    ;; |   |   |--- petal length (cm) >  4.85
;;;  result branch
    LDI R31, 3
    RJMP classified
ptl_lt_485:
    ;; |   |   |--- petal length (cm) <= 4.85
    LDI R31, 2
    RJMP classified


classified:
  ;; for now we just write to memory
  STS 0x00800101, R31
  RJMP end

end:
  ;; End of program
  RET




.end
