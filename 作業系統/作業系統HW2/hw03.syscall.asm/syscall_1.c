#include <stdio.h>
#define SYS_READ 0
#define STDIN_FILENO 0
int main(int argc, char** argv) {
    char buff[10];
    ssize_t charsread;
    //注意我宣告為long，因為long是64位元

    printf("使用 'syscall' 呼叫system call\n");
    __asm__ volatile ("syscall"
        //"mov $1 , %%edx \n"
        //"leal p , %%ecx \n"
        //"mov $0 , %%ebx \n"
        //"mov $4 , %%eax \n"
        //"int $0x80 \n"
        :"=a"(charsread)
        : "0"(SYS_READ) , "D"(STDIN_FILENO) , "S"(buff) , "d"(sizeof(buff))
        : "rcx" , "r11" , "memory" , "cc");
    printf("input是：%s", buff);
}
