// 14080018_2.2.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include "Queue.h"
using namespace std;

template <class T>
void menu(Queue<T>& s)
{
	system("cls");
	int choice;
	cout << "请输入您的选择：\n";
	cout << "1.置队空\n";
	cout << "2.入队\n";
	cout << "3.出队\n";
	cout << "0.退出\n";
	cin >> choice;
	system("cls");
	switch (choice)
	{
	case 1:
		s.InitQueue();
		system("pause");
		menu(s);
		break;
	case 2:
		int x;
		cin >> x;
		s.In(x);
		system("pause");
		menu(s);
		break;
	case 3:
		s.Out();
		system("pause");
		menu(s);
		break;
	case 0:
		exit(0);
		break;
	default:
		cout << "输入错误！\n";
		system("pause");
		menu(s);
	}
}

int main()
{
	Queue<T> s;
	menu(s);
    return 0;
}

