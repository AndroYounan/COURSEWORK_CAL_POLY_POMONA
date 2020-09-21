// Project2_MergeSortAlgorithm.cpp : This file contains the 'main' function. Program execution begins and ends there.
// 
// Created By: Andro Younan for ECE3310, Fall 2020
#include <iostream>
using namespace std;
#define N 10
void display(double* a, int size);
void selectionSort(double* a, int sizeofArray);
double* MergeSort(double* a1, double* a2, int size1, int size2);
int main()
{
    int x1[N], e1[N], x2[N], e2[N];
    double y1[N], y2[N];
    for (int i = 0; i < N; i++)
    {
        // generating two arrays with 10 different numbers
        x1[i] = rand() % 301;
        e1[i] = -10 + rand() % 21;
        y1[i] = 7.03 + 0.05 * x1[i] + e1[i]; 
        x2[i] = rand() % 301;
        e2[i] = -10 + rand() % 21;
        y2[i] = 7.03 + 0.05 * x2[i] + e2[i];
    }
    // printing the two unsorted arrays
    display(y1, N);
    display(y2, N);
    // sorting the two arrays
    selectionSort(y1, N);
    selectionSort(y2, N);
    // printing the two sorted arrays
    cout << "\n\nthe sorted arrays are: " << endl;
    display(y1, N);
    display(y2, N);
    // creating a dynamic array to store the result in
    double* r = new double;
    // merging and sorting both arrays
    r = MergeSort(y1, y2, N, N);
    // printing the merged and sorted array     
    cout << "\n\nthe merged and sorted array is: " << endl;
    display(r, N + N);
    cout << endl << endl;
    delete r;
    return 0;
}
// function to display the arrays
void display(double* a, int size)
{
    cout << endl;
    for (int i = 0; i < size; i++)
        cout << a[i] << ", ";
}
// selection sort algorithm
void selectionSort(double *a, int sizeofArray)
{
    int temp = 0;
    for (int i = 0; i < sizeofArray; i++)
        for (int j = i + 1; j < sizeofArray; j++)
        {
            if (a[j] < a[i])
            {
                temp = a[i];
                a[i] = a[j];
                a[j] = temp;
            }
        }
}
// MergeSort Algorithm
double* MergeSort(double* a1, double* a2, int size1, int size2)
{
    int i = 0, j = 0, k = 0;
    // creating a dynamic array to store the result in
    double* r;
    r = new double [size1 + size2];

    while (i < size1 && j < size2) // while we do not reach the end of any of both arrays
    {
        if (a1[i] < a2[j])
            r[k++] = a1[i++];
        else 
            r[k++] = a2[j++];
    }

    while (i < size1) // if we reach the end of array2, we copy the rest of array 1 to the result
        r[k++] = a1[i++];
    while (j < size2) // if we reach the end of array1, we copy the rest of array 2 to the result
        r[k++] = a2[j++];
    
    return r;
}