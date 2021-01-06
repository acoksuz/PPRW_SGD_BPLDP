function [data,wmFlag] = watermark2(personalData, atks, wScore, watermarkLength, sharedDataSoFar)
    j = 1;
    k = 0;
    sps = size(sharedDataSoFar,1);
    data = personalData';
    wmFlag = -1*ones([size(personalData,1) 1]);
    while(k < watermarkLength)
        t = wScore(j,2);                 %Current index which we work on
        temp = personalData(t);          %Finding the index of our actual state (0,1,2) + 1
        rr = rand();
        if atks(t,1) >= rr && wmFlag(t) == -1 && temp ~= 0 && ((sum(sharedDataSoFar(:,t) == 0)) ~= sps)
            data(t) = 0;
            k = k + 1;
            wmFlag(t) = 0;
        elseif atks(t,1)+atks(t,2) >= rr && rr > atks(t,1) && wmFlag(t) == -1 && temp ~= 1  && ((sum(sharedDataSoFar(:,t) == 1)) ~= sps)
            data(t) = 1;
            k = k + 1;
            wmFlag(t) = 1;
        elseif atks(t,1)+atks(t,2) < rr  && wmFlag(t) == -1 && temp ~= 2  && ((sum(sharedDataSoFar(:,t) == 2)) ~= sps)
            data(t) = 2;
            k = k + 1;
            wmFlag(t) = 2;
        end
        if j == length(personalData)
            j = 1;
        else
            j = j + 1;
        end
    end
end


