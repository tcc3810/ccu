#include <stdio.h>
int main(int argc, char** argv) {
    long int a=10, b=20, c=90, d=100;
    printf("a=%ld, b=%ld, c=%ld, d=%ld\n", a, b, c, d);
    __asm__ volatile (  
    "mov %1, %%rax\n"   //  rax = a
    "mov %2, %%rbx\n"   //  rbx = b
    "add %%rbx, %%rax\n"   // rax += rbx
    "mov %%rax, %0\n"   // c = rax
    : "=m" (c)  //output
    : "g" (a), "g" (b) //input
    : "rbx", "rax" //搞爛掉的暫存器
    );
    printf("c = a + b\n");
    printf("a=%ld, b=%ld, c=%ld, d=%ld\n", a, b, c, d);
}
