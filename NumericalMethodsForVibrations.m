
% Date: 22 - 3 -2106
% Purpose: To compute Exact, Newmark and Central Difference solutions
% Notes: ALL UNITS IN SI
%**************************************************************************%


close all
clc

m = 30;
width = 1;
height = 2.5;
thickness = 0.03;   
I = 1/3 * m * width^2;
c = 10;
k_intial = 650;
k_extra = 1360;
M_friction = 3.7;
M_external = 26.67;
f = M_external - M_friction;  %constant wind
x0 = 0.5*pi();
v0 = 0;
t_tot = 10;
dt = 0.01; %euler  unstable...use smaller dt
Beta = 0.25;
Gamma = 0.5;


t_vector = 0:dt:t_tot;
t_steps = size(t_vector,2); %keep vectors same same size for plotting (SIZE of columns)

%************************************************************************************************%
%Central Differnce
%************************************************************************************************%
CDx_vector = zeros(size(t_vector));

CDv_vector = CDx_vector;
CDa_vector = CDx_vector;

CDx_vector(1) = x0;

CDv_vector(1)= v0;
CDa_vector(1) = 0;   %initial acceleration vector for finding x(-1)
%includes damping but only for first vecto

 if x0 > 1.91
    k = k_intial + k_extra;
 else
      k = k_intial;       %restore k if x goes below upper bound 
 end
        

a_minus1 = (f - c*v0 - k*x0)/I;
Divisor = (I/(dt^2))+ (c/(2*dt));
x_minus1 = x0 - (dt * v0) + ((dt^2)/2) * a_minus1;
kr = CDx_vector;
fr = CDx_vector;
%i=1  is t = 0
for i= 1: t_steps-1 %going to plus 1 so i reaches t_steps
   if i == 1
        if v0 < 0
            M_friction = -M_friction;
            f = M_external - M_friction;
        end
        if x_minus1 > 1.91
            k = k_intial + k_extra;
        else
            k = k_intial;       %restore k if x goes below upper bound 
        end
        kr(i) = k;
        fr(i) = M_friction;
        CDx_vector(i+1) = ((I/((dt)^2))*(2*CDx_vector(i) - x_minus1) + ((c/(2*dt))* x_minus1) - (k*CDx_vector(i)) + (f+ M_friction))/Divisor;
        %velocity and accelration already defined as v0 and a0
        %respectiveley
        
   else
        if (CDv_vector(i-1)+(CDa_vector(i-1)*dt)) < 0
            M_friction = -M_friction;
          f = M_external - M_friction;
        end
        
        if CDx_vector(i) > 1.91
            k = k_intial + k_extra;
        else
            k = k_intial;       %restore k if x goes below upper bound 
        end
        kr(i) = k;
        fr(i) = M_friction;
        CDx_vector(i+1) = ((I/((dt)^2))*(2*CDx_vector(i) - CDx_vector(i-1)) + ((c/(2*dt))* CDx_vector(i-1)) - (k*CDx_vector(i)) + (f+ M_friction))/Divisor;
        CDv_vector(i) = (CDx_vector(i+1) - CDx_vector(i-1))/(2*dt);
        CDa_vector(i) = (CDx_vector(i+1) - 2*CDx_vector(i) + CDx_vector(i-1))/(dt^2);
        
   end
    

end  %only use future timestep for x vector!!!!


%************************************************************************************************%
%Newmark
%******************************************************************************%

NMx_vector = zeros(size(t_vector));
NMv_vector = NMx_vector;
NMa_vector = NMx_vector;
NMx_vector(1) = x0;
NMv_vector(1)= v0;

 if x0 > 1.91
    k = k_intial + k_extra;
 else
      k = k_intial;       %restore k if x goes below upper bound 
 end
     
NMa_vector(1) = (f - c*v0 - k*x0)/I;   %initial acceleration vector for finding x(-1)
%includes damping but only for first vecto

A = (I/Beta)*(0.5 - Beta) + ((c*dt)*((Gamma/(2*Beta)) - 1));
B = (I/(Beta*dt)) + c*((Gamma/Beta)-1);
C = (I/(Beta*(dt^2))) + ((c*Gamma)/(Beta*dt));

% i =1 represents t = 0 
for i= 1: t_steps-1 %going to plus 1 so i reaches t_steps
      
       
        NMx_vector(i+1) = (f + A*NMa_vector(i)+B*NMv_vector(i) + C*NMx_vector(i))/(C+k);
      
        if NMv_vector(i) < 0
            M_friction = -M_friction;
           f = M_external - M_friction;
        end
        if NMx_vector(i) > 1.91
            k = k_intial + k_extra;
        else
            k = k_intial;       %restore k if x goes below upper bound 
        end
               
        NMa_vector(i+1) = (NMx_vector(i+1) - NMx_vector(i) - (dt*NMv_vector(i)) - ((dt^2)*(0.5 - Beta)*NMa_vector(i)))/(Beta*(dt^2));
        %a needs to be done first
        NMv_vector(i+1) = NMv_vector(i)+ dt*((1-Gamma)*NMa_vector(i) + Gamma*NMa_vector(i+1));
             
   

end  %only use future timestep for x vector!!!!

%******************************************************************************************************************************%
%Exact solution for underdamped systems
wn  = sqrt(k/I);                    %natural frequency
zeta = c/(2*I*wn);
wd = (sqrt((1-(zeta^2))))*wn;       %natural frequency

Exact_solution = (x0.*cos(wd.*t_vector) + ((v0 + x0*zeta*wn)/wd).*sin(wd.*t_vector) ).*exp(-zeta*wn.*t_vector);
%returns vectors of results which can then be plotted



%*******************************************************************************************************************************%
%GRAPHING
%*******************************************************************************************************************************%

Upper_limit_back_check = 2.27*ones(length(t_vector));
Lower_limit_back_check = 1.91*ones(length(t_vector));
Upper_limit_negative_back_check = -2.27*ones(length(t_vector));
Lower_limit_negative_back_check = -1.91*ones(length(t_vector));
Upper_limit_closed= 0.03*ones(length(t_vector));
Lower_limit_closed= -0.03*ones(length(t_vector));
plot(t_vector, CDx_vector, t_vector,NMx_vector,t_vector,Exact_solution,t_vector,Upper_limit_closed,'g--',t_vector,Lower_limit_closed,'g--'...
  ,t_vector,Upper_limit_back_check,'r--',t_vector,Lower_limit_back_check,'r--',t_vector,Upper_limit_negative_back_check,'r--',t_vector,Lower_limit_negative_back_check,'r--') %, t_vector,fr, t_vector,kr )
legend('Central Difference','Newmark','Exact','\pm 0.03')
title(['t vs x for k =' num2str(k) ' Nm/rad and c = ' num2str(c) 'Nm/s rad and \Deltat = ' num2str(dt) 's'] )
xlabel('t(seconds)')
ylabel('x(\theta)')



