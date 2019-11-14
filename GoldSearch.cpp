#include <bits/stdc++.h>
using namespace std;

double f1(double x){
    return pow(x,3)-2*x+1;
}

double f2(double x){
    return pow(x,2)-x-1;
}

double GoldSearch(double (*f)(double), double a, double b, double delta, double epsilon){
    double t = (sqrt(5)-1)/2;
    double p=a+(1-t)*(b-a), q=a+t*(b-a);
    double fa=f(a), fb=f(b), fp=f(p), fq=f(q);
    int k = 0;
    while(abs(b-a)>delta || abs(fb-fa)>epsilon){
        if(fp<fq){
            b = q;
            fb = fq;
            q = p;
            fq = fp;
            p = a+(1-t)*(b-a);
            fp = f(p);
        }else{
            a = p;
            fa = fp;
            p = q;
            fp = fq;
            q = a+t*(b-a);
            fq = f(q);
        }
        k++;
        printf("step=%d a=%.6f p=%.6f q=%.6f b=%.6f fa=%.6f fb=%.6f\n", k, a, p, q, b, fa, fb);
    }
    double x = (fp<fq?p:q);
    return x;
}

int main(){
    double a=0, b=3, delta=0.15, x;
    double (*f)(double) = f1;
    //f = f1;     // 指向自定义函数
    x = GoldSearch(f, a, b, delta, 1);
    printf("x=%.6f\nf_min=%.6f\n", x, f(x));
    return 0;
}