#include <bits/stdc++.h>
#include<iostream>
using namespace std;

int main()
{
    // int cases,a[100];
    // cin>>cases;
    // for(int i=0;i<cases;i++)
    // {
    //     cin>>a[i];
    // }

    // for(int i=0;i<cases;i++)
    // {   int count=0;
    //     int num=0;
    //     if (a[i]%2==0)
    //     { 
    //         for(int j=1;j<a[i]/2+1;j++)
    //         {
    //              if (j%2!=0)
    //              {
    //                 if(2*j<a[i]/2+1)
    //                 count++;
    //              }
    //              if(j%2==0)
    //              {
    //                  num++;
    //              }
                
    //         }
    //       count=count+a[i]/2+num/2;
    //        cout<<count<<"\n";
    //     }
    //     else 
    //     { for(int j=1;j<a[i]/2+1;j++)
    //         {
    //              if (j%2!=0)
    //              {
    //                 if(2*j<a[i]/2+1)
    //                 count++;
    //              }
    //              if(j%2==0)
    //              {
    //                  num++;
    //              }
            
    //         }
    //        count=count+a[i]/2+1+num/2;
    //        cout<<count<<"\n";
    //     }
    // }
    int n;
    cin>>n;
    int sum;
    sum=n*n;
    cout<<sum<<"\n";
          
    return 0;
}