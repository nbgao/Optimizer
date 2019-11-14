#include <bits/stdc++.h>
using namespace std;

double F1(double x){
    return pow(x,3)-2*x+1;
}

double F2(double x){
    return pow(x,2)-6*x+2;
}

double F3(double x){
    return pow(x,2)-sin(x);
}

/*
double QuardraticInterpolation(double (*f)(double), double a, double b, double delta, double epsilon){
    double h = 0.2;
    double s0=a, s1=s0+h, s2=s0+2*h;
    double f0=f(s0), f1=f(s1), f2=f(s2);
    int k = 0;
    while(abs(s2-s0)>delta || abs(f2-f0)>epsilon){
        double h = (4*f1-3*f0-f2)*h/(2.0*(2*f1-f0-f2));
        cout<<h<<endl;
        if(k>2)
            break;
        double s = s0 + h;
        double fs = f(s);
        if(f1<fs){
            if(s1<s){
                s2 = s;
                f2 = fs;
            }else{
                s0 = s;
                f0 = fs;
            }
        }else{
            if(s1<s){
                s0 = s1;
                f0 = f1;
            }else{
                s2 = s1;
                f2 = f1;
            }
        }
        k++;
        printf("step=%d s0=%.6f s1=%.6f s2=%.6f f0=%.6f f1=%.6f f2=%.6f\n", k, s0, s1, s2, f0, f1, f2);
    }
    return s1;
}*/
double QuardraticInterpolation(double (*f)(double), double x0, double delta, double epsilon){
    double s0=x0, big=1e6, err=1, ds=1e-5;
    double f0=f(s0), h=1;
    int k = 0, cond=0;
    if(abs(s0)>1e4)
        h = abs(s0)*(1e-4);

    while(err>epsilon && cond!=5){
        double df = (f(s0+ds)-f(s0-ds))/(2*ds);
        if(df>0)
            h = -abs(h);
        double s1=s0+h, s2=s0+2*h, s=s0;
        double f0=f(s0), f1=f(s1), f2=f(s2), fs=f(s);
        cond = 0;
        while(abs(h)>delta && cond==0){
            if(f0<=f1){
                s2 = s1;
                f2 = f1;
                h = 0.5*h;
                s1 = s0 + h;
                f1 = f(s1);
            }else if(f2<f1){
                s1 = s2;
                f1 = f2;
                h = 2*h;
                s2 = s0 + 2*h;
                f2 = f(s2);
            }else
                cond = -1;

            if(abs(h)>big || abs(s0)>big)
                cond = 5;
        }
        if(cond==5){
            s = s1;
            fs = f(s);
        }else{
            double d = 2*(2*f1-f0-f2), h_;
            if(d<0)
                h_ = h*(4*f1-3*f0-f2)/d;
            else{
                h_ = h/3;
                cond = 4;
            }
            s = s0 + h_;
            fs = f(s);
            h = abs(h);
            double h0 = abs(h_), h1 = abs(h_-h), h2 = abs(h_-2*h);
            if(h0<h)
                h = h0;
            if(h1<h)
                h = h1;
            if(h2<h)
                h = h2;
            if(h==0)
                h = h_;
            if(h<delta)
                cond = 1;
            if(abs(h)>big || abs(h_)>big)
                cond = 5;
            err = abs(f1-fs);
            s0 = s;
            k++;
            printf("step=%d s0=%.6f s1=%.6f s2=%.6f f0=%.6f f1=%.6f f2=%.6f\n", k, s0, s1, s2, f0, f1, f2);
        }
        if(cond==2 && h<delta)
            cond = 3;   
    }
    return s0;
}

int main(){
    double a=0, b=3, x0=1, delta=1e-2, epsilon=1e-4, x;
    double (*f)(double) = F1;
    //f = f1;     // 指向自定义函数
    x = QuardraticInterpolation(f, x0, delta, epsilon);
    printf("x=%.6f\nf_min=%.6f\n", x, f(x));
    return 0;
}