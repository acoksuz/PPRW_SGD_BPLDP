function [ phenotypes ] = createPhenotypes(phenoSize, cCheckList, family)
    err = 0;%0.000000001;
    rem  = (1 - err)/2;
    x = [1;1];
    while length(x) ~= length(unique(x))
        x = (size(family,2)-1).*rand(phenoSize,1)+1; %Size of family = dataSize
        x = ceil(x);
        x = sort(x);
    end
    phenotypes = cell(phenoSize,2);
    for y = 1:size(x)
        phenotypes(y,1) = {x(y)};
        %If the given index is member of correlation nodes
        if sum(ismember(x(y),cCheckList)) > 0
            if x(y) ~= 455 && x(y) ~= 808 && x(y) ~= 966
                phenotypes(y,2) = {[rem rem err]};
            else
                phenotypes(y,2) = {[err err rem*2]};
            end
        else
            if family(3,x(y)) ~= 2
                phenotypes(y,2) = {[rem rem err]};
            else
                phenotypes(y,2) = {[err err rem*2]};
            end
        end
    end
end
