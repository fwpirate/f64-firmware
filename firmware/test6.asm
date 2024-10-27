org 0xF0000000

setup:
    mov sbp, stack
    mov scp, sbp
    mov stp, stack_end
    call load_IDT
    mov cr0, 1 ; enter protected mode
    call main
    int 0x41
    mov cr0, 0 ; exit protected mode
    hlt

main:
    mov r0, buf
    mov r1, message
    mov r2, 14
    call memcpy
    call print
    ret

print: ; r0 = null-terminated string
    mov r1, 0 ; use r1 as counter
.l:
    mov r2, BYTE [r0+r1]
    cmp BYTE r2, 0
    jz .end
    mov BYTE [3758096384], BYTE r2
    inc r1
    jmp .l
.end:
    ret

memcpy: ; r0 = dst, r1 = src, r2 = count
    mov r3, 0 ; use r3 as counter
    cmp r3, r2
    jz .end
.l:
    mov BYTE [r0+r3], BYTE [r1+r3]
    inc r3
    cmp r3, r2
    jnz .l
.end:
    ret

message: ; "Hello, World!"
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

%include "IDT.inc"

stack:
%include "stack.inc"
stack_end: