%Utility calculation Script
clear;
clc;
close all;

load('data/population.mat');
load('data/MAFs.mat');
freqs = createFrequencies(MAFs,7690)';
data = FileData';
data = data';
data = [1:99; data];
data = data';

n_comp = 15;
n_people = size(data,1);
n_snp = size(data,2);

x = [1:7690; MAFs];
x = sortrows(x',2,'descend');
dataNew = data(:,x(1:n_comp,1));

logs = zeros([n_people 1]);

%for i = 1:n_people
%   for j = 1:n_snp
%       logs(i) = logs(i) + log(freqs(i,data(i,j)+1));
%   end
%end

%plot(1:99,logs)
