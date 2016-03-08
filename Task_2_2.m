N=2000;
x=randn(1,N);
y=randn(1,N);
figure(1);
plot(x,y,'.');
xlabel('x');
ylabel('y');
title('Gaussian versus Gaussian');
% the shape of level curves is a circle.
a=-sqrt(3);
b=-a;
r1=a+(b-a).*rand(1,N);
r2=a+(b-a).*rand(1,N);
figure(2);
plot(r1,r2,'.');
xlabel('r1');
ylabel('r2');
title('Uniform versus Uniform');
% square.
figure(3);
plot(x,r1,'.');
xlabel('x');
ylabel('r1');
title('Gaussian versus Uniform');
% rectangular.