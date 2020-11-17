clear all;
close all;
clc
M=dlmread('r.U.xxxx.txt');
x=M(:,1);
y=M(:,2);
N=length(x);
dy=diff(y);
dx=diff(x);
dy_dx=-dy./dx;
dy_dx(N)=dy_dx(N-1);
A(:,1)=x;
A(:,2)=dy_dx;
dlmwrite('neg_dU_dr.xxxx.txt',A,'precision', 8);
