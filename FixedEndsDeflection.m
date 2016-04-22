function [Deflection] = FixedEndsDeflection(P,n,L,E,I) 
Deflection = (P*n*(0.5*L)^6)/(3*E*I*L^3)
end