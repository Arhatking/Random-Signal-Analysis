%% Task_6_1
% P_x[n]=E[X^2[n]]=E[(w(n)+0.9X[n-1])^2)=E[w^2[n]+1.8w[n]*X[n-1]+0.81X^2[n-1]]
% =E[w^2[n]]+1.8E[w[n]*X[n-1]]+0.81P_x[n-1]
% Since x[n-1] is uncorrelated with w[n], E[w[n]*X[n-1]]=0;
% =1+0+0.81P_x[n-1]=1+0.81P_x[n-1];
% Since P_x[1]=1;
% P_x[n]=0.81^(n-1)+0.81^(n-2)+...+0.81^0
% when n increases to infinity, P_x[n]=1/(1-0.81)=5.26
rng('shuffle')
N=500;
R=200; % repeat times
for j=1:R
for i=2:N
    W=randn(1,N);
    Xn(1)=W(1);
    Xn(i)=0.9*Xn(i-1)+W(i);
end
for i=1:N
    P_xn(i,j)=Xn(i);
end
end
figure()
x=1:N;
for n=1:N
    y(n)=var(P_xn(n,:));
end
plot(x,y,'.')
xlabel('n');
ylabel('P_x(n)');
title('P_x(n)');
%% Task_6_2
% E[x[n]]=0,it can be concluded that
% E[x[n]x[n-1]]=0.9^l*P_x[n-l]=(0.9^l-0.9^(2n-l))/0.19, since it is not
% only a function of l, this process is not wide-sense stationary. If n
% increases to infinity, r_x(n,n-l) increases to 0.9^l/0.19, it is only a
% function of l. So this process becomes wide-sense stationary.
%% Task_6_3
N=256;
X=zeros(N,N);
for i=1:N
    w=randn(1,N);
    X(i,:)=filter(1,[1 -0.9],w);
end
X=X';
figure()
plot(X)
xlabel('i');
ylabel('X(i,:)');
title('matrix X');
% With n increases, although the mean value of x(n) remains 0, its variance
% increases and converges to 5.26. So it can be seen that the lines first 
% diverge along the axis X, then they achieves a reletively same level 
% gradually.
figure()
n1=[10,50,100,200];
n2=[9,49,99,199];
for i=1:100
    w=randn(1,1000);
    x=filter(1,[1 -0.9],w);
    plot(x(n1),x(n2),'.');
    hold on
end
xlabel('n1');
ylabel('n2');
title('scatterplot 1');
figure()
n1=[50,100,200];
n2=[40,90,190];
for i=1:100
    w=randn(1,1000);
    x=filter(1,[1 -0.9],w);
    plot(x(n1),x(n2),'.');
    hold on
end
xlabel('n1');
ylabel('n2');
title('scatterplot 2');
% It can be seen from the plot that, when the diviation between n1 and n2
% becomes bigger, the narrow band in the figure becomes wider, as we calculated 
% before, the auto-correlation decreases as the l increases, which certificates 
% the outcome figure. Compared with Task 5.4, when n =256,the auto-correlation
% in this Task is much smaller than Task 5.4, so the scatter plots is more 
% dispertive in this Task.
%% Task_6_4
N=256;
r_x=zeros(1);
l=1;
K=256;
for i=(l+1):K
sum=zeros(1);
for n=(l+1):i
    W=randn(1,n);
    Xn(1)=W(1);
    Xn(n)=0.9*Xn(n-1)+W(n);
    sum=sum+Xn(n)*Xn(n-l);
end
r_x(i)=sum/i;
end
figure()
plot(r_x,'.')
xlabel('n');
ylabel('r_x(n,n-1)');
xlim([l+1 N]);
hold on
n=(l+1):N;
rx=(0.9^l-0.9.^(2*n-l))/0.19;
plot(n,rx,'r');
title('sample auto-correlation');
axis([0 256 0 10]);
% Compared with Task 5.5, the sample ensemble auto-correlation achieves a
% horizontal level with n increases.