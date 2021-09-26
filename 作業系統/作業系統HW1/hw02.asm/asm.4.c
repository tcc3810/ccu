#include <time.h>
#include <stdio.h>
int main(int argc, char** argv) {
    unsigned long msr;
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC_RAW, &ts);
    asm volatile ( "rdtscp\n\t"  // Returns the time in EDX:EAX.
        "shl $32, %%rdx\n\t"    // Shift the upper bits left.
        "or %%rdx, %0"          // 'Or' in the lower bits.
        : "=a" (msr)            //msr會放在rax暫存器
        : 
        : "rdx");
    printf("%ld\n", msr);
    printf("%ld\n", (ts.tv_nsec + ts.tv_sec*1000000000));
}
