function [cmx] = createCrrMatrix(corr, cList) %Creates a correlation index matrix
    cmx = -1*ones(length(cList)+1);
    cmx(2:end,1) = cList';
    cmx(1,2:end) = cList;
    i = 1;
    xInd = 2;
    yInd = 2;
    a = corr(i,1);
    b = corr(i,2);
    while (i <= length(corr) && xInd <= length(cmx))
        if (yInd <= length(cmx))
            if(cmx(xInd,1)==a && cmx(1,yInd)==b)
                cmx(xInd,yInd) = i;
                i = i+1;
                if(i <= length(corr))
                    a = corr(i,1);
                    b = corr(i,2);
                end
                %fprintf("%d, %d\n", a, b);
            end    
            yInd = yInd + 1;
        else
            xInd = xInd + 1;
            yInd = 2;
        end
    end
end