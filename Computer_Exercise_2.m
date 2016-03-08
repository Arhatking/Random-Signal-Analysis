% bits=1000;
% fsamp=44000;
% Rb=440;
% Ts=2/Rb;
% a=rand(1,bits)>0.5;
% col=length(a)/2;
% 
% I=a(1:2:bits-1);
% Q=a(2:2:bits);
% 
% I=-2.*I+1;
% Q=-2.*Q+1;

n = 10000; % Number of bits to process
x = randi([0,1],n,1); % Random binary data stream
xsym = bi2de(reshape(x,2,length(x)/2).','left-msb');
