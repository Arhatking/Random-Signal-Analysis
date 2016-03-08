% Signal space and constellation
% Ex 5
clc; clear all; close all

% Input papameters
% For passband implemetation sampling frequency is a necessary parameter
fs = 12e3; % sampling frequency [Hz]
rb = 600; % bit rate [bit/sec]
N = 432; % number of bits to transmit

% Constellation or bit to symbol mapping
s = [(1 + 1i) (1 - 1i) (-1 -1i) (-1 + 1i)]/sqrt(2); % Constellation 1 - QPSK/4-QAM
                                                    % s = exp(1i*((0:3)*pi/2 + pi/4)); % Constellation 1 - same constellation generated as PSK
%scatterplot(s); grid on;                            % Constellation visualization

M = length(s);                                      % Number of symbols in the constellation
m = log2(M);                                        % Number of bits per symbol
fd = rb/m;                                          % Symbol rate
fsfd = fs/fd;                                       % Number of samples per symbol (choose fs such that fsfd is an integer for simplicity)

rng('shuffle')
b = randsrc(1,N,[0 1]);                             % Information bits
b_buffer = buffer(b, m)';                           % Group bits into bits per symbol
sym_idx = bi2de(b_buffer, 'left-msb')'+1;           % Bits to symbol index
x = s(sym_idx);                                     % Look up symbols using the indices  

x_upsample = upsample(x, fsfd);                     % Space the symbols fsfd apart, to enable pulse shaping using conv.
x_upsample(end-fsfd+2:end) = [];

%% RRC pulse
span = 6;
beta = 0.4;
[RC_puls, t] = rtrcpuls(beta,1/fd,fs,span);
pulse_tr_RC = conv(RC_puls,x_upsample);
N = length(pulse_tr_RC);
P = fftshift(fft(pulse_tr_RC,N));
fvec = (fs/N)*(-floor(N/2):1:ceil(N/2)-1);
%figure; plot(fvec,20*log10(abs(P)));
%% Carrier
f_carrier=2000;
t=0:1/fs:(length(pulse_tr_RC)-1)/fs;
Icarrier = sqrt(2)*(real(pulse_tr_RC)).*cos(2*pi*f_carrier*t);
Qcarrier = sqrt(2)*(imag(pulse_tr_RC)).*sin(2*pi*f_carrier*t);
carrier=Icarrier+Qcarrier;
N = length(carrier);
P = fftshift(fft(carrier,N));
fvec = (fs/N)*(-floor(N/2):1:ceil(N/2)-1);
figure;
plot(fvec,20*log10(abs(P)));
%sound(real(P)+imag(P),fs);
%% Signal through AWGN
snr=20;
carrier_noise=awgn(carrier,snr);
N = length(carrier_noise);
P_noise = fftshift(fft(carrier_noise,N));
figure;
plot(fvec,20*log10(abs(P_noise)));
%% Remove carrier
Icarrier_remove=sqrt(2)*carrier_noise.*cos(2*pi*f_carrier*t);
Qcarrier_remove=sqrt(2)*carrier_noise.*sin(2*pi*f_carrier*t);
carrier_remove=Icarrier_remove+Qcarrier_remove;
N = length(carrier_remove);
P = fftshift(fft(carrier_remove,N));
fvec = (fs/N)*(-floor(N/2):1:ceil(N/2)-1);
figure;
plot(fvec,20*log10(abs(P)));
%% Matched filter
MF_puls=fliplr(RC_puls);
figure;
plot(MF_puls);
mf=conv(MF_puls,carrier_remove);
N = length(mf);
P_mf = fftshift(fft(mf,N));
fvec = (fs/N)*(-floor(N/2):1:ceil(N/2)-1);
figure;
plot(fvec,20*log10(abs(P_mf)));
%% Decision making (Sample at Ts)
mf_downsample = downsample(mf, fsfd);
threshold=0.2;
realpart=real(mf_downsample);
imagpart=imag(mf_downsample);
for i=1:length(mf_downsample)
    if realpart(i)>=threshold
        Ifinal(i)=1;
    else
        Ifinal(i)=-1;
    end
    if imagpart(i)>=threshold
        Qfinal(i)=1;
    else
        Qfinal(i)=-1;
    end
end
%% Symbols to bits
final=[Ifinal',Qfinal'];
for i=1:length(final)
    if final(i,1)==1 && final(i,2)==1
        finalbits(i,1)=0;
        finalbits(i,2)=0;
    elseif final(i,1)==1 && final(i,2)==-1
        finalbits(i,1)=0;
        finalbits(i,2)=1;
    elseif final(i,1)==-1 && final(i,2)==-1
        finalbits(i,1)=1;
        finalbits(i,2)=0;
    else
        finalbits(i,1)=1;
        finalbits(i,2)=1;
    end
end