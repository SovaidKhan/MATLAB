%I calculator rectangular tube
function [I,A] = IIB(b,d,t)
h = b - t; %cetre flange
k = d - 2*t;
I = (b*(d^3) - h*(k^3))/12;
%A = (b*d) - (h*k);
end