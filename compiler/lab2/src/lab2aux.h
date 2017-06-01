#include <malloc.h>  
#include <string.h>  
#include <stdio.h>  
#include <stdlib.h>

#define QUEUE_INIT_SIZE 10
#define OVERFLOW        -1  
#define OK				0
#define FULL			1
  
// Symbol Table
enum SYMBOL {
	SYMBOL_IF = 1,
	SYMBOL_THEN,
	SYMBOL_ELSE,
	SYMBOL_WHILE,
	SYMBOL_DO,
	SYMBOL_INT10,
	SYMBOL_INT8,
	SYMBOL_INT16,
	SYMBOL_IDN,
	SYMBOL_SEM,
	SYMBOL_EQUAL,
	SYMBOL_LT,
	SYMBOL_GT,
	SYMBOL_PLUS,
	SYMBOL_MINUS,
	SYMBOL_MULTI,
	SYMBOL_DIV,
	SYMBOL_L_BRACKET,
	SYMBOL_R_BRACKET
};

// Global Used Node *root
struct Node{
	char *data;
	char *expr;
	struct Node** child;
	int child_num;
};
  
// Queue define
typedef struct SqQueue {  	
	struct Node** data; 
    int head;  
    int tail;
	int length;
}Queue;  

// Initialize
int initQueue(Queue *queue);
// Destroy
int destroyQueue(Queue *queue);
// Clear
int clearQueue(Queue *queue);
// Queue in
int push(Queue *queue, struct Node* node);
// Queue out
struct Node* pop(Queue *queue);