// 14080018_5.3.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
using namespace std;

int Hash(int x)
{
	return x/2;
}
struct HashNode
{
	int Address;
	HashNode* Next;
	HashNode* Parallel;
};

int main()
{
	HashNode *HashTable, *p,*q;
	HashTable = new HashNode{ -1,NULL,NULL };
	srand(time(0));
	int number,flag;
	for (int i = 1; i <= 12000; i++)
	{
		flag = 0;
		p = HashTable;
		number = Hash(rand() % 20000);
		if (HashTable->Next == NULL)
		{
			p = new	HashNode{ number,NULL,NULL };
			HashTable->Next = p;
		}
		else 
		{
			while (p->Next != NULL && p->Next->Address <= number)
			{
				if (p->Address == number)
				{
					q = new HashNode{ number,NULL,NULL };
					p->Parallel = q;
					flag = 1;
					break;
				}
				else if(p->Next->Address == number)
				{
					q = new HashNode{ number,NULL,NULL };
					p->Next->Parallel = q;
					flag = 1;
					break;
				}
				p = p->Next;
			}
			if (!flag)
			{
				q = new HashNode{ number,p->Next,NULL };
				p->Next = q;
			}
		}
	}
    return 0;
}

