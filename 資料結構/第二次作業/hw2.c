#include <stdio.h>
#include <stdlib.h>
#define Maxterm 100
#define False 0
#define True 1
#define Unused 1
#define Used -1
#define Cancel -2

typedef struct Node* NodePtr;
typedef struct ListNode* ListNodePtr;
struct Node{
    int id;
    ListNodePtr child;	// 指標
    NodePtr parent;	// 陣列
};
struct ListNode{
    NodePtr data;	// 指標
    ListNodePtr next;	// 指標
};
int num = 0;
int count = 0;
int starting[Maxterm];
int ending[Maxterm];
int middle[Maxterm][Maxterm];
int visit[Maxterm] = {False};
int stack[Maxterm];
int myindex = -1;

void pop(){
	stack[myindex] = -1;
	myindex = myindex - 1;
}
void push(int id){
	myindex = myindex + 1;
	stack[myindex] = id;
}
int is_empty(){
	if(myindex == -1){
		return True;
	}
	else{
		return False;
	} 
}

void insert_child(NodePtr *top , int i){
	(*top)[i].id = i;
	if(starting[i] == -1)
		return;
	ListNodePtr first = malloc(sizeof(struct ListNode));
	first->data = (*top) + starting[i];
	first->next = NULL;
	(*top)[i].child = first;

	int j = starting[i];
	if(j == -1)
		return;
	while(starting[j] != -1){
		ListNodePtr tmp = malloc(sizeof(struct ListNode));
		tmp->data = (*top) + starting[j];
		tmp->next = NULL;
		first->next = tmp;

		first = tmp;
		j = starting[j];
	}
}
void insert_parent(NodePtr *top , int i){
	for(int j = 0 ; j < num ; j++){
		(*top)[i].parent[j].id = j;
		if(starting[j] == i){ // i child , j parent	 ex: i = 4 , j = 2
			(*top)[i].parent[j].child = (*top)[j].child; // ListNodePtr = ListNodePtr | (*top)[i] struct Node
			(*top)[i].parent[j].parent = (*top)[j].parent; // NodePtr = NodePtr | (*top)[j] struct Node
		}
		else{
			(*top)[i].parent[j].child = NULL;
		}
	}
}

void link_change(NodePtr *top , int i){ // i = 8
	visit[i] = Used;
	for(int j = 0 ; j < num ; j++){ // j = 1 and 0
		if(ending[j] == i){
			(*top)[j].child->data = (*top) + i; // j = 1 的 child 變成是 i = 8
			(*top)[starting[j]].parent[j].child = NULL; // j = 1 原本的 child 是 3 。 而 3 的 parent 沒有 j = 1 了 
			(*top)[i].parent[j].child = (*top)[j].child; // i = 8 的 parent 有 j = 1 了
			visit[j] = Unused; // j = 1 and 0 都設為 Used
		}
	}

}

void find_parent(NodePtr *top){
	while(!is_empty()){
		pop();
	}
	for(int i = 0 ; i < num ; i++){ // i = 8 
		if(visit[i] == Used){
			for(int j = 0 ; j < num ; j++){ // j = 0 and 1
				if(ending[j] == i){
					push(j);
				}
			}
			visit[i] = Cancel;
		}
	}
}

int main(){

	// input and structure the top
	if(scanf("%d", &num)){};
	for (int i = 0 ; i < num ; i++){
		if(scanf("%d", &starting[i])) {};
    	}
	for (int i = 0 ; i < num ; i++){
        	if(scanf("%d", &ending[i])){};
    	}
	
    	NodePtr top = malloc(sizeof(struct Node) * num);
    	for(int i = 0 ; i < num ; i++){
    		top[i].child = NULL;
			top[i].parent = NULL;
    	}

    	// Link the child and parent
    	for (int i = 0 ; i < num ; i++){
        	insert_child(&top , i);
    	}
    	for(int i = 0 ; i < num ; i++){
		top[i].parent = malloc(sizeof(struct Node) * num);
    		insert_parent(&top , i);
    	}

	for(int i = 0 ; i < num ; i++){
		if(starting[i] == -1){
			visit[i] = Unused;
			push(i);
		}
	}

	while(!is_empty()){
		for(int i = 0 ; i < num ; i++){
			if(top[i].child != NULL){
				middle[count][i] = top[i].child->data->id;
			}
			else{
				middle[count][i] = -1;
			}
		}
		count = count + 1;

		// 改變 i 連結為 Used
		for(int i = myindex ; i >= 0 ; i--){
			link_change(&top , stack[i]);
		}
		// 把 Used pop 且改成Cancel	Parent push 進去
		find_parent(&top);
	}
	printf("%d\n" , count);
	for(int i = 0 ; i < count ; i++){
		for(int j = 0 ; j < num - 1 ; j++){
			printf("%d " , middle[i][j]);
		}
		printf("%d\n" , middle[i][num - 1]);
	}
    
    return 0;
}
