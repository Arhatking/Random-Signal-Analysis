% % Sampling and reconstruction         
close all; clear all; clc         
%% Ex1 Bandlimited signal 
   tau = 0.025;        
   BW = 1/(2*tau);              % one sided bandwidth    
 span1 = 6;                     % Signal has a width of 6*tau on either side of t=0
   fs = 2.1*BW;                 % Change sampling frequency here
 tvec1 = 0:(1/fs):span1*tau;
 tvec1 = [-fliplr(tvec1(2:end)) tvec1]; 

% Sample p(t) with fs 
p_nTsamp = 6*sinc(tvec1/(2*tau)).^2 + sinc(tvec1/(6*tau)).^6 + 6*sinc(tvec1/(10*tau)).^10;
figure(1); stem(tvec1,p_nTsamp); hold on

% Similar looking to continuous-time signal, sample p(t) with very large sampling frequency
fss = 500*BW;           
tvecc = 0:(1/fss):span1*tau;
tvecc = [-fliplr(tvecc(2:end)) tvecc]; 
p_t = 6*sinc(tvecc/(2*tau)).^2 + sinc(tvecc/(6*tau)).^6 + 6*sinc(tvecc/(10*tau)).^10;
figure(1); plot(tvecc,p_t,'r');

% compute DFT and scale frequency axes to represent analog frequencies
    N = max(1024,length(p_nTsamp));
    P = fftshift(fft(p_nTsamp,N));     
 fvec = (fs/N)*(-floor(N/2):1:ceil(N/2)-1); % For both even and odd N
 figure; plot(fvec,20*log10(abs(P))); title('Frequency response of sampled signal')  
 xlabel('Frequency in Hz')
 ylabel('Power in dB')


% Reconstruction using truncated sinc
 span1 = 12;                % Sinc pulse has a width of span1*tau on either side of t=0
   fs1 = 100*fs;            % The Sinc pulse must resemble continuous signal, high sample rate, integer multiple for convenience
 tveccc = 0:(1/fs1):span1*tau;
 tveccc = [-fliplr(tveccc(2:end)) tveccc]; 
 sinc_pulse = sinc(fs*tveccc); % fs here should be the sampling frequency of P_nTsamp
 
 % Upsample the pulse p to bring it to the same sampling time reference
 p_upsamp = upsample(p_nTsamp,fs1/fs);  % Sampling rates easily matched inserting zeros since fs1=integer*fs
 p_upsamp(end-fs1/fs+2:end)=[]; 
 p_recons = conv(p_upsamp,sinc_pulse);
 t_recons = (1/fs1).*(-floor(length(p_recons)/2):1:floor(length(p_recons)/2));
 figure(1); plot(t_recons, p_recons,'k'); 
         
title('Reconstructed signal');  
legend('Samples','Equivalent to Continuous','Reconstructed')
         
%% Ex2 Rectangular pulse, has infinite bandwidth and significant power in the side lobes
close all;
tau = 0.01;         % symbol period
fs  = 100*(1/tau);  % first null in bandwidth at 1/tau
fsfd = floor(tau*fs);  % Number of samples
p_nTsamp = ones(1,fsfd);
tvec = linspace(-tau/2,tau/2,fsfd);
figure(1); stem(tvec,p_nTsamp); hold on

% compute DFT and scale frequency axes to represent analog frequencies
    N = max(1024,length(p_nTsamp));
    P = fftshift(fft(p_nTsamp,N));     
 fvec = (fs/N)*(-floor(N/2):1:ceil(N/2)-1); % For both even and odd N
 figure; plot(fvec,20*log10(abs(P))); title('Frequency response of sampled signal')  
 xlabel('Frequency in Hz')
 ylabel('Power in dB')
 
% % Reconstruction using truncated sinc 
 span1 = 12;
   fs1 = 100*fs; 
 tvec1 = eps:(1/fs1):span1*tau;
 tvec1 = [-fliplr(tvec1(2:end)) tvec1]; 
 sinc_pulse = sinc(fs*tvec1);  % fs here should be the sampling frequency of P_nTsamp
 
 % Upsample the pulse p to bring it to the same sampling time reference
 p_upsamp = upsample(p_nTsamp,fs1/fs);
 p_upsamp(end-fs1/fs+2:end)=[]; 
 p_recons = conv(p_upsamp,sinc_pulse);
 t_recons = (1/fs1).*(-floor(length(p_recons)/2):1:floor(length(p_recons)/2));
 figure(1); plot(t_recons, p_recons,'k'); hold on;
            plot(tvec,p_nTsamp,'r');
            title('Reconstructed signal');  
            legend('Reconstructed','Equivalent to Continuous','Location','SouthWest')
            axis([-1.5*tau 1.5*tau -1.5 1.5])

