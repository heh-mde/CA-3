.syntax unified
.cpu cortex-m4
.thumb
#define A #25
#define B #3
#define C #4

.global vtable_kernel
.global __kernel_reset__

.type vtable_kernel, %object
.type __kernel_reset__, %function

.section .interrupt_vector
vtable_kernel:
	.word __stack_start
	.word __kernel_reset__+1
	.size vtable_kernel, .-vtable_kernel

.section .rodata
	data: .asciz "kernel started!\n"
	final: .asciz "Value in register #3: "

.section .text
__kernel_reset__:
	ldr r0, =data
	bl dbgput_line

	mov r0, A
	mov r1, B
	mov r2, C
	cmp r0, r1
	ITE GE
	addGE r3, r0, r1
	subLT r3, r0, r1
	sdiv r3, r2

	ldr r0, =final
	bl dbgput_line
	mov r0, r3
	bl dbgput_num

	end:
	b end
