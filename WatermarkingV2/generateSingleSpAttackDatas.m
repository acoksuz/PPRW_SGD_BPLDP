function [attackDatas] = generateSingleSpAttackDatas(sharedDataSoFar,colabSet,w,vars)
    dataSize = size(sharedDataSoFar,2);
    attackDatas = zeros([length(colabSet) dataSize]);
    for i = 1:length(colabSet)
        attackDatas(i,:) = sharedDataSoFar(colabSet(i),:);
        remaining = w;
       
        stdList = zeros([dataSize 2]);
        stdList(:,1) = 1:dataSize;
        for j = 1:dataSize
            stdList(j,2) = vars(j,attackDatas(i,j)+1);
        end
        stdList(stdList(:,2) > 0.5,:) = [];
        stdList = sortrows(stdList,2,'ascend');
        
        temp = 1;
        while remaining > 0 && temp <= length(stdList)
            [a,b] = max(vars(stdList(temp,1),:));
            if attackDatas(i,stdList(temp,1)) ~= b-1
                x = rand();
                if x < 1 - stdList(temp,2)
                    attackDatas(i,stdList(temp,1)) = b-1; %-1 for removal simulation (also some lines must be commented)
                    remaining = remaining - 1;
                end
            end
            temp = temp + 1;
        end
    end    
end

