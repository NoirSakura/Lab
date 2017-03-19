#pragma once
using namespace std;
#define Maxsize 100

class Huffman
{
	private:
		struct HufNode
		{
			char data;
			int number;
			int flag;
			HufNode* lchild;
			HufNode* rchild;
		}*root,*Nodes[Maxsize],*left,*right;
		int size;
	public:
		Huffman(char* str)
		{
			size = 0;
			int i,j,m1,m2;
			char pre = '\0', flag = 0;
			for (i = 0; str[i] != '\0'; i++)
			{
				pre = str[i];
				for (j = 0; j < size; j++)
				{
					if (Nodes[j]->data == pre)
					{
						flag = 1;
						Nodes[j]->number++;
					}
				}
				if (!flag)
				{
					Nodes[size] = new HufNode;
					Nodes[size]->data = pre;
					Nodes[size]->number = 1;
					Nodes[size]->flag = 0;
					Nodes[size]->lchild = NULL;
					Nodes[size++]->rchild = NULL;
				}
				flag = 0;
			}
			for (j = 0; j < size; j++)
				for (int k = j; k < size - 1; k++)
				{
					if (Nodes[k]->number > Nodes[k+1]->number)
					{
						root = Nodes[k];
						Nodes[k] = Nodes[k + 1];
						Nodes[k + 1] = root;
					}
				}
			for (i = size; i < 2 * size - 1; i++)
			{
				Nodes[i] = new HufNode;
				Nodes[i]->number = 0;
				Nodes[i]->data = '^';
				Nodes[i]->flag = 0;
				Nodes[i]->lchild = NULL;
				Nodes[i]->rchild = NULL;
			}
			for (i = 0; i < size - 1; i++)
			{
				m1 = m2 = Maxsize;

				for (j = i; j < size + i; j++)
				{
					if (Nodes[j]->number < m1 && Nodes[j]->flag == 0)
					{
						m2 = m1;
						right = left;
						m1 = Nodes[j]->number;
						left = Nodes[j];
					}
					else if (Nodes[j]->number < m2 && Nodes[j]->flag == 0)
					{
						m2 = Nodes[j]->number;
						right = Nodes[j];
					}
				}
				left->flag = 1;
				right->flag = 1;
				Nodes[size + i]->number = left->number + right->number;
				Nodes[size + i]->lchild = left;
				Nodes[size + i]->rchild = right;
			}
			root = Nodes[2 * size - 2];
		}
		HufNode* GetRoot() { return root; }
		void Code(string k,HufNode* Node)
		{
			if (Node->data != '^')
			{
				cout << Node->data << ":" << k << endl;
			}
			else
			{
				Code(k + '0', Node->lchild);
				Code(k + '1', Node->rchild);
			}
		}
		void Decode(char* str)
		{
			HufNode* p = root;
 			for (int i = 0; str[i] != '\0'; i++)
			{
				if (str[i] == '0')
					p = p->lchild;
				else p = p->rchild;
				if (p->data != '^')
				{
					cout << p->data;
					p = root;
				}
			}
			cout << endl;
		}
};