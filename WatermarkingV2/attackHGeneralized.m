function [precisionH,precisionHR,loss1h,loss2h] = attackHGeneralized(precision,precisionr,sharedDataSoFar,wlens,w,colabs,c,vars,personalData,freqs)
    precisionH = precision;
    precisionHR = precisionr;
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
    confTableH = [];
    for i = 1:size(attackDatas,1)
        H_distance = zeros([sps 2]);
        H_distance(:,1) = 1:sps;
        for m = 1:sps
            H_distance(m,2) = pdist2(attackDatas(i,:),sharedDataSoFar(m,:),'hamming');
        end
        confTableH = [sortrows(H_distance,2) confTableH]; %each table is added to the left of the list as the test progresses
        precisionH(c,w) = precisionH(c,w) + 1 - size(setdiff(colabSet(i,:),confTableH(1:colabs(c),1)'),2)/colabs(c); %+1
        precisionHR(c,w) = precisionHR(c,w) + 1 - size(setdiff(colabSet(i,:),confTableH(1:colabs(c)+1,1)'),2)/colabs(c); %+1
    end
    loss1h = calculateUtilityLoss(attackDatas,personalData,freqs);
    loss2h = calculateUtilityLoss2(attackDatas,personalData);
end

