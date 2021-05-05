.global lab4
.syntax unified

#define X1 #-17
#define X2 #12
#define X3 #17
#define X4 #3

lab4:
push {lr}
bl task1
bl task2
pop {pc}

task1:
push {lr}
mov r0, X1  
mov r1, #0xFFFFFFFF

mov r2, X2 
mov r3, #0

mov r4, X3 
mov r5, #0
 

mov r6, X4 
mov r7, #0

// Calculation
    
    
    asrs r2, #1      		// x2/2
    asr r3,  #1

    orrs r0, r2		// (x1 | x2/2)
    orr r1,  r3

    asrs r0, #3
    asr r1,  #3		// (x1|x2/2)/8
    
    eors r4, #0xFFFFFFFF     
    eor r5,  #0xFFFFFFFF	// not x3
    
    eors r4, #1
    
    orrs r4, r6
    orr r5,  r7		// (not x3 xor 1 | x4)
    
    lsls r4, #1
    lsl r5,  #1		// 2*(not x3 xor 1 | x4)
    
    subs r0, r4      		
    sub r1,  r5		// (x1|x2/2)/8-2*(not x3 xor 1 | x4)


bl result_correction
pop {pc}



result_correction:
push {lr}
bvc step2
//step1
lsr r0, #1
lsr r1, #1     

step2:
orr r0, #0 //перевірка на рівність нулю
bne step4 // якщо ні, перейти на крок 4
//step3
ldr r1,= #8108
step4:
    ldr r8,= #8108
    add r0, r8 
step5:
    and r3, r1, #0x80000000
    and r4, r1, #0x40000000
    lsl r4, #1
    cmp r3, r4
    beq step7
step6:
    mov r8, 0
    lsrs r1, #1
    adc r8, 0
    lsl r8, 31
    lsr r0, #1
    orr r0, r8
step7:
	bvs end_check_result
	push {r0}
	push {r1}
	pop {r1}
	pop {r0}

end_check_result:
	pop {pc}

task2:
	push {lr}

	mov r1, #25
	mov r2, #56

program_a:
	// 1: r0 = r1 - r2
	sub r0, r1, r2
	
	// 2: r0 = r1 * r2
	mul r0, r1, r2

    t2_loop1:
    // 3: r0 = r1 - r2
        subs r0, r1, r2

        // 4: if N = 1
        bmi t2_loop1_b1

        t2_loop1_b0:
            // 5: r0 = r2 + 40
            adds r2, r2, #40
            // 7: r0 = r2 + 1
            adds r0, r2, #1
            b t2_loop1_check

        t2_loop1_b1:
            // jump to program b
            bl program_b
            // 6: r0 = r1 * r2
            mul r0, r1, r2

        t2_loop1_check:
            // 8: if V = 0
            bvs t2_loop1
    

    // 9: r0 = r1 ^ r2
    eor r0, r1, r2

    pop {pc}

    program_b:
        push {lr}

        t2_loop2:
            // 10: r1 = r1 & 0
            ands r1, r1, #0

            // jump to program c
            bl program_c

            // 11: if Z = 0 (inverted)
            bne t2_loop1_b

            // 12: r1 = r1 - r2
            subs r1, r1, r2

            t2_loop1_b:
            
            bpl t2_loop2

        // 14: r1 = r2 - 5
        subs r1, r2, #5

        // 15: r0 = r1 * r2
        mul r0, r1, r2

        pop {pc}

    program_c:
        push {lr}

        // 17: r0 = r0 * 5
        mov r10, #5
        mul r0, r0, r10

        // 18: r1 = r0 / 4
        asr r1, r0, #2
        
        pop {pc}


