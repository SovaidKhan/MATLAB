function [Fibnumbers] = Next200Fibonacci(Num1,Num2)
%Calculates the next 200 fibonacci numbers given two
n_0 = Num1;
n_1 = Num2;
Fibnumbers = [n_0 n_1];  %dynamic vector can also define it first as 200 long and 
                %then change elements
for i = 1:198   %the next 198 numbers
    y = n_1;
    n_1 = n_1 + n_0;
    n_0 = y;
    Fibnumbers = [Fibnumbers n_1];
end 

end

