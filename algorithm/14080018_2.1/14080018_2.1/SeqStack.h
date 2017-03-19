#pragma once 
#define StackSize 5
typedef int T;
template <class  T>
// 顺序栈
class SeqStack
{
	private:
		// 栈内存储数据
		T data[StackSize];
		// 栈顶指针
		int top;
	public:
		// 初始化
		SeqStack() { top = -1; }
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
void SeqStack<T>::InitStack()
{
	if (this->StackEmpty())
		cout << "栈已为空！\n";
	else
	{
		top = -1;
		cout << "重置成功！\n" ;
	}
}

template <class T>
bool SeqStack<T>::StackEmpty()
{
	return top == -1 ? true : false;
}

template <class T>
void SeqStack<T>:: Push(T x)
{
	if (top == StackSize - 1) cout << "上溢" << endl;
	else
	{
		cout << "入栈元素为：" << x << endl;
		data[++top] = x;
	}
}

template <class T>
void SeqStack<T>::Pop() 
{
	if (this->StackEmpty()) cout << "下溢\n";
	else cout << "出栈元素为：" << data[top--] <<  endl;
}

template <class T>
void SeqStack<T>::GetTop()
{
	if (this->StackEmpty()) cout << "栈为空\n";
	else cout << data[top] << endl;
}
