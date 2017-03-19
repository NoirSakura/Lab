//MyStack.h
#include "stdafx.h"
#define MAXSIZE 100
using namespace std;

template <class ElemType> class MyStack
{
public:
	ElemType data[MAXSIZE];
	int top;

public:
	void init();            // 初始化栈
	bool empty();            // 判断栈是否为空
	ElemType gettop();        // 读取栈顶元素(不出栈)
	void push(ElemType x);    // 进栈
	ElemType pop();            // 出栈
};


template<class T> void MyStack<T>::init()
{
	this->top = 0;
}

template<class T> bool MyStack<T>::empty()
{
	return this->top == 0 ? true : false;
}

template<class T> T MyStack<T>::gettop()
{
	if (empty())
	{
		cout << "栈为空！\n";
		exit(1);
	}
	return this->data[this->top - 1];
}

template<class T> void MyStack<T>::push(T x)
{
	if (this->top == MAXSIZE)
	{
		cout << "栈已满！\n";
		exit(1);
	}
	this->data[this->top] = x;
	this->top++;
}

template<class T> T MyStack<T>::pop()
{
	if (this->empty())
	{
		cout << "栈为空! \n";
		exit(1);
	}

	T e = this->data[this->top - 1];
	this->top--;
	return e;
}


bool isoperator(char op)
{
	switch (op)
	{
	case '+':
	case '-':
	case '*':
	case '/':
	case '%':
		return 1;
	default:
		return 0;
	}
}


int priority(char op)
{
	switch (op)
	{
	case '#':
		return -1;
	case '(':
		return 0;
	case '+':
	case '-':
		return 1;
	case '*':
	case '/':
	case '%':
		return 2;
	default:
		return -1;
	}
}

//     把中缀表达式转换为后缀表达式，返回后缀表达式的长度（包括空格）
void postfix(char pre[], char post[], int &n)
{
	int i = 0, j = 0;
	MyStack<char> stack;
	stack.init();        // 初始化存储操作符的栈

	stack.push('#');    // 首先把结束标志‘#’放入栈底

	while (pre[i] != '#')
	{
		if ((pre[i] >= '0' && pre[i] <= '9') || pre[i] == '.') // 遇到数字和小数点直接写入后缀表达式
		{
			post[j++] = pre[i];
			n++;
		}
		else if (pre[i] == '(')    // 遇到“（”不用比较直接入栈
			stack.push(pre[i]);
		else if (pre[i] == ')')  // 遇到右括号将其对应左括号后的操作符（操作符栈中的）全部写入后缀表达式
		{
			while (stack.gettop() != '(')
			{
				post[j++] = stack.pop();
				n++;
			}
			stack.pop(); // 将“（”出栈，后缀表达式中不含小括号
		}
		else if (isoperator(pre[i]))
		{
			while (priority(pre[i]) <= priority(stack.gettop()))
			{
				// 当前的操作符小于等于栈顶操作符的优先级时，将栈顶操作符写入到后缀表达式，重复此过程
				post[j++] = stack.pop();
				n++;
			}

			stack.push(pre[i]);    // 当前操作符优先级大于栈顶操作符的优先级，将该操作符入栈
		}

		i++;
	}
	while (stack.top) // 将所有的操作符加入后缀表达式
	{
		post[j++] = stack.pop();
		n++;
	}
}

int main()
{
	char exp[100];
	cout << "输入表达式(中缀，以#结束)：";
	cin >> exp;
	char post[100];
	int n = 0;           
	postfix(exp, post, n);
	cout << "后缀表达式为：";
	for (int i = 0; i < n - 1; i++)
		cout << post[i];
	cout << endl;
	system("pause");
	return 0;
}
