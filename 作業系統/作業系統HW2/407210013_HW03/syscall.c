#include <stdio.h>
int main(int argc, char** argv) {
    char buf[10] = {0};
    long len;
    long ret;

    printf("使用 'syscall' 呼叫system call\n");
    __asm__ volatile ( 
        "mov $0, %%rax\n"   // rax = read() return fd
        "mov $0, %%rdi\n"   // rdi = write(fd , buf , len)
        "mov %1, %%rsi\n"   // rsi = buf
        "mov %2, %%rdx\n"   // rdx = len
        "syscall\n"
        "mov %%rax, %0"
        :  "=m"(ret)
        : "g" (buf), "g" (sizeof(buf))
        : "rax", "rbx", "rcx", "rdx");
    printf("input是：%s", buf);
}
