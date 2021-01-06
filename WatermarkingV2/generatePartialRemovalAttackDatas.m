function [attackDatas] = generatePartialRemovalAttackDatas(sharedDataSoFar,colabSet,w,vars)
    dataSize = size(sharedDataSoFar,2);
    attackDatas = zeros([length(colabSet) dataSize]);
    wIndices = zeros([5 dataSize]);
    for j = 1:dataSize
        wIndices(1,j) = j;
        wIndices(2,j) = sum(sharedDataSoFar(:,j) == 0);
        wIndices(3,j) = sum(sharedDataSoFar(:,j) == 1);
        wIndices(4,j) = sum(sharedDataSoFar(:,j) == 2);
        r = [wIndices(2,j) wIndices(3,j) wIndices(4,j)];
        r = r/sum(r);
        u1 = r(1)*log(r(1));
        u2 = r(2)*log(r(2));
        u3 = r(3)*log(r(3));
        unit = [u1 u2 u3];
        unit(isnan(unit))=0;
        wIndices(5,j) = -(sum(unit))/log(3);
    end
    wIndices(:,wIndices(5,:)==0)=[];
    copy_wi = sortrows(wIndices',5,'ascend')';
    for i = 1:length(colabSet)
        attackDatas(i,:) = mode(sharedDataSoFar(colabSet(i,:),:));
        if size(copy_wi,2) >= w
            if size(colabSet(i,:),2) > 1
                for j = 1:w
                    attackDatas(i,copy_wi(1,j)) = -1;
                end
            end
        else
            remaining = w - size(wIndices,2);
            stdList = zeros([2 dataSize]);
            stdList(1,:) = 1:dataSize;
            for j = 1:dataSize
                stdList(2,j) = vars(j,attackDatas(i,j)+1);
            end
            stdList = sortrows(stdList',2,'ascend')';
            for j = 1:size(copy_wi,2)
                attackDatas(i,copy_wi(1,j)) = -1;
            end
            stdList(:,copy_wi(1,:)) = [];
            for j = 1:remaining
                attackDatas(i,stdList(1,j)) = -1;
            end
        end                
    end
end

