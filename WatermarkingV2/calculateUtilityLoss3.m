function [utilityLoss3] = calculateUtilityLoss3(sharedDataSoFar,personalData,MAFs)
    sps = size(sharedDataSoFar,1);
    dataSize = size(sharedDataSoFar,2);
    wIndices = zeros([6 dataSize]);
    shMod = [sharedDataSoFar; personalData'];
    for i = 1:dataSize
        if ~all(diff(shMod(:,i)) == 0)
            wIndices(1,i) = i;
            wIndices(2,i) = sum(sharedDataSoFar(:,i) == 0);
            wIndices(3,i) = sum(sharedDataSoFar(:,i) == 1);
            wIndices(4,i) = sum(sharedDataSoFar(:,i) == 2);
            if wIndices(2,i) ~= sps && wIndices(3,i) ~= sps && wIndices(4,i) ~= sps
                wIndices(5,i) = (wIndices(3,i) + 2*wIndices(4,i))/(2*sps);
                if personalData(i) == 0
                    wIndices(6,i) = (sps - wIndices(2,i))/sps;
                elseif personalData(i) == 1
                    wIndices(6,i) = (sps - wIndices(3,i))/sps;
                elseif personalData(i) == 2
                    wIndices(6,i) = (sps - wIndices(4,i))/sps;
                end
            end
        end
    end
    wIndices(:,wIndices(5,:)==0)=[];
    utilityLoss3 = abs(MAFs(wIndices(1,:))'-wIndices(5,:));
end

