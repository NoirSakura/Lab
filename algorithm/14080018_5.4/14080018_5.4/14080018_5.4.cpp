// 14080018_5.4.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"

using namespace std;
typedef struct _NODE
{
	int value;
	struct _NODE *left;
	struct _NODE *right;

	_NODE(int value) : value(value), left(NULL), right(NULL) {};
}NODE, *PTRNODE;
void insert(PTRNODE &root, int value)
{
	if (root == NULL)
		root = new NODE(value);
	else
	{
		if (value < root->value)
			insert(root->left, value);
		else if (value > root->value)
			insert(root->right, value);
		else
			cout << "错误值！" << endl;
	}
}
void preOrder(PTRNODE root)
{
	if (root != NULL)
	{
		cout << root->value << "->";
		preOrder(root->left);
		preOrder(root->right);
	}
}
void inOrder(PTRNODE root)
{
	if (root != NULL)
	{
		inOrder(root->left);
		cout << root->value << "->";
		inOrder(root->right);
	}
}
void postOrder(PTRNODE root)
{
	if (root != NULL)
	{
		inOrder(root->left);
		inOrder(root->right);
		cout << root->value << "->";
	}
}
void clear(PTRNODE &root)
{
	if (root != NULL)
	{
		clear(root->left);
		clear(root->right);

		delete root;
		root = NULL;
	}
}
void Search(PTRNODE root, int searchVal)
{
	if (root == NULL)
	{
		cout << "未找到！ " << endl;
		return;
	}

	if (searchVal < root->value)
		Search(root->left, searchVal);
	else if (searchVal > root->value)
		Search(root->right, searchVal);
	else
		cout << "找到！" << endl;
}
int main(int argc, char *argv[])
{
	PTRNODE root = NULL;

	cout << "生成的结点为： " << endl;
	srand(time(0));
	for (int i = 0; i<10; i++)
	{
		int value = rand() % 100;
		cout << value << " ";

		insert(root, value);
	}

	cout << endl;

	cout << "前序遍历: " << endl;
	preOrder(root);
	cout << endl;

	cout << "中序遍历: " << endl;
	inOrder(root);
	cout << endl;

	cout << "前序遍历: " << endl;
	postOrder(root);
	cout << endl;

	cout << "请输入关键词: ";
	int searchVal;
	cin >> searchVal;
	Search(root, searchVal);

	clear(root);

	return 0;
}