%I calculator square tube
function [I] = IST(a,t)
h = a - 2*t;
I = (a^4 - h^4)/12;
%A = (a^4) - (h^4);
end