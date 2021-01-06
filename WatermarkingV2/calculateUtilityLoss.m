function [utilityLoss] = calculateUtilityLoss(sharedDataSoFar,personalData,freqs)

%This method calculates the average utility loss caused by the change of
%status for each SP during watermark embedding.

    sps = size(sharedDataSoFar,1);
    dataSize = size(sharedDataSoFar,2);
    entropies = calculateShannonEntropies(freqs);
    wIndices = zeros([5 dataSize]);
    count = 1;
    shMod = [sharedDataSoFar; personalData'];
    for i = 1:dataSize
        if ~all(diff(shMod(:,i)) == 0)
            wIndices(1,count) = i;
            wIndices(2,count) = sum(sharedDataSoFar(:,i) == 0);
            wIndices(3,count) = sum(sharedDataSoFar(:,i) == 1);
            wIndices(4,count) = sum(sharedDataSoFar(:,i) == 2);
            wIndices(5,count) = (sps-wIndices(personalData(i)+2,count))*(entropies(i))/sps;
            count = count + 1;
        end
    end
    wIndices = wIndices(:,1:count-1);
    utilityLoss = 100*sum(wIndices(5,:))/sum(entropies);
end

