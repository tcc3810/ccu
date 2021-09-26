#include <stdio.h>
#include <stdlib.h>
#define Maxterm 20
#define True 1
#define False 0

typedef struct Node* NodePtr;
typedef struct ListNode* ListNodePtr;
struct Node{
    int id;
    ListNodePtr child; // 指標
    NodePtr parent; // 陣列
};
struct ListNode{
    NodePtr data; // 指標
    ListNodePtr next; // 指標
};
int num = 0;
int count = 0;
int starting[Maxterm];
int ending[Maxterm];
int visit[Maxterm] = {False};

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
	 // (*top)[i].parent = malloc(sizeof(struct Node) * num);
	for(int j = 0 ; j < num ; j++){
		(*top)[i].parent[j].id = j;
		if(starting[j] == i){ // i child , j parent	 ex: i = 4 , j = 2
			(*top)[i].parent[j].child = (*top)[j].child; // ListNodePtr = ListNodePtr | (*top)[i] struct Node
			(*top)[i].parent[j].parent = (*top)[j].parent; // NodePtr = NodePtr | (*top)[j] struct Node
		}
	}
}
/*
void link_change(NodePtr *top , int i){ // i = 4	Node 3 : 2 to 4		Node 2 : 4 to 3
	for(int j = 0 ; j < num ; j++){
		if((*top)[i].parent[j] != NULL && (*top)[i].parent[j] != NULL){
			(*top)[(*top)[i].parent.parent.id].child.data = (*top)[(*top)[i].parent].child.data;
			(*top)[(*top)[i].parent.id].child.data = (*top)[(*top)[i].parent.parent.id].child.data;
			//visit[(*top)[i].parent.parent.id] = True;
			//visit[(*top)[i].parent.id] = True;
		}
	}
}
*/
void link_change(NodePtr *top , int i){ 
	for(int j = 0 ; j < num ; j++){
		if(ending[i] == j && visit[j] == True){// i = 0 j = 8
			(*top)[i].child->data = (*top) + j; // i 的 child 變 j
			(*top)[j].parent[i].child = (*top)[i].child; // j 的 parent 要加上 i
			(*top)[i].parent[i].child = NULL; // i 的 parent 要去掉 i
			visit[i] = True;
		}
	}
}
int map(NodePtr *top){
	int cnt = 0;
	for(int i = 0 ; i < num ; i++){
		if(visit[i] == True){
			cnt = cnt + 1;
		}
	}
	return cnt;
}

int main(){
    // input and structure the top
    scanf("%d", &num);
    for (int i = 0 ; i < num ; i++){
        scanf("%d", &starting[i]);
    }
    for (int i = 0 ; i < num ; i++){
        scanf("%d", &ending[i]);
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
    	if(starting[i] == ending[i]){
		visit[i] = True;
	}
    }
    // visit要全為True
    while(count != num){
    	for(int i = 0 ; i < num ; i++){
    		link_change(&top , i);
    	}
	count = map(&top);
    }

    // 測試印出結果
    printf("visit\t: ");
    for(int i = 0 ; i < num ; i++){
    	printf("%d\t" , visit[i]);
    }
    printf("\nNode\t: ");
    for (int i = 0 ; i < num ; i++){
        printf("%d\t" , top[i].id);
    }
    printf("\nTo\t: ");
    for (int i = 0 ; i < num ; i++){
	if(top[i].child != NULL)
        	printf("%d\t" , top[i].child->data->id);
	else
		printf("-1\t");
    }
    
    printf("\nParent: \n");
    for (int i = 0 ; i < num ; i++){
	    printf("Node %d :\t" , i);
	    for(int j = 0 ; j < num ; j++){
	    	if(top[i].parent[j].child != NULL){
        		printf("%d\t" , top[i].parent[j].id);	
		}
	    }
	    printf("\n");
    }
    for (int i = 0 ; i < num ; i++){
	printf("\nNode %d->" , i);
        ListNodePtr x = top[i].child;
	while(x){
        	NodePtr y = x->data;
        	printf("%d->" , y->id);
		x = x->next;
	}
    }
    printf("\n");
    // 測試印出結果
    return 0;
}
