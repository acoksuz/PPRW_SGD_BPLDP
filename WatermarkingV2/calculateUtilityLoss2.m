function [utilityLoss2] = calculateUtilityLoss2(sharedDataSoFar,personalData)

%This method calculates the average utility loss caused by the change of
%status for each SP during watermark embedding. It employs the KING kinship
%coefficient.

    sps = size(sharedDataSoFar,1);
    dataSize = size(sharedDataSoFar,2);
    utilityLossCoefs = zeros([sps 1]);
    
    for i = 1:sps
        n_11 = 0;
        n_02 = 0;
        n_20 = 0;
        n_1s = 0;
        n_s1 = 0;
        for j = 1:dataSize
            if personalData(j) == 0
                if sharedDataSoFar(i,j) == 1
                    n_s1 = n_s1 + 1;
                elseif sharedDataSoFar(i,j) == 2
                    n_02 = n_02 + 1;
                end
            elseif personalData(j) == 1
                n_1s = n_1s + 1;
                if sharedDataSoFar(i,j) == 1
                    n_11 = n_11 + 1;
                    n_s1 = n_s1 + 1;
                end
            elseif personalData(j) == 2 %There is no other case but just to make sure ;)
                if sharedDataSoFar(i,j) == 0
                    n_20 = n_20 + 1;
                elseif sharedDataSoFar(i,j) == 1
                    n_s1 = n_s1 + 1;
                end
            end                   
        end
        utilityLossCoefs(i) = (2*n_11 - 4*(n_02 + n_20) - n_s1 + n_1s) / (4*n_1s);
    end
    
    utilityLoss2 = mean(utilityLossCoefs);
end

