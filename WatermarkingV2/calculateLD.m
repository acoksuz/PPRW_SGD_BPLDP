clear;
clc;
close all;
load('population.mat');
data = FileData;
lds = zeros(7690,5);
cutoff = 0.7; % 49 percent variance explained
ind = 1;
for i = 1:1000
    %fprintf('I on %d\n',i);
    for j = i+1:1000
        for a = 0:2
            for b =0:2
                corr = (sum(data(i,:)==a & data(j,:)==b))/99;
                if( corr > cutoff & i~=j)
                    lds(ind,:) = [i,j,corr,a,b];
                    ind = ind +1;
                end
            end
        end
    end        
end
correlations = lds(1:ind-1,:);
save('correlations2.mat','correlations');