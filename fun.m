function Default=fun(n,Y,X,aMINUSv,Epsilon)
% Set Parameters:
b=0:0.1:Epsilon;
Default=0.0
% if bank 1 cash - aMINUSv - is smaller then the negative shock - Epsilon,
% bank 1 will return bank 2 only what is left after the shock.
X(1) = min(Y(1,2),Y(1,2)+ aMINUSv(1)- Epsilon(end))
if aMINUSv(1)< Epsilon(end)
    Default = Default + 1
end
% if bank 1's shock is larger than the excess liquidity, bank 1 returns
% less than Y to bank 2, and so it defaults.
%for b=0:length(Epsilon)
    % For every bank after the bank who was shocked, it will return either Y or
    % what the bank before in the chain returned him + aMINUSv (his own cash).
    for c=2:n
          X(c) = min (Y(c,c+1),X(c-1)+aMINUSv(c))
            if X(c-1)+aMINUSv(c)<Y(c,c+1)
            Default = Default + 1
            end
        end
    % if the bank before him returned him less than what he borrowed to him, 
    % the bank defaults.
end
   
    