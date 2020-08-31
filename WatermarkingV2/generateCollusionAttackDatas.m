function [attackDatas] = generateCollusionAttackDatas(sharedDataSoFar,colabSet,w,vars)
    lenSD = length(sharedDataSoFar);
    attackDatas = zeros([length(colabSet) lenSD]);
    for i = 1:length(colabSet)
        attackDatas(i,:) = mode(sharedDataSoFar(colabSet(i,:),:));
        
        remaining = w - min(lenSD - (sum(attackDatas(i,:) == sharedDataSoFar(colabSet(i,:),:),2)));
        confIndices = sum((attackDatas(i,:) == sharedDataSoFar(colabSet(i,:),:)),1)/size(colabSet,2);
        confIndices = [1:lenSD; confIndices];
        confIndices(:,confIndices(2,:) ~= 1) = 0;
        
        stdList = zeros([lenSD 2]);
        stdList(:,1) = 1:lenSD;
        for j = 1:length(stdList)
            stdList(j,2) = std(vars(j,:));
        end
        stdList(confIndices(:,2)==0,:) = [];
        stdList(stdList(:,2) > 0.5,:) = [];
        stdList = sortrows(stdList,2,'ascend');
        
        temp = 1;
        while remaining > 0 && temp <= length(stdList)
            [a,b] = max(vars(stdList(temp,1),:));
            if attackDatas(i,stdList(temp,1)) ~= b
                attackDatas(i,stdList(temp,1)) = b;
                temp = temp + 1;
                remaining = remaining - 1;
            end
            temp = temp + 1;
        end
    end
end

