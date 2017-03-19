// 14080018_5.2.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
using namespace std;
template <class T>
struct LinkNode
{
	T data;
	LinkNode* next;
};

template<class T>
T Search(LinkNode<T>* Node, T key)
{
	LinkNode<T>*p;
	int n = 0;
	for (p = Node; p->next != NULL; p = p->next)
	{
		n++;
		if (p->data == key)
			return n;
	}
	return 0;
}

int main()
{	
	LinkNode<int> *Head, *p, *q;
	Head = new LinkNode<int>;
	Head->next = NULL;
	p = Head;
	int n, key;
	cout << "请输入数字个数：";
	cin >> n;
	cout << "请分别输入数字（升序）：";
	cin >> Head->data;
	for (int i = 2; i <= n;i++)
	{
		q = new LinkNode<int>;
		cin >> q->data;
		p->next = q;
		q->next = NULL;
		p = q;
	}
	cout << "请输入关键词：";
	cin >> key;
	if (Search(Head, key))
		cout << "找到！在第"<<Search(Head,key)<<"个节点。\n";
	else cout << "未找到！\n";
    return 0;
}

