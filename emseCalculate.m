function [ MSE_emp ] = emseCalculate( x,d,p )
h = filterCoefficient( p );
d_p = conv(x,h');
e_p = d-d_p(1:length(x));
MSE_emp = norm(e_p)^2/length(x);
end

