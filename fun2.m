function NDefaults=fun2(Epsilon,Default)
index=0
d_index=1
while index<Default
    while d_index < (index+1)*10
        NDefaults(d_index)=index
        d_index=d_index+1
    end
index=index+1
end
while d_index <= length(Epsilon)
        NDefaults(d_index)=index
        d_index=d_index+1
end
end
