for colab = 3:10
    colabSet = zeros([190 colab]);
    colabSet(1,:) = sort(randperm(20, colab)); % 20 = length(SPs), may change if wanted
    count = 1;
    while count < 190
        set = sort(randperm(20, colab));
        setDifferent = true; 
        for i = 1:count
            if sum(setdiff(set,colabSet(i,:))) == 0
                setDifferent = false;
                break;
            end
        end
        if setDifferent
            colabSet(count+1,:) = set;
            count = count + 1;
        end
    end
    saveFileName = ['data/colabSet' num2str(colab) '.mat'];
    save(saveFileName,'colabSet');
end
colabSet = zeros([190 2]);
count = 1;
for i = 1:20
    for j = i+1:20
        colabSet(count,2) = j;
        colabSet(count,1) = i;
        count = count+1;
    end
end
saveFileName = ['data/colabSet2.mat'];
save(saveFileName,'colabSet');        