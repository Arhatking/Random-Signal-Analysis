%  from a scatterplot we can see the DIRECTION and SHAPE
%  relationship between two variables, which means that
%  Correlation is the STRENGTH and DIRECTION relationship between two variables.
N=2000;
x=randn(1,N);
y=randn(1,N);
a=[0.5,-0.5,0.9,-0.9];
z_1=a(1)*x+sqrt(1-a(1)^2)*y;
z_2=a(2)*x+sqrt(1-a(2)^2)*y;
z_3=a(3)*x+sqrt(1-a(3)^2)*y;
z_4=a(4)*x+sqrt(1-a(4)^2)*y;
figure(1);
subplot(2,2,1);
plot(x,z_1,'.');
xlabel('x');
ylabel('z_1');
title('a = 0.5');
subplot(2,2,2);
plot(x,z_2,'.');
xlabel('x');
ylabel('z_2');
title('a = -0.5');
subplot(2,2,3);
plot(x,z_3,'.');
xlabel('x');
ylabel('z_3');
title('a = 0.9');
subplot(2,2,4);
plot(x,z_4,'.');
xlabel('x');
ylabel('z_4');
title('a = -0.9');

figure(2)
bins=-4.25:0.5:4.25;
[yvalues,xvalues]=hist(z_1,bins);
yvalues=yvalues/(N*0.5);
bar(xvalues,yvalues);
xlabel('x');
ylabel('relative frequencies');
title('a = 0.5');
z=-4.25:0.5/10:4.25;
pdf=exp(-z.^2/2);
pdf=pdf/sqrt(2*pi);
hold on
plot(z,pdf);
% subplot(2,2,2)
% [yvalues,xvalues]=hist(z_2,bins);
% yvalues=yvalues/N;
% bar(xvalues,yvalues);
% xlabel('x');
% ylabel('relative frequencies');
% title('a = -0.5');
% subplot(2,2,3)
% [yvalues,xvalues]=hist(z_3,bins);
% yvalues=yvalues/N;
% bar(xvalues,yvalues);
% xlabel('x');
% ylabel('relative frequencies');
% title('a = 0.9');
% subplot(2,2,4)
% [yvalues,xvalues]=hist(z_4,bins);
% yvalues=yvalues/N;
% bar(xvalues,yvalues);
% xlabel('x');
% ylabel('relative frequencies');
% title('a = -0.9');
