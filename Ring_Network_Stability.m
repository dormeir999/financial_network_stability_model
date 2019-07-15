% Ring_Network_Stability.m
% 1. Change the folder to where fun.m is:
% cd C:\Users\advice\Downloads
% 2. Set the number of banks in RING network
n = 20
% 3. Set the sum each n bank will borrow from bank n+1 
% and land to bank n-1
Loan_size = 30
% 4. Prepeare a landing RING network 
Y = eye(n+1,n+1)
Y = circshift(Y,-1)
Y = [Y; zeros(1,n+1)]
% 5. Set the sum each n bank will borrow from bank n+1 
% and land to bank n-1 
Y = Y*Loan_size
% 6. Define an array of size of money returned to the lander
X = sym('x',[1,n])
% 7. Set an initial liquidity of all banks in the network is 1:
aMINUSv = ones([1,n])
% 8. Calculate the size of excess liquidity in the network:
excess_liquidity = sum(aMINUSv)
% 9. Set the Shock size variable ('Epsilon'), default is 30:
Epsilon=0:0.1:(excess_liquidity+10)
% 10. Set a decimel number of Defaults parameter ('NDefaults'):
NDefaults=0:0.1:(excess_liquidity+10)
% 11. Zero the number of Defaults:
NDefaults=NDefaults*0
% 12. Hit the first bank with the Epsilon, and get the number of bank defaults:
Default=fun(n,Y,X,aMINUSv,Epsilon)
% 13. Get the number of defaults in the range of 0-Epsilon:
NDefaults=fun2(Epsilon,Default)
% 14. Plot the number of Defaults to size of shock
plot(Epsilon,NDefaults); title('The RING Financial Network Stability'); xlabel('Shock Size to one bank');ylabel('Number of defaulted banks');xlim([0 excess_liquidity+10]);ylim([0 excess_liquidity+10])
hold on
plot([1 20],[Default Default],'--')
set(gca,'YTick',Default)
%set(gca,'XTick',excess_liquidity)
hold off
% 15. Create a table of number of Defaults for the defined Epsilon, Export
% to Excel spreadsheet:
T=table(n,Loan_size,excess_liquidity,Epsilon(1),NDefaults(1),'VariableNames',{'Number_of_Banks','Loan_Size','Excess_Liquidity','Shock_Size','Defaulted_Banks'})
i=11
while (i-11)+10<length(Epsilon)
    Tnew = {n,Loan_size,excess_liquidity,Epsilon(i),NDefaults(i-10)};
    T = [T;Tnew];
    i=i+10
end
T
writetable(T,'RING_stability.xlsx')