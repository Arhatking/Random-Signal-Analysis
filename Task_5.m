%% Task_5_1
% x[n]=w[1]+w[2]+...+w[n]+x[0];u_x[n]=E(w[1])+E(w[2])+..+E(w[n])+x[0];
% With the initial condition x[0]=0 and w[n] is zero-mean Gaussian
% distribution, hence E(w[n])=0. So does u_x[n].
rng('shuffle')
Xn=zeros(1);
u_xn=zeros(1);
P_xn=zeros(1);
for j=1:100
for i=1:100
    W=randn(1,j);
    X=[0 cumsum(W)];
    Xn(i)=X(j+1);
end
u_xn(j)=mean(Xn);
P_xn(j)=var(Xn);
end
figure(1)
n=1:100;
plot(n,u_xn,'.')
xlabel('n');
ylabel('u_x(n)');
title('mean value');
%% Task_5_2
% P_x[n]=E[X^2[n]]=E[(w(n)+X[n-1])^2)=E[w^2[n]+w[n]*X[n-1]+X^2[n-1]]
% =E[w^2[n]]+E[w[n]*X[n-1]]+P_x[n-1]
% Since x[n-1] is uncorrelated with w[n], E[w[n]*X[n-1]]=0;
% =1+0+P_x[n-1]=1+P_x[n-1];
% Since P_x[1]=1;
% P_x[n]=n;
% when n increases to infinity, So does P_x[n].
figure(2)
plot(n,P_xn,'.')
xlabel('n');
ylabel('P_x(n)');
title('variance');
%% Task_5_3
% r_x(n,n-1)=E[x[n]*x[n-1]]=E[(x[n-1]+w[n])*x[n-1]]=P_x[n-1]+E[w[n]*x[n-1]]=P_x(n-1)=n-1
% r_x(n,n-2)=E[x[n]*x[n-2]]=E[(x[n-2]+w[n-1]+w[n])*x[n-2])=P_x(n-2)=n-2
% r_x(n,n-l)=P_x(n-l)=n-l
% the process is not wide-stationary.
% p_x(n,n-l)=sqrt(P_x(n-l)/P_x(n))=sqrt((n-l)/n)
% when n increases to infinity for fixed l, the Normalized Correlation
% Coeffcient increases to 1.
%% Task_5_4
X=zeros(256,256);
for i=1:256
    w=randn(1,256);
    X(i,:)=filter(1,[1 -1],w);
end
X=X';
figure(3)
plot(X)
xlabel('i');
ylabel('X(i,:)');
title('matrix X');
% With n increases, although the mean value of x(n) remains 0, its variance
% increases. So it can be seen that the lines diverge along the axis X. It
% is consistent with my theoretical calculations before.
figure(4)
xlabel('n1');
ylabel('n2');
n1=[10,50,100,200];
n2=[9,49,99,199];
for i=1:100
    w=randn(1,256);
    x=filter(1,[1 -1],w);
    plot(x(n1),x(n2),'.');
    xlabel('x(n1)');
    ylabel('y(n1)');
    title('scatterplot 1');
    hold on
end
figure(5)
xlabel('n1');
ylabel('n2');
n1=[50,100,200];
n2=[40,90,190];
for i=1:100
    w=randn(1,256);
    x=filter(1,[1 -1],w);
    plot(x(n1),x(n2),'.');
    xlabel('x(n1)');
    ylabel('y(n1)');
    title('scatterplot 2');
    hold on
end
% It can be seen from the plot that, when the diviation between n1 and n2
% becomes bigger, the narrow band in the figure becomes wider, as we calculated 
% before, the auto-correlation r_x(n,n-l) = n-l, which certificates the
% outcome figure.
%% Task_5_5
N=256;
r_x=zeros(1);
l=1;
K=256;
for n=(l+1):N
sum=zeros(1);
for i=1:K
    W=randn(1,n);
    X=[0 cumsum(W)];
    sum=sum+X(n)*X(n-l);
end
r_x(n)=sum/K;
end
figure(6)
plot(r_x,'.')
xlabel('n');
ylabel('r_x(n,n-1)');
xlim([l+1 N]);
hold on
n=(l+1):N;
rx=n-1;
plot(n,rx,'r');
title('sample auto-correlation');
axis([0 256 0 256]);
% It is hard to estimate the auto-correlation from one realization.