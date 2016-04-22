%I calculator rectangular tube
function [I,A] = IRT(b,d,t)
h = b- 2*t;
k = d -2*t;
I = (b*(d^3) - h*(k^3))/12;
%A = (b*d) - (h*k);
end