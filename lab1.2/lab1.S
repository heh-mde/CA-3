.global lab1
.syntax unified

#define A #3
#define B #28
#define C #5

lab1:
	push {lr}
	//calculate
	mov r0, A
	mov r1, B
	mov r2, C
	bl calc
	pop {pc}

calc:
	push {r0, r1, r2, lr}
	cmp r0, r1
	ITE GE
	addGE r3, r0, r1
	subLT r3, r0, r1
	sdiv r3, r2
	pop {r0, r1, r2, pc}
