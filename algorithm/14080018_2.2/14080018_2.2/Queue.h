#pragma once
typedef int T;
template <class  T>
// 队列
class Queue
{
private:
	// 队列中的结点结构
	struct LNode
	{
		T data; // 数据
		struct LNode *next;// 指针
	}*head,*rear;
	// 尾指针
public:
	// 初始化
	Queue() { rear = NULL; head = new LNode; head -> next = NULL; }
	// 置空队列
	void InitQueue();
	// 判断是否为空队
	bool QueueEmpty();
	// 进队
	void In(T x);
	// 出队
	void Out();
};

template <class T>
void Queue<T>::InitQueue()
{
	LNode *p;
	if (this->QueueEmpty())
		cout << "队列已为空！\n";
	else
	{
		while (rear->next != rear)
		{
			p = rear->next;
			rear->next = p->next;
			free(p);
		}
		free(rear);
		rear = NULL;
		head->next = rear;
		cout << "重置成功！" << endl;
	}
}

template <class T>
bool Queue<T>::QueueEmpty()
{
	return head -> next == NULL ? true : false;
}

template <class T>
void Queue<T>::In(T x)
{
	LNode *p;
	p = new LNode;
	if (!p)
	{
		cout << "内存分配失败!" << endl;
		exit(1);
	}
	p -> data = x;
	if(this -> QueueEmpty())
	{ 
		head -> next = p;
		rear = p;
		rear -> next = p;
	}
	else
	{
		p->next = rear->next;
		rear->next = p;
		rear = p;
	}
	cout << "入队元素为：" << x << endl;
}

template <class T>
void Queue<T>::Out()
{
	if (this->QueueEmpty())
		cout << "队列为空\n";
	else
	{	
		LNode *p;

		p = rear -> next;
		cout << "出队元素为：" << p -> data << endl;
		if (p == rear)
		{
			free(p); 
			rear = NULL;
			head->next = rear;
		}
		else
		{
			rear->next = p->next;
			free(p);
		}
		
	}
}