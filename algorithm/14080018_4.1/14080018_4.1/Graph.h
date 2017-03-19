#pragma once
#define DefaultVertices 30
#define MaxWeight 1000

using namespace std;

template <class T,class E>
class Graph
{
		
	public:
		Graph(int sz = DefaultVertices);
		~Graph() { delete[]VerticesList; delete[] Edge; }
		T GetValue(int i) { return i >= 0 && i <= NumVertices ? VerticesList[i] : NULL; }
		E GetWeight(int v1, int v2) { return v1 != -1 && v2 != -1 ? Edge[v1][v2] : 0; }
		int GetFirstNeighbor(int);
		int GetNextNeighbor(int, int);
		bool InsertVertex(const T& vertex);
		bool InsertEdge(int, int, E);
		bool RemoveVertex(int);
		bool RemoveEdge(int, int);
		int NumberOfVertices() { return NumVertices; }
		int NumberOfEdges() { return NumEdges; }
		int GetVertexPos(T vertex)
		{
			for (int i = 0; i < NumVertices; i++)
				if (VerticesList[i] == vertex)
					return i;
			return -1;
		}
		void Input();
		void Output();
	private:
		int MaxVertices;
		int NumEdges;
		int NumVertices;
		T* VerticesList;
		E** Edge;
};

template<class T,class E>
Graph<T, E>::Graph(int sz)
{
	MaxVertices = sz;
	NumVertices = 0;
	NumEdges = 0;
	int i, j;
	VerticesList = new T[MaxVertices];
	Edge = (E**)new E*[MaxVertices];
	for (i = 0; i < MaxVertices; i++)
		Edge[i] = new E[MaxVertices];
	for (i = 0; i < MaxVertices; i++)
		for (j = 0; j < MaxVertices; j++)
			Edge[i][j] = (i == j) ? 0 : MaxWeight;
}

template<class T, class E>
int Graph<T, E>::GetFirstNeighbor(int v)
{
	if (v != -1)
	{
		for (int col = 0; col < NumVertices; col++)
			if (Edge[v][col]>0 && Edge[v][col] < MaxWeight)
			return col;
	}
	return -1;
}

template<class T,class E>
int Graph<T, E>::GetNextNeighbor(int v, int w)
{
	if (v != -1 && w != -1)
	{
		for (int col = w + 1; col < NumVertices; col++)
			if (Edge[v][col]>0 && Edge[v][col] < MaxWeight)
				return col;
	}
	return -1;
}

template<class T,class E>
bool Graph<T, E>::InsertVertex(const T& vertex)
{
	if (NumVertices == MaxVertices)
		return false;
	VerticesList[NumVertices++] = vertex;
	return true;
}

template<class T,class E>
bool Graph<T, E>::RemoveVertex(int v)
{
	if (v < 0 || v >= NumVertices)
		return false;
	if (NumVertices == 1)
		return false;
	int i, j;
	VerticesList[v] = VerticesList[NumVertices - 1];
	NumVertices--;
	for (j = 0; j < NumVertices; j++)
		Edge[v][j] = Edge[NumVertices][j];
	return true;
}

template<class T,class E>
bool Graph<T, E>::InsertEdge(int v1, int v2, E cost)
{
	if (v1 > -1 && v1 < NumVertices && v2 > -1 && v2 < NumVertices && Edge[v1][v2] == MaxWeight)
	{
		Edge[v1][v2] = Edge[v2][v1] = cost;
		NumEdges++;
		return true;
	}
	else return false;
}

template<class T, class E>
bool Graph<T, E>::RemoveEdge(int v1, int v2)
{
	if (v1 > -1 && v1 < NumVertices && v2 > -1 && v2 < NumVertices && Edge[v1][v2] < MaxWeight && Edge[v1][v2] > 0)
	{
		Edge[v1][v2] = Edge[v2][v1] = MaxWeight;
		NumEdges--;
		return true;
	}
	else return false;
}

template<class T, class E>
void Graph<T, E>::Input()
{
	int i, j, k, n, m;
	T e1, e2;
	E weight;
	cout << "请输入顶点数：";
	cin >> n;
	cout << "请输入边数：";
	cin >> m;
	for (i = 0; i < n; i++)
	{
		cout << "第" << i + 1 << "个顶点：";
		cin >> e1;
		InsertVertex(e1);
	}
	i = 0;
	while (i < m)
	{
		cout << "请输入两个端点名称：";
		cin >> e1 >> e2;
		cout << "请输入这两个端点之间的距离：";
		cin >> weight;
		j = GetVertexPos(e1);
		k = GetVertexPos(e2);
		if (j == -1 || k == -1)
		{
			cout << "边两端点信息有误，请重新输入！" << endl;
		}
		else
		{
			InsertEdge(j, k, weight);
			i++;
		}
	}
	cout << "输入成功！" << endl;
};

template <class T, class E>
void Graph<T, E>::Output()
{
	int i, j, n, m;
	T e1, e2;
	E w;
	n = NumberOfVertices();
	m = NumberOfEdges();
	cout << "顶点数为：" << n << endl << "边数为：" << m << endl;
	for (i = 0; i < n; i++)
		for (j = i + 1; j < n; j++)
		{
			w = GetWeight(i, j);
			if (w > 0 && w < maxWeight)
			{
				e1 = GetValue(i);
				e2 = GetValue(j);
				cout << "(" << e1 << "," << e2 << "," << w << ")" << endl;
			}
		}
};