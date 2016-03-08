N=1024;
K=1024;
X=randn(N,K);
aver_ensemble=mean(X,2)';
aver_time=mean(X);
figure(1)
subplot(2,1,1)
plot(aver_ensemble)
xlabel('K');
ylabel('average');
subplot(2,1,2)
plot(aver_time)
xlabel('N');
ylabel('average');
% the process appears to be ergodic in the mean.

n1=randi(256,1,1,'uint32');
n2=randi(256,1,1,'uint32');
a=X(n1,:);
b=X(n2,:);
figure(2)
plot(a,b,'.');
xlabel('n1');
ylabel('n2');
sum=0;
for i=1:256
    sum=sum+X(n1,i)*X(n2,i);
end
corr=sum/K;
% they look uncorrelated.