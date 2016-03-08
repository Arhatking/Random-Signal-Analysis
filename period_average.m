function [ PB ] = period_average( x,N,K )
M = N/K;
xx = reshape(x,M,K);
XX = fft(xx,N);
PP = XX.*conj(XX)/M;
PB = mean(PP');
PB = PB(1:N/2);
end

