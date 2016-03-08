function [ mse ] = esti_MSE( h )
p = length(h);
rd = zeros(p,1);
rw = zeros(p,1);
if p == 1
    rd(1) = 5.2879;
    rw(1) = 1.68;
elseif p == 2
    rd = [5.2879;0.3618];
    rw = [1.68;-0.96];
elseif p >= 3
    rd(1) = 5.2879;
    rd(2) = 0.3618;
    for k = 3:p
        rd(k) = 0.13*rd(k-1)-0.9*rd(k-2);
    end
    rw = [1.68;-0.96;0.2;zeros(p-3,1)];
end
    rx = rd + rw;
    Rx = toeplitz(rx);
    rdx = Rx*h;
mse = 5.2879 - sum(rdx.*h);
end

