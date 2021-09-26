#include <stdio.h>
#include <stdlib.h>
#include <string.h>
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
NodePtr top[Maxterm];

void insert(NodePtr item , int i){
    ListNodePtr temp = malloc(sizeof(struct ListNode));
    temp->data = item;
    temp->next = NULL;
    top[i]->child = temp;

}
int main(){
    scanf("%d", &num);
    for (int i = 0 ; i < num ; i++){
        scanf("%d", &starting[i]);
    }
    for (int i = 0 ; i < num ; i++){
        top[i]->id = i;
        insert(top , i);
    }
    for (int i = 0 ; i < num ; i++){
        printf("%d, " , top[i].id);
        ListNodePtr x = top[i].child;
        NodePtr y = x->data;
        printf("%d. " , y->id);
    }
    return 0;
}
// void insert(NodePtr *first , int i){
//     while(starting[i] != -1){
//         ListNodePtr tmp = malloc(sizeof(struct ListNode));
//         tmp->data = starting[i];
//         ListNodePtr pre , p = *first->child;
//         while(p){
//             pre = p;
//             p = pre->next;
//         }
//         if(*first){
//             tmp->next = pre->next;
//             pre->next = tmp;
//         }
//         else{
//             tmp->next = NULL;
//             *first = tmp;
//         }
//         i = starting[i];
//     }
// }