function [attackDatas] = generateSingleSpAttackDatas(sharedDataSoFar,colabSet,w,vars)
    lenSD = length(sharedDataSoFar);
    attackDatas = zeros([length(colabSet) lenSD]);
    for i = 1:length(colabSet)
        attackDatas(i,:) = sharedDataSoFar(colabSet(i),:);
        remaining = w;
       
        stdList = zeros([lenSD 2]);
        stdList(:,1) = 1:lenSD;
        for j = 1:lenSD
            stdList(j,2) = vars(j,attackDatas(i,j)+1);
        end
        stdList = sortrows(stdList,2,'ascend');
        
        temp = 1;
        while remaining > 0 && temp <= length(stdList)
            [a,b] = max(vars(stdList(temp,1),:));
            if attackDatas(i,stdList(temp,1)) ~= b-1
                x = rand();
                if x < 1 - stdList(temp,2)
                    attackDatas(i,stdList(temp,1)) = b-1;
                    remaining = remaining - 1;
                end
            end
            temp = temp + 1;
        end
    end    
end

