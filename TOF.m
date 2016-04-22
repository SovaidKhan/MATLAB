PrincipalStress = eig(Cauchy);

%distortion energy theory
ShearStress(1) = PrincipalStress(1) - PrincipalStress(2);
ShearStress(2) = PrincipalStress(2) - PrincipalStress(3);
ShearStress(3) = PrincipalStress(3) - PrincipalStress(1);
%ShearStress = ShearStress';
%equivalent Sy/n
MaximuimShearStress = max(abs(ShearStress))          %
DistortionEnergyStress = ((((ShearStress(1)^2) + (ShearStress(2)^2) + (ShearStress(3)^2))/2)^0.5)
