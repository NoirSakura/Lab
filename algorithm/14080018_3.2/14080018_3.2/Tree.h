#pragma once
#include <stack>
#define MaxSize 100
using namespace std;
typedef char ElemType;

class Tree
{
	private:
		struct BTNode
		{
			ElemType data;
			BTNode *lchild;
			BTNode *rchild;
			int ltag;
			int rtag;
		}*root,*pre,*BTHNode;
	public:
		Tree(char *str)
		{
			pre = NULL;
			BTNode *St[MaxSize], *P = NULL;
			int top = -1, k, j = 0;
			char ch;
			ch = str[j];
			//初始化的二叉链为空
			root = NULL;
			for (j = 0; str[j] != '\0'; j++)
			{
				ch = str[j];
				switch (ch)
				{
					//作为左结点
				case '(':
					top++;
					St[top] = P;
					k = 1;
					break;
				case ')':
					top--;
					break;
					//作为右结点
				case ',':
					k = 2;
					break;
				default:
					P = new BTNode;
					P->data = ch;
					P->lchild = P->rchild = NULL;
					P->ltag = P->rtag = 0;
					if (root == NULL)
					{
						// p指向二叉树的根结点
						root = P;
					}
					else
					{
						switch (k)
						{
						case 1:
							St[top]->lchild = P;
							break;
						case 2:
							St[top]->rchild = P;
							break;
						}
					}
				}
			}
		}
		BTNode* GetRoot() { return root; }
		void NumOfNode(BTNode *b, int& n)
		{
			if (b->lchild != NULL)
				NumOfNode(b->lchild, n);
			n++;
			if (b->rchild != NULL)
				NumOfNode(b->rchild, n);
		}
		void In_Rec(BTNode *b)
		{
			{
				if (b->lchild != NULL)
					In_Rec(b->lchild);
				cout << b->data;
				if (b->rchild != NULL)
					In_Rec(b->rchild);
			}
		}
		void In(BTNode *b)
		{
			stack<BTNode*> s;
			BTNode *p = b;
			while (p != NULL || !s.empty())
			{
				while (p != NULL)
				{
					s.push(p);
					p = p->lchild;
				}
				if (!s.empty())
				{
					p = s.top();
					cout << p->data;
					s.pop();
					p = p->rchild;
				}
			}
		}
		void InThread(BTNode* p)
		{
			if (p != NULL)
			{
				if (p->ltag == 0)
					InThread(p->lchild);
				if (p->lchild == NULL)
				{
					p->ltag = 1;
					p->lchild = pre;
				}
				if (p->rchild == NULL)
					p->rtag = 1;
				if (pre != NULL && pre->rtag == 1)
					pre->rchild = p;
				pre = p;
				if (p->rtag == 0)
					InThread(p->rchild);
			}
		}
		void In_Thread(BTNode* p)
		{
			if (p->ltag != 1)
				In_Thread(p->lchild);
			cout << p->data;
			if (p->rtag != 1)
				In_Thread(p->rchild);
		}
};