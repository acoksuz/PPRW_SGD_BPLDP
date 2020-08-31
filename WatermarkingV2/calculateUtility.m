function [normalScores, totalScore] = calculateUtility(personalData,sharedDataSoFar,MAFs,freqs)
    totalScore = 0;
    normalScores = zeros([size(sharedDataSoFar,1) 1]);
    for i = 1:length(personalData)
        utility = log(exp(1-MAFs(i)*MAFs(i)+MAFs(i))+(1+cos(pi*freqs(i,personalData(i)+1)))/2);
        totalScore = totalScore + utility;
        for j = 1:size(sharedDataSoFar,1)
            if personalData(i) == sharedDataSoFar(j,i)
                normalScores(j) = normalScores(j) + utility;
            end
        end    
    end
    normalScores = normalScores / totalScore * 100;
end

