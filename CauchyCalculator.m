Cauchy = zeros(3,3);    %define cauchy stress tensor

Cauchy(2,2) =BStress(9.81*100*0.246,0.014,ICT(0.028)) ;         %if only diagonals non zero then product of diagonals is det... det = o non real solutions
%Cauchy(1,2) =SStress(9.81*100,0.025,IRT(0.05,0.02,0.002));
%Cauchy(2,1)= Cauchy(1,2)
Cauchy(2,3) = (9.81*100)/ (pi()*((0.028/2)^2))                  %shear in yz
Cauchy(3,2)= Cauchy(2,3)
%Cauchy(1,1) =4000;
%Cauchy(3,3) = 9000;


%Cauchy(1,1)= (0.5*9.81*100)/((0.025^2) - ((0.025-2*0.002)^2))
%Cauchy(2,2)=BStress(0.5*100*9.81*0.250,0.0125,IST(0.025,0.002))