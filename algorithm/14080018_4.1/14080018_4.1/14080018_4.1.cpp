// 14080018_4.1.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include "Graph.h"
#include "seqQueue.h"

template <class T, class E>
void BFS(Graph<T, E>& G, const T& v)
{
	int i, w, n = G.NumberOfVertices();
	bool *visited = new bool[n];
	for (i = 0; i < n; i++) visited[i] = false;
	int loc = G.GetVertexPos(v);
	cout << G.GetValue(loc) << ' ';
	visited[loc] = true;
	SeqQueue<int> Q;
	Q.EnQueue(loc);
	while (!Q.IsEmpty())
	{
		Q.DeQueue(loc);
		w = G.GetFirstNeighbor(loc);
		while (w != -1)
		{
			if (visited[w] == false)
			{
				cout << G.GetValue(w) << ' ';
				visited[w] = true;
				Q.EnQueue(w);
			}
			w = G.GetNextNeighbor(loc, w);
		}
	}
	delete[]visited;
};

template <class T, class E>
void DFS(Graph<T, E> &G, const T& v)
{
	int i, loc, n = G.NumberOfVertices();
	bool *visited = new bool[n];
	for (i = 0; i < n; i++)visited[i] = false;
	loc = G.GetVertexPos(v);
	DFS(G, loc, visited);
	delete[]visited;
};

template <class T, class E>
void DFS(Graph<T, E>& G, int v, bool visited[])
{
	cout << G.GetValue(v) << ' ';
	visited[v] = true;
	int w = G.GetFirstNeighbor(v);
	while (w != -1)
	{
		if (visited[w] == false) DFS(G, w, visited);
		w = G.GetNextNeighbor(v, w);
	}
};

int main()
{
	char c;
	Graph<char, int> G(20);
	G.Input();
	do
	{
		cout << "请输入遍历的起点：";
		cin >> c;
		cout << "广度优先搜索：";
		BFS<char, int>(G, c);
		cout << endl;
		cout << "深度优先搜索：";
		DFS<char, int>(G, c);
		cout << endl;
	} while (c != '#');
	return 0;
}


