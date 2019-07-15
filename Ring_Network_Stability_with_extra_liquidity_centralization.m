% This script Does the same as Ring_Network_Stability.m,
% excepts it adds a big bank in the last place of the RING (point 8),
% representing the worst case scenerio of extra liquidity centralization

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
% 8. The last bank has an extra liquidity:
aMINUSv(n) = 28
% 9. Calculate the size of excess liquidity in the network:
excess_liquidity = sum(aMINUSv)
% 10. Set the Shock size variable ('Epsilon'), default is 30:
Epsilon=0:0.1:30
% 11. Set a decimel number of Defaults parameter ('NDefaults'):
NDefaults=0:0.1:30
% 12. Zero the number of Defaults:
NDefaults=NDefaults*0
% 13. Hit the first bank with the Epsilon, and get the number of bank defaults:
Default=fun(n,Y,X,aMINUSv,Epsilon)
% 14. Get the number of defaults in the range of 0-Epsilon:
NDefaults=fun2(Epsilon,Default)
% 15. Plot the number of Defaults to size of shock
plot(Epsilon,NDefaults); title('The RING Financial Centralized Extra Liquidity Network Stability'); xlabel('Shock Size to one bank');ylabel('Number of defaulted banks');xlim([0 30]);ylim([0 30])
hold on
nline = refline([0 n]);
nline.Color = 'r';
plot([1 20],[Default Default],'--')
set(gca,'YTick',Default)
hold off
% 16. Create a table of number of Defaults for the defined Epsilon, Export
% to Excel spreadsheet:
T=table(n,Loan_size,excess_liquidity,Epsilon(1),NDefaults(1),'VariableNames',{'Number_of_Banks','Loan_Size','Excess_Liquidity','Shock_Size','Defaulted_Banks'})
i=11
while (i-11)+10<length(Epsilon)
    Tnew = {n,Loan_size,excess_liquidity,Epsilon(i),NDefaults(i-10)};
    T = [T;Tnew];
    i=i+10
end
T
writetable(T,'RING_stability_with_liquidity_centralization.xlsx')