// 14080018_3.3.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include "Huffman.h"
int main()
{
	Huffman Tree("CASTCASTSATATATASA");
	Tree.Code("", Tree.GetRoot());
	cout << "Huffman解码为：";
	Tree.Decode("111011001110110011001001001001100");
	return 0;
}
