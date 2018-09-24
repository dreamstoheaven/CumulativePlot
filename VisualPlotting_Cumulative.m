% 6s ~ 300s, 30min window size, 25min overlap.
[spect,f,t,ps,fc] = spectrogram(w_m(1,:) - mean(w_m(1,:)),hann(1800),1500,[],1,'yaxis'); 


sumpower6_300s = [];

% 6 sec ~ 16 sec
for i = 1:length(t)
    sumpower6_300s(4,i) = sum(ps(129:324,i));
    sumpower6_300s(3,i) = sum(ps(42:128,i));
    sumpower6_300s(2,i) = sum(ps(19:41,i));
    sumpower6_300s(1,i) = sum(ps(7:18,i));
end

[tt1,freqband1] = meshgrid(t,[1;2;3;4]);

figure
ax1 = subplot(2,1,1);
TransSumpower6_300s = transpose(sumpower6_300s);
ar6_300s = area(TransSumpower6_300s, 'LineStyle', 'none');
set(ar6_300s, 'XData', t/86400);
axis([0,w_T_m(end),-inf,max(sumpower6_300s(:))/5]);
xlabel('Days')
legend(  '106~300s','51~105s','17~50s','6~16s');
ylabel('Power, raw')
title('Cumulative plot, 30min windows with 25min overlap, Baby 1127');

ax2 = subplot(2,1,2);
plot((w_T_m-w_T_m(1)),w_m(1,:));
axis([-inf,inf,0,100]);
title('Blood Pressure, Baby 1127')


%% 5min ~ 30min, 5h window size, 4.5h overlap.
[spect2,f2,t2,ps2,fc2] = spectrogram(w_m(1,:) - mean(w_m(1,:)),hann(18000),17700,[],1,'yaxis'); 


sumpower5_30m = [];

% 6 sec ~ 16 sec
for i = 1:length(t2)
    sumpower5_30m(3,i) = sum(ps2(55:100,i));
    sumpower5_30m(2,i) = sum(ps2(28:54,i));
    sumpower5_30m(1,i) = sum(ps2(17:27,i));
end

[tt2,freqband2] = meshgrid(t2,[1;2;3]);

figure
ax1 = subplot(2,1,1);
TransSumpower5_30m = transpose(sumpower5_30m);
ar5_30m = area(TransSumpower5_30m, 'LineStyle', 'none');
set(ar5_30m, 'XData', t2/86400);
axis([0,w_T_m(end),-inf,inf]);
xlabel('Days')
legend('20~30min','10~20min','5~10min' );
ylabel('Power, raw')
title('Cumulative plot, 5h windows with 4h55min overlap, Baby 1127');

ax2 = subplot(2,1,2);
plot((w_T_m-w_T_m(1)),w_m(1,:));
axis([-inf,inf,0,100]);
title('Blood Pressure, Baby 1127')

%% 30min ~ 3h, 12h window size, 11.5h overlap.
[spect3,f3,t3,ps3,fc3] = spectrogram(w_m(1,:) - mean(w_m(1,:)),hann(43200),41400,[],1,'yaxis'); 


sumpower30_3h = [];

% 6 sec ~ 16 sec
for i = 1:length(t3)
    sumpower30_3h(3,i) = sum(ps2(19:34,i));
    sumpower30_3h(2,i) = sum(ps2(10:18,i));
    sumpower30_3h(1,i) = sum(ps2(7:9,i));
end

[tt3,freqband3] = meshgrid(t3,[1;2;3]);

figure
ax1 = subplot(2,1,1);
TransSumpower30_3h = transpose(sumpower30_3h);
ar30_3h = area(TransSumpower30_3h, 'LineStyle', 'none');
set(ar30_3h, 'XData', t3/86400);
axis([0,w_T_m(end),-inf,inf]);
xlabel('Days')
legend('2~3h','1~2h','30~60min');
ylabel('Power, raw')
title('Cumulative plot, 12h windows with 11.5h overlap, Baby 1127');

ax2 = subplot(2,1,2);
plot((w_T_m-w_T_m(1)),w_m(1,:));
axis([-inf,inf,0,100]);
title('Blood Pressure, Baby 1127')

%% Putting everything together
TransSumpower_all = [];

start_1 = find(t == t2(1));
end_1 = find(t ==t2(end));

start_2 = find(t == t3(1));
end_2 = find(t == t3(end));

TransSumpower_all(1:start_2-1,1:3) = 0;
TransSumpower_all(1:start_1-1,4:6) = 0;

TransSumpower_all(start_2:end_2,1:3) = resample(TransSumpower30_3h, (end_2 - start_2 +1),length(TransSumpower30_3h(:,1)));
TransSumpower_all(start_1:end_1,4:6) = resample(TransSumpower5_30m, (end_1 - start_1 +1),length(TransSumpower5_30m(:,1)));
TransSumpower_all(1:length(TransSumpower6_300s(:,1)),7:10) = TransSumpower6_300s;


figure
ax1 = subplot(2,1,1);
ar_all = area(TransSumpower_all, 'LineStyle', 'none');
set(ar_all, 'XData', t/86400);
axis([0,w_T_m(end),-inf,inf]);
xlabel('Days')
legend('2~3h','1~2h','30~60min','20~30min','10~20min','5~10min','106~300s','51~105s','17~50s','6~16s');
ylabel('Power, raw')
title('Cumulative plot, Baby 1127');

ax2 = subplot(2,1,2);
plot((w_T_m-w_T_m(1)),w_m(1,:));
axis([-inf,inf,0,100]);
title('Blood Pressure, Baby 1127')