section .text
  global _start
_start:
  mov rcx, LEN
  dec rcx

 l1:
  push rcx		; push to save l1 loop count
 l2:
  mov dl, [j]
  sub dl, '0'
  mov rbx, ints
  add rbx, rdx
  mov al, [rbx]

  mov dl, [i]
  sub dl, '0'
  mov rbx, ints
  add rbx, rdx
  add al, [rbx]

  cmp al, TARGET
  je found

  inc byte [j]
 loop l2
  inc byte [i]

  mov al, [i]		; reset j value to i + 1
  inc al
  mov byte [j], al

  pop rcx		; restore l1 loop count
 loop l1
 ;dec rcx		; jumps > 128 bytes, can't use short jump (loop)
 ;cmp rcx, 0
 ;jne l1

end:
  mov rax, 60
  mov rdi, 0
  syscall

found:
  mov rax, 1
  mov rdi, 1
  mov rsi, i
  mov rdx, 2
  syscall

  mov rax, 1
  mov rsi, j
  syscall

  jmp end

section .data
 ints db 1,5,2,17,9,-1,12,2,0,-3
 i db "0", 10
 j db "1", 10
 LEN equ 10
 TARGET equ 14
