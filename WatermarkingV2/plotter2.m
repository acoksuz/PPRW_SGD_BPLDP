wlens = 10:10:100;
epsilon = 0:0.1:1;
p = p1_01(5:9:95,11:20)';

figure
a = plot(epsilon,p);
grid on
title('Impact of \epsilon on Precision')
xlabel('\epsilon')
ylabel('Precision')

a(1).Marker = 'o';
a(2).Marker = '+';
a(3).Marker = '*';
a(4).Marker = 'x';
a(5).Marker = 's';
a(6).Marker = 'd';
a(7).Marker = '^';
a(8).Marker = 'v';
a(9).Marker = '>';
a(10).Marker = '<';
%a(11).Marker = 'p';

legend('w_l=10','w_l=20','w_l=30','w_l=40','w_l=50','w_l=60','w_l=70','w_l=80','w_l=90','w_l=100','Location','best')%,'NumColumns',2);
%lgd = legend('i = 1.0','i = 1.2','i = 1.4','i = 1.6','i = 1.8','i = 2.0','i = 2.2','i = 2.4','i = 2.6','i = 2.8','i = 3.0','Location','best','NumColumns',2);
%title(lgd)%,'w_l * i SNPs removed')
