// 14080018_2.3.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#define Maxsize 100
using namespace std;

int main()
{
	stack<char> s, t;
	char A[Maxsize];
	cin >> A;
	int i = 0, len = strlen(A);
	for (i = 0; i < len; i++)
		s.push(A[i]);
	for (i = 1; i <= len / 2; i++)
	{
		t.push(s.top());
		s.pop();
	}
	if (len % 2 == 1)
		s.pop();
	while (!s.empty()) {
		if (s.top() == t.top())
		{
			s.pop();
			t.pop();
		}
		else
		{
			cout << "不对称" << endl;
			system("pause");
			return 0;
		}
	}
	cout << "是对称的" << endl;
	system("pause");
	return 0;
}