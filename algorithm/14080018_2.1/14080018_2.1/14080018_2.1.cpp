// 14080018_2.1.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include "SeqStack.h"
#include "LinkStack.h"
using namespace std;

template <class T>
void main_menu()
{
	int choice;
	do
	{
		cout << "请输入您的选择：\n";
		cout << "1.创建顺序栈\n";
		cout << "2.创建链式栈\n";
		cout << "0.结束程序\n";
		cin >> choice;
		if (choice == 1)
		{
			SeqStack<T> s;
			menu(s);
		}
		else if (choice == 2)
		{
			LinkStack<T> s;
			menu(s);
		}
		else if(choice != 0)
		{
			system("cls");
			cout << "输入错误！\n";
			system("pause");
			system("cls");
		}
	} while (choice != 0);
	exit(0);
}

template <class T>
void menu(SeqStack<T>& s)
{
	system("cls");
	int choice;
	cout << "请输入您的选择：\n";
	cout << "1.置空栈\n";
	cout << "2.入栈\n";
	cout << "3.出栈\n";
	cout << "4.查看栈顶元素\n";
	cout << "0.返回上层\n";
	cin >> choice;
	system("cls");
	switch (choice)
	{
		case 1:
			s.InitStack();
			system("pause");
			menu(s);
			break;
		case 2:
			int x;
			cin >> x;
			s.Push(x); 
			system("pause");
			menu(s);
			break;
		case 3:
			s.Pop();
			system("pause");
			menu(s);
			break;
		case 4:
			s.GetTop();
			system("pause");
			menu(s);
			break;
		case 0:
			return;
			break;
		default:
			cout << "输入错误！\n";
			system("pause");
			menu(s);
	}
}

template <class T>
void menu(LinkStack<T>& s)
{
	system("cls");
	int choice;
	cout << "请输入您的选择：\n";
	cout << "1.置空栈\n";
	cout << "2.入栈\n";
	cout << "3.出栈\n";
	cout << "4.查看栈顶元素\n";
	cout << "0.返回上层\n";
	cin >> choice;
	system("cls");
	switch (choice)
	{
		case 1:
			s.InitStack();
			system("pause");
			menu(s);
			break;
		case 2:
			int x;
			cin >> x;
			s.Push(x);
			system("pause");
			menu(s);
			break;
		case 3:
			s.Pop();
			system("pause");
			menu(s);
			break;
		case 4:
			s.GetTop();
			system("pause");
			menu(s);
			break;
		case 0:
			return;
			break;
		default:
			cout << "输入错误！\n";
			system("pause");
			menu(s);
	}
}

int main()
{
	main_menu<T>();
}



