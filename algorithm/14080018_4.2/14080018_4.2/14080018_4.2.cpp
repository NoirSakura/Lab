// 14080018_4.2.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
using namespace std;
#include "Graph.h"



int main()
{
	Graph<char, int> G(20);
	G.Input();
	cout << "最小权为:" << G.Prim() << endl;
    return 0;
}

