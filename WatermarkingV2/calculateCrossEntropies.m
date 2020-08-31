function [entropy] = calculateCrossEntropies(vars,freqs)
    entropy = zeros([length(vars) 1]);
    for i = 1:length(vars)
       entropy(i) = -(vars(i,1)*log(freqs(i,1))+vars(i,2)*log(freqs(i,2))+vars(i,3)*log(freqs(i,3)))/log(3);
    end
    entropy(isnan(entropy))=0;
end