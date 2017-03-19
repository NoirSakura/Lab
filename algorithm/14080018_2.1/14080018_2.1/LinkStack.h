#pragma once
template <class  T>
// 链式栈
class LinkStack
{
private:
	// 链式栈s中的结点结构
	struct LNode
	{
		T data; // 数据
		struct LNode *next;// 指针
	}*top;
	// 栈顶/栈底指针
public:
	// 初始化
	LinkStack() { top = NULL; }
	// 置空栈
	void InitStack();
	// 判断是否为空栈
	bool StackEmpty();
	// 进栈
	void Push(T x);
	// 出栈
	void Pop();
	// 取栈顶元素
	void GetTop();
};

template <class T>
void LinkStack<T>::InitStack()
{
	if (this->StackEmpty())
		cout << "栈已为空！\n";
	else
	{
		LNode *p;
		while (top)
		{
			p = top;
			top = top->next;
			free(p);
		}
		cout << "重置成功！\n";
	}
}

template <class T>
bool LinkStack<T>::StackEmpty()
{
	return top == NULL ? true : false;
}

template <class T>
void LinkStack<T>::Push(T x)
{
	LNode *p;
	p = new LNode;
	if (!p)
	{
		cout << "内存分配失败!" << endl;
		exit(1);
	}
	p->data = x;
	p->next = top;
	top = p;
	cout << "入栈元素为：" << x << endl;
}

template <class T>
void LinkStack<T>::Pop()
{
	if (this->StackEmpty())
		cout << "栈为空\n";
	else
	{
		LNode *p;
		p = top;
		cout << "出栈元素为：" << top->data << endl;
		top = top->next;
		free(p);
	}
}

template<class T>
void LinkStack<T> ::GetTop()
{
	if (this->StackEmpty())
		cout << "栈为空\n";
	else cout << "栈顶元素为：" << top->data << endl;
}