#include <stdio.h>

// Must declare the main assembly entry point before use.
extern void main_asm();

int main() {
    // Jump into the main assembly code subroutine that implements the project.
    main_asm();
    // Returning zero indicates everything went okay.
    return 0;
}
