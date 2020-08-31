function [distribution,results] = calculateAttackDistributionFromVar(vars,sharedDataSoFar,sp,dataSize)
    distribution = vars;
    results = zeros([dataSize 3]);
    for i = 1:dataSize
        nZero = sum(sharedDataSoFar(1:sp-1,i)==0);
        nOne = sum(sharedDataSoFar(1:sp-1,i)==1);
        nTwo = sum(sharedDataSoFar(1:sp-1,i)==2);
        distribution(i,1) = nchoosek(sp-1,nZero)*(vars(i,1))^nZero*(1-vars(i,1))^(sp-nZero-1)*vars(i,1);
        distribution(i,2) = nchoosek(sp-1,nOne)*(vars(i,2))^nOne*(1-vars(i,2))^(sp-nOne-1)*vars(i,2);
        distribution(i,3) = nchoosek(sp-1,nTwo)*(vars(i,3))^nTwo*(1-vars(i,3))^(sp-nTwo-1)*vars(i,3);
        distribution(i,:) = distribution(i,:)./norm(distribution(i,:),1);
        results(i,:) = [nZero nOne nTwo];
    end
end

