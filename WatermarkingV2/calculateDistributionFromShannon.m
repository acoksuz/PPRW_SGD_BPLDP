function [distributions] = calculateDistributionFromShannon(entropies, shannons, vars)
    distributions = zeros([length(entropies) 3]);
    for i = 1:length(entropies)
        a = shannons(abs(shannons(:,4)'-entropies(i))<0.05,1:end-1);
        distributions(i,:) = mean(a,1);
        distributions(i,:) = (distributions(i,:) + vars(i,:))/2;
        distributions(i,:) = distributions(i,:)./norm(distributions(i,:),1);
    end
end

