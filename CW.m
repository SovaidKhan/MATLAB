F = 0.5 * 100 * 9.81; %two welds
M = F * 0.243;
d = 0.028
y = d/2;

A = 0.707*pi()*d
V = F/A
I = 0.707*(pi()*((d/2)^3)/2)
B = (M*y)/I
T = ((B/2)^2+ V^2)^0.5
SS = 128e06
n = 2.5
Allowable = SS/n
h = C/Allowable
t = h/0.8