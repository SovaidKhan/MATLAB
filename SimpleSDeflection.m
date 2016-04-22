function [Deflection] = SimpleSDeflection(P,n,L,E,I) 
Deflection = (P*n*L^3)/(48*E*I)
end