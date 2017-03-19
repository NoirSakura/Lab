#include "stdafx.h"
using namespace std;
typedef char TElemType;
typedef struct Node 
{
	TElemType data;
	struct Node *lchild, *rchild;
}BinaryTreeN, *BinaryTree;
int CreateBinaryTree(BinaryTree  &T) 
{
	//按前序遍历规则创建二叉树，请输入结点
	//（不存在的结点用*代替），如"AB*DG***CEM**N**F*X**"
	char ch;
	getchar();
	cout << "\n请输入二叉树的元素\n";
	cin >> ch;
	if (ch == '*')
		T = NULL;
	else 
	{
		if (!(T = (BinaryTreeN *)malloc(sizeof(BinaryTreeN)))) 
			exit(-1);
		T->data = ch;
		CreateBinaryTree(T->lchild);
		CreateBinaryTree(T->rchild);
	}
	return 1;
}//创建二叉树
int PreOrderT(BinaryTree  T) 
{
	//前序遍历二叉树 T：打印每个结点的数据域一次且仅一次
	if (T != NULL) 
	{
		cout << T->data << " \n";
		PreOrderT(T->lchild);
		PreOrderT(T->rchild);
	}
	return 1;
}//先序遍历二叉树
int InOrderT(BinaryTree  T) 
{
	//后序遍历二叉树 T：打印每个结点的数据域一次且仅一次
	if (T != NULL) 
	{
		InOrderT(T->lchild);
		cout << T->data << " \n";
		InOrderT(T->rchild);
	}
	return 1;
}//中序遍历二叉树 T

int PostOrderT(BinaryTree  T) {
	//后序遍历二叉树 T：打印每个结点的数据域一次且仅一次
	if (T != NULL) {
		PostOrderT(T->lchild);
		PostOrderT(T->rchild);
		cout << T->data << " \n";
	}
	return 1;
}//后序遍历二叉树 T

int BinaryTreenum(BinaryTree T, int& n) {
	// 编写算法统计二叉树T(二叉链表存储结构)的结点总数
	if (T != NULL) 
	{
		BinaryTreenum(T->lchild, n);
		n++;
		BinaryTreenum(T->rchild, n);
	}
	return n;
}

int main() {
	BinaryTree T = new Node;
	int j, n = 0;
	do
	{
		system("cls");
		cout << "\n请输入你要的功能\n";
		cout << "-----华丽的分割线------\n";
		cout << "1:按前序遍历规则创建二叉树\n";
		cout << "2:前序遍历二叉树 T\n";
		cout << "3:中序遍历二叉树 T\n";
		cout << "4:后序遍历二叉树 T\n";
		cout << "5:统计二叉树T的结点总数\n";
		cout << "0:退出程序\n";
		cout << "-----华丽的分割线------\n";
		cin >> j;
		system("cls");
		switch (j) 
		{
			case 1:
				CreateBinaryTree(T); 
				system("pause");
				break;
			case 2:
				PreOrderT(T);
				system("pause");
				break;
			case 3:
				InOrderT(T); 
				system("pause");
				break;
			case 4:
				PostOrderT(T);
				system("pause");
				break;
			case 5:
				cout << BinaryTreenum(T, n) << endl;
				system("pause");
				break;
			case 0:
				exit(1);
		}
	} while (j);
	return 0;
}