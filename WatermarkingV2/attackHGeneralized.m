function [precisionH,precisionHR] = attackHGeneralized(precision,precisionr,sharedDataSoFar,SPs,wlens,w,colabs,c,vars)
    precisionH = precision;
    precisionHR = precisionr;
    lsp = length(SPs);
    %Use generated unique colab sets (combination(20,2)) for each colabs
    if colabs ~= 1
        load(['data/colabSet' num2str(colabs(c)) '.mat']);
        attackDatas = generateCollusionAttackDatas(sharedDataSoFar,colabSet,wlens(w),vars);
    else
        colabSet = randi(20,[190 1]);
        attackDatas = generateSingleSpAttackDatas(sharedDataSoFar,colabSet,wlens(w),vars);
    end
    confTableH = [];
    for i = 1:size(attackDatas,1)
        H_distance = zeros([lsp 2]);
        H_distance(:,1) = 1:lsp;
        for m = 1:lsp
            H_distance(m,2) = pdist2(attackDatas(i,:),sharedDataSoFar(m,:),'hamming');
        end
        confTableH = [sortrows(H_distance,2) confTableH]; %each table is added to the left of the list as the test progresses
        %if size(setdiff(colabSet(i,:),confTableH(1:colabs(c),1)'),2) == 0
            precisionH(c,w) = precisionH(c,w) + 1 - size(setdiff(colabSet(i,:),confTableH(1:colabs(c),1)'),2)/colabs(c); %+1
            precisionHR(c,w) = precisionHR(c,w) + 1 - size(setdiff(colabSet(i,:),confTableH(1:colabs(c)+1,1)'),2)/colabs(c); %+1
        %elseif size(setdiff(colabSet(i,:),confTableH(1:colabs(c)+2,1)'),2) == 0
        %    precisionHR(c,w) = precisionHR(c,w) + 1;
        %end
    end
end

