function [precisionE,precisionER] = attackEGeneralized(precision,precisionr,sharedDataSoFar,SPs,wlens,w,colabs,c,vars)
    precisionE = precision;
    precisionER = precisionr;
    lsp = length(SPs);
    %Use generated unique colab sets (combination(20,2)) for each colabs
    if colabs ~= 1
        load(['data/colabSet' num2str(colabs(c)) '.mat']);
        attackDatas = generateCollusionAttackDatas(sharedDataSoFar,colabSet,wlens(w),vars);
    else
        colabSet = randi(20,[190 1]);
        attackDatas = generateSingleSpAttackDatas(sharedDataSoFar,colabSet,wlens(w),vars);
    end
    for i = 1:size(attackDatas,1)
        confData = sharedDataSoFar == attackDatas(i,:);
        confData = [1:size(sharedDataSoFar,2); confData];
        j = size(sharedDataSoFar,2);
        while j > 0
            if sum(confData(2:end,j)) > lsp-3 %Minor differences does not help
                confData(:,j) = [];
            end
            j = j-1;
        end 
        confData(2:end,:) = sharedDataSoFar(:,confData(1,:));
        variance = [confData(1,:); var(confData(2:end,:),0,1)]';
        variance = sortrows(variance,2,'descend')';
        spPenalizer = [1:lsp; zeros([1 lsp])];
        for j = 1:size(variance,2)
            index = variance(1,j);
            spPenalizer(2,:) = spPenalizer(2,:) + variance(2,j).*(sharedDataSoFar(:,index)'==attackDatas(i,index));
        end
        spPenalizer = sortrows(spPenalizer',2,'descend');
        %if size(setdiff(colabSet(i,:),spPenalizer(1:colabs(c),1)'),2) == 0
            precisionE(c,w) = precisionE(c,w) + 1 - size(setdiff(colabSet(i,:),spPenalizer(1:colabs(c),1)'),2)/colabs(c); %+1
            precisionER(c,w) = precisionER(c,w) + 1 - size(setdiff(colabSet(i,:),spPenalizer(1:colabs(c)+1,1)'),2)/colabs(c); %+1
        %elseif size(setdiff(colabSet(i,:),spPenalizer(1:colabs(c)+2,1)'),2) == 0
        %    precisionER(c,w) = precisionER(c,w) + 1;
        %end  
    end
end

