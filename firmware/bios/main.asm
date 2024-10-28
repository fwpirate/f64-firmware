org 0xF0000000

setup:
    ; Load the stack
    mov sbp, stack
    mov scp, sbp
    mov stp, stack_end

    ; Load and setup idt
    call load_idt
    
    ; Enter protected mode and calling main
    mov cr0, 1
    call main

    ; Exit protected mode
    int 0x1
    mov cr0, 0

    ; Halt the processor to prevent further execution
    hlt

main:
    ; Print the message using: memcpy and print

    ; memcpy(buf, "Hello, World!", 14)
    mov r0, buf
    mov r1, message
    mov r2, 14
    call memcpy

    ; r0 holds our string, as print expects
    ; print("Hello, World!\n")
    call print
    ret

; print: r0 = str (null terminated string)
print:
    ; Use r1 as counter
    mov r1, 0
.l:
    mov r2, BYTE [r0+r1]
    cmp BYTE r2, 0
    jz .end
    mov BYTE [3758096384], BYTE r2
    inc r1
    jmp .l
.end:
    ret

; memcpy: r0 = dst, r1 = src, r2 = count
memcpy:
    ; Use r3 as counter
    mov r3, 0
    cmp r3, r2
    jz .end
.l:
    mov BYTE [r0+r3], BYTE [r1+r3]
    inc r3
    cmp r3, r2
    jnz .l
.end:
    ret

; "Hello, World!"
message: 
    db 72
    db 101
    db 108
    db 108
    db 111
    db 44
    db 32
    db 87
    db 111
    db 114
    db 108
    db 100
    db 33
    db 0

buf:
    dq 0
    dd 0
    dw 0

%include "idt.asm"

stack:
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
    dq 0
stack_end: