.syntax unified
.cpu cortex-m4
//.fpu softvfp
.thumb

.global bootload
.section .rodata
	image: .incbin "kernel.bin"
	end_of_image:
	str_boot_start: .asciz "bootloader started"
	str_boot_end: .asciz "bootloader end"
	str_boot_indicate: .asciz "#"

.section .text
bootload:
	ldr r0, =str_boot_start
	bl dbgput_line
	ldr r0, =end_of_image
	ldr r1, =image
	ldr r2, =_ram_start

loop:
	ldm r1!, {r3-r5}
	stm r2!, {r3-r5}
	cmp r0, r1
	bhi loop

bl newline
ldr r0, =str_boot_end
bl dbgput_line

ldr lr, =bootload_end
add lr, #1
ldr r2, =_ram_start
add r2, #4
ldr r0, [r2]
bx r0
bootload_end:
b bootload_end
