function [frequencies] = createFrequencies(mafs,datasize)
%UNTÝTLED2 Summary of this function goes here
%   Detailed explanation goes here
    frequencies = zeros([3 datasize]);
    for i = 1:datasize
       temp = 1 - mafs(i);
       frequencies(1,i) = temp*temp;
       frequencies(2,i) = 2*temp*mafs(i);
       frequencies(3,i) = mafs(i)*mafs(i);
    end
end

