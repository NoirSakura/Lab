// 14080018_5.1.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
using namespace std;
#define MAXSIZE 200  
struct SeqList                              
{      
	int digit[MAXSIZE];     
	int length; 
};
int Search(SeqList &List, int low, int high, int key); 
void main()                                         
{      
	int i, j, key, low, high; 
	SeqList List;
	cout << "请输入数字个数:";
	cin >> j;
	printf("请输入数字(升序):\n"); 
	for (i = 0; i < j; i++)
	{         
		cin >> List.digit[i];
	}      
	List.length = j; 
	low = 0; 
	high = List.length - 1; 
	printf("请输入关键词:\n"); 
	cin >> key;
	i =  Search(List, low, high, key);
	if (i != -1)
		cout << "找到。是第" << i + 1 << "号元素";
	else printf("未找到！\n"); 
}   

int Search(SeqList &List,int low,int high,int key)      
{      
	int k = -1;
	if (low <= high)
	{          
		int mid; 
		mid = (low + high) / 2; 
		if (List.digit[mid] == key)
		{
			cout << List.digit[mid] << "=" << key << endl;
			k = mid;
		}
		else if (List.digit[mid] < key)
		{
			cout << List.digit[mid] << "<" << key << endl;
			k = Search(List, mid + 1, high, key);
		}
		else
		{
			cout << List.digit[mid] << ">" << key << endl;
			k = Search(List, low, mid - 1, key);
		}
	}      
	return k; 
}