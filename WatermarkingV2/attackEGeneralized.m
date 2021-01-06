function [precisionE,precisionER,loss1e,loss2e] = attackEGeneralized(precision,precisionr,sharedDataSoFar,wlens,w,colabs,c,vars,personalData,freqs)
    precisionE = precision;
    precisionER = precisionr;
    sps = size(sharedDataSoFar,1);
    %Use generated unique colab sets (combination(20,2)) for each colabs
    if colabs ~= 1
        load(['data/colabSet' num2str(colabs(c)) '.mat']);
        attackDatas = generateCollusionAttackDatas(sharedDataSoFar,colabSet,wlens(w),vars);
    else
        colabSet = randi(20,[190 1]);
        attackDatas = generateSingleSpAttackDatas(sharedDataSoFar,colabSet,wlens(w),vars);
    end
    %attackDatas = generatePartialRemovalAttackDatas(sharedDataSoFar,colabSet,wlens(w)*3.0,vars);
    for i = 1:size(attackDatas,1)
        confData = sharedDataSoFar == attackDatas(i,:);
        confData = [1:size(sharedDataSoFar,2); confData];
        j = sps;
        while j > 0
            if sum(confData(2:end,j)) > sps-3 %Minor differences does not help
                confData(:,j) = [];
            end
            j = j-1;
        end 
        confData(2:end,:) = sharedDataSoFar(:,confData(1,:));
        variance = [confData(1,:); var(confData(2:end,:),0,1)]';
        variance = sortrows(variance,2,'descend')';
        spPenalizer = [1:sps; zeros([1 sps])];
        for j = 1:size(variance,2)
            index = variance(1,j);
            spPenalizer(2,:) = spPenalizer(2,:) + variance(2,j).*(sharedDataSoFar(:,index)'==attackDatas(i,index));
        end
        spPenalizer = sortrows(spPenalizer',2,'descend');
        precisionE(c,w) = precisionE(c,w) + 1 - size(setdiff(colabSet(i,:),spPenalizer(1:colabs(c),1)'),2)/colabs(c); %+1
        precisionER(c,w) = precisionER(c,w) + 1 - size(setdiff(colabSet(i,:),spPenalizer(1:colabs(c)+1,1)'),2)/colabs(c); %+1
    end
    loss1e = calculateUtilityLoss(attackDatas,personalData,freqs);
    loss2e = calculateUtilityLoss2(attackDatas,personalData);
end

