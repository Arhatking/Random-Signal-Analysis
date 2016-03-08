function [ dG ] = filter_fre_respon( p,f0 )
h = filterCoefficient( p );
dG = freqz(1,h,2*pi*f0);
end

