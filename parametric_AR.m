function [ PAR,f_ar ] = parametric_AR( x,order,NFFT )
f_ar = 0:1/NFFT:1/2;
PAR =  pyulear(x,order,NFFT)*pi;
PAR = 10*log10(abs(PAR));
end

