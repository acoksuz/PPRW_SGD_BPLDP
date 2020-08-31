utilityScoresFinal = zeros([11 10]);
for i = 1:size(utilityScoresFinal,1)
    load(['results/utilityScores_w10rr05_ldp' num2str(i-1) '.mat']);
    utilityScoresFinal(i,:) = sum(utilityScores,1)/20;
end