wlens = 10:10:100;
coefs = 0:0.1:1;
b = 1:9:91;
c = 1:11;
d = [31 33 35 37 39];
s = zeros([4 10]);
s(1,:) = p1_01(9,1:10);
s(2,:) = p1_01(9,11:20);
s(3,:) = p1_01(9,21:30);
s(4,:) = p1_01(9,31:40);
%s = p1_01(b,31:40);
%s = p1_01(91:99,31:40);
colabs = 2:10;

figure
a = plot(wlens,s);
grid on
title('Impact of Detection Method on Precision') %%Colab can be changed here
xlabel('Watermark Length')
ylabel('Precision')
%ylim([70 100])

a(1).Marker = 'o';
a(2).Marker = '+';
a(3).Marker = '*';
a(4).Marker = 'x';
%a(5).Marker = 's';
%a(6).Marker = 'd';
%a(7).Marker = '^';
%a(8).Marker = 'v';
%a(9).Marker = '>';
%a(10).Marker = '<';
%a(11).Marker = 'p';

%z = legend('$w_l=10$','$w_l=20$','$w_l=30$','$w_l=40$','$w_l=50$','$w_l=60$','$w_l=70$','$w_l=80$','$w_l=90$','$w_l=100$','Location','best') 
%l = legend('$\varepsilon=0$','$\varepsilon=0.1$','$\varepsilon=0.2$','$\varepsilon=0.3$','$\varepsilon=0.4$','$\varepsilon=0.5$','$\varepsilon=0.6$','$\varepsilon=0.7$','$\varepsilon=0.8$','$\varepsilon=0.9$','$\varepsilon=1$','Location','best'); 
%set([l y z],'interpreter','latex')
%legend('wLen = 10','wLen = 20','wLen = 30','wLen = 40','wLen = 50','wLen = 60','wLen = 70','wLen = 80','wLen = 90','wLen = 100','Location','best')
%legend('# of Malicious SPs = 2','# of Malicious SPs = 3','# of Malicious SPs = 4','# of Malicious SPs = 5','# of Malicious SPs = 6','# of Malicious SPs = 7','# of Malicious SPs = 8','# of Malicious SPs = 9','# of Malicious SPs = 10','Location','best')
legend('Hamming Distance (H)', 'Hamming Distance Relaxed (HR)', 'spPenalizer (E)', 'spPenalizer Relaxed (ER)', 'Location', 'best')
%legend('cEDP = 0', 'cEDP = 0.1', 'cEDP = 0.2', 'cEDP = 0.3', 'cEDP = 0.4', 'cEDP = 0.5', 'cEDP = 0.6', 'cEDP = 0.7', 'cEDP = 0.8', 'cEDP = 0.9', 'cEDP = 1', 'Location', 'best')