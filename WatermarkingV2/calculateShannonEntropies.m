function [entropy] = calculateShannonEntropies(vars)
    entropy = zeros([length(vars) 1]);
    for i = 1:length(vars)
        u1 = vars(i,1)*log(vars(i,1));
        u2 = vars(i,2)*log(vars(i,2));
        u3 = vars(i,3)*log(vars(i,3));
        unit = [u1 u2 u3];
        unit(isnan(unit))=0;
        entropy(i) = -(sum(unit))/log(3);
    end
end

