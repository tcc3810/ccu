#include <stdio.h>
#include <stdlib.h>
#define Maxterm 20
typedef struct Node* NodePtr;
typedef struct ListNode* ListNodePtr;
struct Node{
    int id;
    ListNodePtr child;
    NodePtr parent;
};
struct ListNode{
    NodePtr data;
    ListNodePtr next;
};
int num = 0;
int starting[Maxterm];

void insert_child(NodePtr *top , int i){
	top[i]->id = i;

	if(starting[i] == -1){
		return;
	}
	
	ListNodePtr first = malloc(sizeof(struct ListNode));
	first->data = malloc(sizeof(struct Node));

	first->data = top[starting[i]];
	first->next = NULL;
	top[i]->child = first;


	int j = starting[i];
	if(j == -1)
		return;
	while(starting[j] != -1){
		ListNodePtr tmp = malloc(sizeof(struct ListNode));
		tmp->data = malloc(sizeof(struct Node));

		tmp->data = top[starting[j]];
		tmp->next = NULL;
		first->next = tmp;

		first = tmp;
		j = starting[j];
	}
}
int main(){
    scanf("%d", &num);
    for (int i = 0 ; i < num ; i++){
        scanf("%d", &starting[i]);
    }
    NodePtr top[num];
    for(int i = 0 ; i < num ; i++){
    	top[i] = malloc(sizeof(struct Node));
    	top[i]->child = NULL;
	top[i]->parent = NULL;
    }
    
    // 輸入Node
    for (int i = 0 ; i < num ; i++){
        insert_child(top , i);

	for(int j = 0 ; j < num ; j++){
		if(j == starting[i]){
			top[j]->parent = top[i];
		}
	}

    }
    
    // 測試印出結果
    printf("Node\t: ");
    for (int i = 0 ; i < num ; i++){
        printf("%d,\t" , top[i]->id);
    }
    printf("\nTo\t: ");
    for (int i = 0 ; i < num ; i++){
	if(top[i]->child != NULL)
        	printf("%d,\t" , top[i]->child->data->id);
	else
		printf("-1,\t");
    }
    printf("\nParent\t: ");
    for (int i = 0 ; i < num ; i++){
	if(top[i]->parent != NULL)
        	printf("%d,\t" , top[i]->parent->id);
	else
		printf("-1,\t");
    }
    printf("\n");

    for (int i = 0 ; i < num ; i++){
	printf("Node %d-> " , i);
        ListNodePtr x = top[i]->child;
	while(x){
        	NodePtr y = x->data;
        	printf("%d-> " , y->id);
		x = x->next;
	}
	printf("\n");
    }
    // 測試印出結果
    return 0;
}
