N=10000;
x=randn(1,N);
y=randn(1,N);
y_fix=0.5;
y_tole=0.1;
j=1;
x_select=zeros(1);
for i=1:N
    if (y(i)<y_fix+y_tole) && (y(i)>y_fix-y_tole)
        x_select(j)=x(i);
        j=j+1;
    end
end
subplot(2,1,1);
bins=-4.25:0.5:4.25;
[yvalues,xvalues]=hist(x_select,bins);
yvalues=yvalues/(length(x_select)*0.5);
bar(xvalues,yvalues);
xlabel('x');
ylabel('relative frequencies');
title('pair (x_k,y_k)');

u=rand(1,N);
j=1;
u_select=zeros(1);
for i=1:N
    if (u(i)>0.45)&&(u(i)<0.55)
        u_select(j)=x(i);
        j=j+1;
    end
end
subplot(2,1,2);
bins=-4.25:0.5:4.25;
[yvalues,xvalues]=hist(u_select,bins);
yvalues=yvalues/(length(u_select)*0.5);
bar(xvalues,yvalues);
xlabel('x');
ylabel('relative frequencies');
title('pair (x_k,u_k)');
% the two conditional distributions are the same with marginal
% distribution, since the variables are uncorrelated.