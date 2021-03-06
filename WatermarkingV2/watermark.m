function [data,wmFlag] = watermark(personalData, atks, wScore, watermarkLength)
    j = 1;
    k = 0;
    data = personalData';
    wmFlag = -1*ones([size(personalData,1) 1]);
    while(k < watermarkLength)
        t = wScore(j,2);                    %Current index which we work on
        temp = personalData(t);          %Finding the index of our actual state (0,1,2) + 1
        rr = rand();
        if atks(t,1) >= rr && wmFlag(t) == -1 && temp ~= 0
            data(t) = 0;
            k = k + 1;
            wmFlag(t) = 0;
        elseif atks(t,1)+atks(t,2) >= rr && rr > atks(t,1) && wmFlag(t) == -1 && temp ~= 1
            data(t) = 1;
            k = k + 1;
            wmFlag(t) = 1;
        elseif atks(t,1)+atks(t,2) < rr  && wmFlag(t) == -1 && temp ~= 2
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

