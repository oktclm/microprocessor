    .section .data
    .equ GPIO_BASE, 0x40014000      @ Base address of GPIO registers
    .equ SIO_BASE, 0xD0000000       @ Base address of SIO registers
    .equ GPIO_OUT, 0x10             @ GPIO output register offset
    .equ GPIO_DIR, 0x14             @ GPIO direction register offset
    .equ GPIO_PIN_COUNT, 10         @ Number of GPIOs for LED bar

    .section .text
    .global main_asm

main_asm:
    @ Initialize GPIOs for LED bar
    ldr r0, =SIO_BASE
    ldr r1, =GPIO_BASE
    add r1, r1, #GPIO_DIR           @ GPIO direction register

    @ Set GPIOs GP1-GP10 as outputs
    movs r2, #0xFF                  @ Set the lower 8 bits (GP1-GP8)
    str r2, [r0, r1]                @ Write lower 8 bits to GPIO direction register
    movs r2, #0x03                  @ Set the upper 2 bits (GP9-GP10)
    lsl r2, r2, #8                  @ Shift the bits to the correct position
    str r2, [r0, r1]                @ Write upper bits to GPIO direction register

loop:
    @ Example: Light up the first 5 LEDs (GP1-GP5)
    movs r1, #0x1F                  @ Bitmask for the first 5 LEDs (00011111)
    ldr r2, =SIO_BASE
    str r1, [r2, #GPIO_OUT]         @ Write the bitmask to the GPIO output register

    @ Delay for stability (rough delay)
    movs r7, #64                    @ Set up a delay value within the immediate range
delay_loop:
    sub r7, r7, #1                  @ Decrement the delay counter
    cmp r7, #0                      @ Compare with zero
    bne delay_loop

    b loop                          @ Repeat the loop
