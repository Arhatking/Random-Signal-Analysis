function [ PBT,fgrid ] = btmethod( x,M,NFFT )
w_lag = hamming(2*M+1);
rx = xcorr(x,M,'biased');
BT = fft(w_lag'.*rx,NFFT);
fgrid = 0:1/NFFT:(NFFT-1)/(2*NFFT);
PBT = BT(1:NFFT/2);
PBT = 10*log10(abs(PBT));

end

