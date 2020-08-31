clc;
clear all;
maf = 0:0.01:0.5;
x_i = 0:0.01:1;
%{
u_gain_part1 = maf;
u_gain_part2 = maf;
u_gain_part3 = x_i;
u_gain_part4 = x_i;
u_gain_part5 = zeros([length(maf) length(x_i)]);
u_gain_part6 = zeros([length(maf) length(x_i)]);
%}
[X, Y] = meshgrid(maf, x_i);
u_gain_part1 = 1-X.^2.+X;
u_gain_part2 = exp(u_gain_part1);
u_gain_part3 = (1+cos(pi*Y))/2;
u_gain_part4 = (1+cos(pi*(1-Y)))/2;
u_gain_part5 = log(u_gain_part2 + u_gain_part3);
u_gain_part6 = log(u_gain_part2 + u_gain_part4);

%{
for i = 1:length(maf)
    u_gain_part1(i) = 1-maf(i)^2+maf(i);
    u_gain_part2(i) = exp(u_gain_part1(i));
end
for i = 1:length(x_i)
    u_gain_part3(i) = (1+cos(pi*x_i(i)))/2;
    u_gain_part4(i) = (1+cos(pi*(1-x_i(i))))/2;
end
for i = 1:length(maf)
    for j = 1:length(x_i)
        u_gain_part5(i,j) = log(u_gain_part2(i) + u_gain_part3(j));
        u_gain_part6(i,j) = log(u_gain_part2(i) + u_gain_part4(j));
    end
end
%}

figure
yyaxis left
plot(maf,u_gain_part1)
xlabel('MAF (Minor Allele Frequency)')
ylabel('Utility Formula 1-2, First half (without e)')

yyaxis right
plot(maf,u_gain_part2)
ylabel('Utility Formula 1-2, First half (with e)')

figure
plot(x_i,u_gain_part3)
xlabel('Possible x_i Values')
ylabel('Utility Formula 1, Second Half (x_i is the actual state)')

figure
plot(x_i,u_gain_part4)
xlabel('Possible x_i Values')
ylabel('Utility Formula 2, Second Half (x_i is not the actual state)')

figure
surf(maf,x_i,u_gain_part5)
xlabel('MAF (Minor Allele Frequency)')
ylabel('Possible x_i Values')
zlabel('Utility Formula 1')

figure
surf(maf,x_i,u_gain_part6)
xlabel('MAF (Minor Allele Frequency)')
ylabel('Possible x_i Values')
zlabel('Utility Formula 2')


