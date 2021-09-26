#include <stdio.h>
int main(){
	printf("Hello!\n");
	__asm("int3");
	printf("Hello2!\n");
}
