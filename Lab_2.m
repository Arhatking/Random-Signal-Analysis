%% Task 1.1
f0 = 0:0.001:0.5;
dB = 1;
dA = [1 -1.5 0.64];
dG = freqz(dB,dA,2*pi*f0);
figure;
plot(f0,20*log10(abs(dG)));
xlabel('f0 revolutions per sample');
ylabel('frequency response dB');
title('Spectrum versus Frequency');

%% Task 1.2
N =1024;
L = 50;
Y = randn(1,N+L);
x = filter(dB,dA,Y);
x = x(L+1:end);
X = fft(x,N);
P = X.*conj(X)/N;
P = P(1:N/2);
f = 0:1/N:(N-1)/(2*N);
figure;
plot(f,10*log10(abs(P))); hold on
plot(f0,20*log10(abs(dG)),'r');
xlabel('f Hz');
ylabel('Power dB');
legend('Periodogram','True spectrum');
title('Periodogram');
% the periodogram and the true spectrum are consistent with the general
% trend. however, the input of periodogram is WGN, which has variance equals 1.So that it has more
% fluctuation and it is a noisy estimate of the true spectrum.

%% Task 1.3
K1 = 4;
K2 = 16;
PB1 = period_average(x,N,K1);
PB2 = period_average(x,N,K2);
figure;
plot(f,10*log10(abs(PB1)),'r'); hold on;
plot(f,10*log10(abs(PB2)),'g');
plot(f0,20*log10(abs(dG)),'b');
legend('Average periodogram K=4','Average periodogram K=16','True spectrum');
xlabel('f revolutions per sample');
ylabel('Power dB');
title('Average periodogram');
% the benefit is variance is reduced by factor K, however the drawback is
% frequency resolution is reduced to 2piK/N.

%% Task 2.1
% for all the different windows, with N increases, the mainlobe widths
% decrease while the peak sidelobes increase. 

%% Task 2.2
% Chebyshev window has the better frequency resolution, because it has a
% narrower mainlobe.

%% Task 2.3
Hamming = hamming(64);
PW = pwelch(x,Hamming,[],2*pi*f)*2*pi;
figure;
plot(f,10*log10(abs(PW)),'r'); hold on;
plot(f,10*log10(abs(PB2)));
legend('Hamming window','Average periodogram K=16');
xlabel('f revolutions per sample');
ylabel('Power dB');
title('Hamming window versus Average periodogram');
% using hamming window can get a better trade-off between loss of
% resolution and variance reduction.

%% Task 3
NFFT = 1024;
M = 64;
[PBT,fgrid] = btmethod(x,M,NFFT);
figure;
plot(fgrid,PBT,'r'); hold on
plot(f,10*log10(abs(PB2)));
legend('Blackman-Tukey M=64','Bartlett K=16');
xlabel('f revolutions per sample');
ylabel('Power dB');
title('Blackman-Tukey versus Bartlett');
% With M increases, the amount of smoothing decreases while the frequency
% resolution increases. Compared with Barlett's method, with the same
% frequency resolution, the B-T estimate is smoother, which means a less
% variance.

%% Task 4.1
order = 2;
[PAR,f_ar] = parametric_AR(x,order,NFFT);
figure;
plot(f_ar,PAR); hold on
plot(fgrid,PBT); hold on
plot(f,10*log10(abs(PB2)));
legend('Parametric AR','Blackman-Tukey M=64','Bartlett K=16');
xlabel('f revolutions per sample');
ylabel('Power dB');
title('Blackman-Tukey versus Bartlett');
% the retrieved spectrum using parametric AR methods is much smoother than
% non-parametric methods, which means lower variance, however, there maybe
% some bias existing.

%% Task 4.2
order_low = 1;
order_high = 100;
[PAR_low,f_ar] = parametric_AR(x,order_low,NFFT);
[PAR_high,f_ar] = parametric_AR(x,order_high,NFFT);
figure;
plot(f_ar,PAR_low); hold on
plot(f_ar,PAR_high); hold on
plot(f_ar,PAR); 
legend('low order','high order','correct order');
xlabel('f revolutions per sample');
ylabel('Power dB');
title('Different orders of Parametric AR modeling');
% when the order is too low, the mainlobe it reflects is too narrow (i.e.
% incorrect), when the order is too high, it reflects more fluctuation in
% the estimated spectrum.

%% Task 5.1
f0 = 0:0.001:0.5;
dB = [1 0.56 0.81];
dA = [1 -0.24 0.08 -0.37];
dG = freqz(dB,dA,2*pi*f0);
figure;
plot(f0,20*log10(abs(dG)));
xlabel('f0 revolutions per sample');
ylabel('frequency response dB');
title('Spectrum versus Frequency');

%% Task 5.2
NFFT = 2048;
M = 32;
L = 100;
Y = randn(1,NFFT+L);
x = filter(dB,dA,Y);
x = x(L+1:end);
[PBT,fgrid] = btmethod(x,M,NFFT);
figure;
plot(fgrid,PBT); hold on
plot(f0,20*log10(abs(dG)));
xlabel('f0 revolutions per sample');
ylabel('frequency response dB');
title('Spectrum versus Frequency');
% peaks of the spectrum is the most difficult to estimate.

%% Task 5.3
order = 20;
[PAR,f_ar] = parametric_AR(x,order,NFFT);
figure;
plot(f_ar,PAR); hold on
plot(fgrid,PBT); hold on
plot(f0,20*log10(abs(dG)));
xlabel('frequency revolutions per sample');
ylabel('frequency response dB');
legend('Parametric AR','Blackman-Tukey Method','True spectrum');
title('AR modeling versus BT method');
% It is possible to get a good estimate using AR modeling. The valleys of
% the spectrum is the most difficult part to estimate using AR modeling.

%% Task 6-A.1
f0 = 0:0.001:0.5;
dB = 1;
dA = [1 -0.13 0.9];
dG = freqz(dB,dA,2*pi*f0);
wB = [1 -0.8 0.2];
wA = 1;
wG = freqz(wB,wA,2*pi*f0);
figure;
plot(f0,20*log10(abs(dG))); hold on
plot(f0,20*log10(abs(wG)));
xlabel('f0 revolutions per sample');
ylabel('frequency response dB');
legend('desired signal d[n]','disturbance w[n]');
title('Spectrum versus Frequency');

%% Task 6-A.2
% Theoretical task:
% multiply d[n] - 0.13d[n - 1] + 0.9d[n - 2] = e_d[n] left and right sides
% with d[n],d[n-1] and d[n-2] respectively and take the expected value, then we derive that 
% 1. r(0) - 0.13r(1) + 0.9r(2) = sigma_e^2
% 2. r(1) - 0.13r(0) + 0.9r(1) = 0
% 3. r(2) - 0.13r(1) + 0.9r(0) = 0
% after calculating: [1 -0.13 0.9;-0.13 1.9 0;0.9 -0.13 1]*[r(0) r(1) r(2)]
% = [1;0;0] [r(0) r(1) r(2)] = [1 -0.13 0.9;-0.13 1.9 0;0.9 -0.13
% 1]^(-1)*[1;0;0] = [5.2879;0.3618;-4.7121]
% for k>=2, multiply the left and right sides of the equation and take the expected value, we can
% derive that r(k) -0.13r(k-1) + 0.9r(k-2) = 0, which verifies that rd[k] =
% 0.13rd[k - 1] - 0.9rd[k - 2].
% Similarly, first multiply both sides with w[n] and take the expected value,
% we have r(0) = E((ew[n] - 0.8ew[n - 1] + 0.2ew[n - 2])^2) =
% (1+0.8^2+0.2^2)sigma_e^2 = 1.96sigma_e^2
% also r(1) = E((ew[n] - 0.8ew[n - 1] + 0.2ew[n - 2])*(ew[n-1] - 0.8ew[n - 2]+ 0.2ew[n - 3]))
% = (-0.8*1-0.2*0.8)sigma_e^2 = -0.96sigma_e^2
% also r(2) = E((ew[n] - 0.8ew[n - 1] + 0.2ew[n - 2])*(ew[n-2] - 0.8ew[n - 3]+ 0.2ew[n - 4]))
% = 0.2sigma_e^2.
% when k>2 r(k) = E((ew[n] - 0.8ew[n - 1] + 0.2ew[n - 2])*(ew[n-k] -
% 0.8ew[n - 1 - k]+ 0.2ew[n - 2 - k])) = 0.
% because d[n] and w[n] are independent, so rx[k] = rd[k] + rw[k].

%% Task 6-A.3
figure;
[H,W]=freqz(filterCoefficient(10));
plot(W/(pi),20*log10(abs(H)/max(H)));hold on
[H,W]=freqz(filterCoefficient(5));
plot(W/(pi),20*log10(abs(H)/max(H)));hold on
[H,W]=freqz(filterCoefficient(2));
plot(W/(pi),20*log10(abs(H)/max(H)));hold on
[H,W]=freqz(filterCoefficient(1));
plot(W/(pi),20*log10(abs(H)/max(H)));
xlabel('f0 revolutions per sample');
ylabel('frequency response dB');
legend('p=10','p=5','p=2','p=1');
title('Spectrum versus Frequency');
% the situation p=5 and p=10 look like I'm expected, their frequency
% responses are like bandpass filter.

%% Task 6-B.1
mse_1 = esti_MSE(filterCoefficient(1));
mse_2 = esti_MSE(filterCoefficient(2));
mse_5 = esti_MSE(filterCoefficient(5));
mse_10 = esti_MSE(filterCoefficient(10));
% the MSEs for the different filters h1,h2,h5 and h10 are 1.2749, 1.1787,
% 0.7455 and 0.7596 respectively. After comparing, the MSE for h1 has the
% minimum value, so in this case, the filter with length 1 is a good
% choice.

%% Task 6-B.2
ed = randn(1,200);
ew = randn(1,200);
dB1 = 1;
dA1 = [1 -0.13 0.9];
d = filter(dB1,dA1,ed);
dB2 = [1 -0.8 0.2];
dA2 = 1;
w = filter(dB2,dA2,ew);
x=w+d;
figure;
plot(d(151:end));hold on
plot(x(151:end))
xlabel('n sample');
ylabel('d[n],x[n]');
legend('d[n]','x[n]');

%% Task 6-B.3
MSE_emp_1 = emseCalculate( x,d,1 );
MSE_emp_2 = emseCalculate( x,d,2 );
MSE_emp_5 = emseCalculate( x,d,5 );
MSE_emp_10 = emseCalculate( x,d,10 );
% the theoretical and empirical results are almost the same.

