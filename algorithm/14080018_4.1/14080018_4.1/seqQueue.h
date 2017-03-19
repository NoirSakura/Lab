#pragma once
#include <assert.h>
#include <iostream>
using namespace std;
#include "queue.h"
template <class T>
class SeqQueue :public Queue<T>             //循环队列的类定义
{
protected:
	int rear, front;                    //队头和队尾指针
	T *elements;                        //存放队列元素的数组
	int maxSize;                        //队列最大可容纳元素个数
public:
	SeqQueue(int sz = 10);              //构造函数
	~SeqQueue() { delete[] elements; }   //析构函数
	bool EnQueue(const T& x);            //若队列不满，则将x进队，否则队溢出处理
	bool DeQueue(T& x);                  //若队列不空，则退出队头元素x并由函数返回true，否则队空，返回false
	bool getFront(T& x);                 //若队列不为空，则函数返回true及队头元素的值，否则返回false
	void makeEmpty() { front = rear = 0; }   //置空操作：队头指针和队尾指针置0
	bool IsEmpty()const
	{
		return (front == rear) ? true : false;   //判队列空否，若队列空，则函数返回true；否则返回false
	}
	bool IsFull() const
	{
		return ((rear + 1) % maxSize == front) ? true : false;   //判队列满否，若队列满，则函数返回true；否则返回false 
	}
	int getSize()const
	{
		return (rear - front + maxSize) % maxSize;          //求队列元素个数
	}
	friend ostream& operator<<(ostream& os, SeqQueue<T>& Q);             //输出队列中元素的重载操作<<
};

template <class T>
SeqQueue<T>::SeqQueue(int sz) :front(0), rear(0), maxSize(sz)       //建立一个最大具有maxSize个元素的空队列
{
	elements = new T[maxSize];                               //创建队列空间
	assert(elements != NULL);                                //断言：动态存储分配成功与否
};

template <class T>
bool SeqQueue<T>::EnQueue(const T& x)        //若队列不满，则将元素x插入到该队列的队尾，否则出错处理
{
	if (IsFull() == true) return false;            //队列满则插入失败，返回
	elements[rear] = x;                            //按照队尾指针指示位置插入
	rear = (rear + 1) % maxSize;                   //队尾指针加1
	return true;                                   //插入成功，返回
};

template <class T>
bool SeqQueue<T>::DeQueue(T& x)            //若队列不空则函数退掉一个队头元素并返回true，否则函数返回false
{
	if (IsEmpty() == true) return false;            //若队列空则删除失败，返回
	x = elements[front];                            
	front = (front + 1) % maxSize;                  //队头指针加1
	return true;                                    //删除成功，返回
};

template <class T>
bool SeqQueue<T>::getFront(T& x)                //若队列不空则函数返回该队列队头元素的值
{
	if (IsEmpty() == true) return false;              //若队列空则函数返回空指针
	x = elements[front];                              //返回队头元素的值
	return true;
};

template<class T>
ostream& operator<<(ostream& os, SeqQueue<T>& Q)           //输出队列中元素的重载操作<<
{
	os << "front=" << Q.front << ",rear=" << Q.rear << endl;
	for (int i = front; i != rear; i = (i + 1) % maxSize)
		os << i << ":" << Q.elements[i] << endl;
	return os;
};