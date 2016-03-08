[y,fs]=audioread('tms.wav');
% sound(y,fs);
pxx=pwelch(y);
figure(1);
plot(20*log10(pxx));
xlabel('Hz');
ylabel('dB');

figure(2);
snr=15;
y_noise=awgn(y,snr);
pxx_noise=pwelch(y_noise);
plot(20*log10(pxx_noise));
xlabel('Hz');
ylabel('dB');
sound(y_noise,fs);