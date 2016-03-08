N=100000;
x=randn(1,N);
y=randn(1,N);
a=[0.7,-0.7];
z_1=a(1)*x+sqrt(1-a(1)^2)*y;
z_2=a(2)*x+sqrt(1-a(2)^2)*y;
figure(1);
z1_fix=0.5;
z2_fix=-0.5;
z_tole=0.1;
j=1;
x_select=zeros(1);
for i=1:N
    if (z_1(i)<z1_fix+z_tole) && (z_1(i)>z1_fix-z_tole)
        x_select(j)=x(i);
        j=j+1;
    end
end
figure(1);
subplot(3,1,1);
bins=-4.25:0.5:4.25;
[yvalues,xvalues]=hist(x_select,bins);
yvalues=yvalues/(N*0.5);
bar(xvalues,yvalues);
xlabel('x');
ylabel('relative frequencies');
title('a=0.7 z=0.5');

j=1;
for i=1:N
    if (z_1(i)<z2_fix+z_tole) && (z_1(i)>z2_fix-z_tole)
        x_select(j)=x(i);
        j=j+1;
    end
end
subplot(3,1,2);
bins=-4.25:0.5:4.25;
[yvalues,xvalues]=hist(x_select,bins);
yvalues=yvalues/(N*0.5);
bar(xvalues,yvalues);
xlabel('x');
ylabel('relative frequencies');
title('a=0.7 z=-0.5');

subplot(3,1,3);
j=1;
for i=1:N
    if (z_2(i)<z2_fix+z_tole) && (z_2(i)>z2_fix-z_tole)
        x_select(j)=x(i);
        j=j+1;
    end
end
bins=-4.25:0.5:4.25;
[yvalues,xvalues]=hist(x_select,bins);
yvalues=yvalues/(N*0.5);
bar(xvalues,yvalues);
xlabel('x');
ylabel('relative frequencies');
title('a=-0.7 z=0.5');
% it can be observed that when z=0.5, the conditional distribution of x
% shifts right compared with the normal one, however when z=-0.5, it shifts
% left. But the conditional distribution of x remains the same when a
% changes its sign. It can be concluded that variable z contains
% information about variable x, hence correlation means that one variable
% holds information about the other.