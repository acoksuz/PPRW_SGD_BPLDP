function [data,wmFlag] = watermark(personalData, atks, wScore, watermarkLength)
    j = 1;
    k = 0;
    data = personalData';
    wmFlag = -1*ones([size(personalData,1) 1]);
    while(k < watermarkLength)
        rr = rand();
        if rr <= wScore(j,1) 
            t = wScore(j,2);                    %Current index which we work on
            temp2 = personalData(t)+1;          %Finding the index of our actual state (0,1,2) + 1
            %{
            condition1 = (atks(t,1)*(1-vars(t,1)))/(vars(t,1)*(1-atks(t,1)));
            condition2 = (atks(t,2)*(1-vars(t,2)))/(vars(t,2)*(1-atks(t,2)));
            condition3 = (atks(t,3)*(1-vars(t,3)))/(vars(t,3)*(1-atks(t,3)));
            cond = [condition1 condition2 condition3];
            cond(isnan(cond)) = 0;
            cond = exp(difPriCoef) >= cond;
            %}
            flag = 1;
            while(flag)
                %if sum(cond) ~= 3
                    rr = rand();                        %Random response is produced
                    if atks(t,1) >= rr %&& cond(1)
                        data(t) = 0;
                        if temp2 ~= 1
                            k = k + 1;
                        end
                        flag = 0;
                    elseif atks(t,1)+atks(t,2) >= rr && rr > atks(t,1) %&& cond(2)
                        data(t) = 1;
                        if temp2 ~= 2
                            k = k + 1;
                        end
                        flag = 0;
                    elseif atks(t,1)+atks(t,2) < rr %&& cond(3)
                        data(t) = 2;
                        if temp2 ~= 3
                            k = k + 1;
                        end
                        flag = 0;
                    end
                %{    
                else
                    rr = rand();                        %Random response is produced
                    if atks(t,1) >= rr
                        data(t) = 0;
                        if temp2 ~= 1
                            k = k + 1;
                        end
                    elseif atks(t,1)+atks(t,2) >= rr && rr > atks(t,1)
                        data(t) = 1;
                        if temp2 ~= 2
                            k = k + 1;
                        end
                    elseif atks(t,1)+atks(t,2) < rr
                        data(t) = 2;
                        if temp2 ~= 3
                            k = k + 1;
                        end
                    end
                    flag = 0;
                end
                %}
            end
            if j == length(personalData)
                j = 1;
            else
                j = j + 1;
            end
        else
            if j == length(personalData)
                j = 1;
            else
                j = j + 1;
            end
        end
    end
end

