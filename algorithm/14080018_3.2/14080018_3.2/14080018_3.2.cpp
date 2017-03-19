#include <iostream>
#include "Tree.h"

void main()
{
	Tree BinaryTree("A(B(D(G,),E(,H)),C(F(,I(J,K)),)");
	int n = 0;
	BinaryTree.NumOfNode(BinaryTree.GetRoot(),n);
	cout << "结点数为" << n << endl;
	cout << "中序遍历（递归）为";
	BinaryTree.In_Rec(BinaryTree.GetRoot());
	cout << "\n中序遍历（非递归）为";
	BinaryTree.In(BinaryTree.GetRoot());
	// 线索化
	cout << "\n中序遍历线索为";
	BinaryTree.InThread(BinaryTree.GetRoot());
	BinaryTree.In_Thread(BinaryTree.GetRoot());
}
