%bending stress calculator y_bar = y_max = 0.5d simply supported
function [Stress] = BStress(M_b,y_bar,I)
Stress = (M_b*y_bar)/I;
end