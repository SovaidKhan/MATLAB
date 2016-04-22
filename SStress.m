%shear stress calculator y_bar = y_max = 0.5d max case is outeert
function [Stress] = SStress(M_t,r,J)
Stress = (M_t*r)/J;
end