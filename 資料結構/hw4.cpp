#include <iostream>
#include <cstdlib>
#include <string>
void init(bool **bits , int num , int hashFunction , int **a , int **b , int prime){
	// 建立 m == num 元素的陣列 "bits"
	*bits = (bool *)malloc(sizeof(bool) * num);
	
	// 建立 r == hashFunction 個元素的 "a" ，並且放 (1 ~ p-1) ---> srand(1)
	srand(1);
	*a = (int *)malloc(sizeof(int) * hashFunction);
	for(int i = 0 ; i < hashFunction ; i++){
		(*a)[i] = rand() % (prime - 1) + 1;
	}

	// 建立 r == hashFunction 個元素的 "b" ，並且放 (1 ~ p-1) ---> srand(2)
	srand(2);
	*b = (int *)malloc(sizeof(int) * hashFunction);
	for(int i = 0 ; i < hashFunction ; i++){
		(*b)[i] = rand() % (prime - 1) + 1;
	}
}

int myhash(char *str , int count , int num , int hashFunction , int prime , int *a , int *b){
	std::hash<std::string> hasher;
	size_t key = hasher(str);
	
	return (a[count] * key + b[count]) % prime % num;
}

void insert(bool *bits , int num , int hashFunction , int prime , char *str , int *a , int *b){
	for(int count = 0 ; count < hashFunction ; count++){
		bits[myhash(str , count , num , hashFunction , prime , a , b)] = 1;
	}
}

bool query(bool *bits , int num , int hashFunction , int prime , char *str , int *a , int *b){
	for(int count = 0 ; count < hashFunction ; count++){
		if(bits[myhash(str , count , num , hashFunction , prime , a , b)] == 0){
			return 0;
		}
	}
	return 1;
}
int main(){
	bool *bits;
	int *a , *b;
	int num , hashFunction , prime;
	int words , tests;
	if(scanf("%d %d %d %d %d" , &num , &hashFunction , &words , &tests , &prime)){};
	init(&bits , num , hashFunction , &a , &b , prime);
/*
	for(int i = 0 ; i < num ;i++)
		printf("%d " , bits[i]);
	printf("\n");

*/	char *str = (char *)malloc(sizeof(char) * 1024);

	for(int i = 0 ; i < words ; i++){
		if(scanf("%s" , str)){};
		insert(bits , num , hashFunction , prime , str , a , b);
	}
	for(int i = 0 ; i < tests ; i++){
		if(scanf("%s" , str)){};
		
		if(query(bits , num , hashFunction , prime , str , a , b) == 1)
			printf("%s: true\n" , str);
		else
			printf("%s: false\n" , str);
	}
/*
	for(int i = 0 ; i < num ;i++)
		printf("%d " , bits[i]);
	printf("\n");
*/
	return 0;

}
