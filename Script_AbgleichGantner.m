clc; clear; close all;
load('Gantner_Manner_Vergleich_2023-08-23_12-45-27');
load('Logger1__0_2023-08-23_Allday');
time_manner = Channel10_time;
timeDMS = DMS1.XData;
begintime_manner = datetime(2023,08,23,12,45,27);
time_abs_manner = begintime_manner + seconds(time_manner);
tol     = 0.000001; % tolerance to use with the find function
%begintime_DMS = datetime(2023,08,23,11,03,18,779000);
%Timesync noch etwas angepasst
begintime_DMS = datetime(2023,08,23,10,50,18,779000);
time_abs_DMS = begintime_DMS + seconds(timeDMS);
Bolt1 = Channel9;
Bolt2 = Channel2;
Bolt3 = Channel11;
Bolt4 = Channel10;
% figure;
% plot(time_abs_manner, Bolt1);
% hold on; grid on ; grid minor;
% plot(time_abs_manner, Bolt2);
% plot(time_abs_manner, Bolt3);
% plot(time_abs_manner, Bolt4);
% plot(time_abs_DMS, DMS2.YData*1000);
%%
figure;
subplot(2,1,1);
plot(time_abs_manner, Bolt1);
hold on; grid on ; grid minor;
plot(time_abs_manner, Bolt2);
plot(time_abs_manner, Bolt3);
plot(time_abs_manner, Bolt4);
legend('Bolt1','Bolt2','Bolt3','Bolt4')
subplot(2,1,2);
plot(time_abs_DMS, DMS2.YData);
ylim([-0.25, 0.25]);
legend('Gantner')
%% Telemetrie (manner)
% Find the time intervals where the bolt is connected to the telemetrie
% system. This is done by:
% 1- Define the left and right limits (start and end of the connection).
% Bases on the Excel sheet ??
% 2- Use the find function to find the indexes of these limits on the time
% vector
% 3- Isolate the bolt signals only within this interval
% 4- Do this for each one of the 4 bolts and with 0 and 390Nm pre-tension

ll_Bolt1_0N = datetime(2023,08,23,12,46,00);
rr_Bolt1_0N = datetime(2023,08,23,12,48,00);
inx_ll_Bolt1_0N = find(abs(time_abs_manner - ll_Bolt1_0N)<tol,1,'first');
inx_rr_Bolt1_0N = find(abs(time_abs_manner - rr_Bolt1_0N)<tol,1,'last');
Bolt1_0N_ave = mean(Bolt1(inx_ll_Bolt1_0N:inx_rr_Bolt1_0N));
%
ll_Bolt1_390N = datetime(2023,08,23,13,24,00);
rr_Bolt1_390N = datetime(2023,08,23,13,26,00);
inx_ll_Bolt1_390N = find(abs(time_abs_manner - ll_Bolt1_390N)<tol,1,'first');
inx_rr_Bolt1_390N = find(abs(time_abs_manner - rr_Bolt1_390N)<tol,1,'last');
Bolt1_390N_ave = mean(Bolt1(inx_ll_Bolt1_390N:inx_rr_Bolt1_390N));
%
ll_Bolt2_0N = datetime(2023,08,23,13,46,30);
rr_Bolt2_0N = datetime(2023,08,23,13,48,00);
inx_ll_Bolt2_0N = find(abs(time_abs_manner - ll_Bolt2_0N)<tol,1,'first');
inx_rr_Bolt2_0N = find(abs(time_abs_manner - rr_Bolt2_0N)<tol,1,'last');
Bolt2_0N_ave = mean(Bolt2(inx_ll_Bolt2_0N:inx_rr_Bolt2_0N));
%
% From this point all the time intervals are outside the time_abs_manner
% vector
ll_Bolt2_390N = datetime(2023,08,23,13,54,00);
rr_Bolt2_390N = datetime(2023,08,23,13,56,00);
inx_ll_Bolt2_390N = find(abs(time_abs_manner - ll_Bolt2_390N)<tol,1,'first');
inx_rr_Bolt2_390N = find(abs(time_abs_manner - rr_Bolt2_390N)<tol,1,'last');
Bolt2_390N_ave = mean(Bolt2(inx_ll_Bolt2_390N:inx_rr_Bolt2_390N));
%
ll_Bolt3_0N = datetime(2023,08,23,14,00,00);
rr_Bolt3_0N = datetime(2023,08,23,14,05,00);
inx_ll_Bolt3_0N = find(abs(time_abs_manner - ll_Bolt3_0N)<tol,1,'first');
inx_rr_Bolt3_0N = find(abs(time_abs_manner - rr_Bolt3_0N)<tol,1,'last');
Bolt3_0N_ave = mean(Bolt3(inx_ll_Bolt3_0N:inx_rr_Bolt3_0N));
%
ll_Bolt3_390N = datetime(2023,08,23,13,34,00);
rr_Bolt3_390N = datetime(2023,08,23,13,36,00);
inx_ll_Bolt3_390N = find(abs(time_abs_manner - ll_Bolt3_390N)<tol,1,'first');
inx_rr_Bolt3_390N = find(abs(time_abs_manner - rr_Bolt3_390N)<tol,1,'last');
Bolt3_390N_ave = mean(Bolt3(inx_ll_Bolt3_390N:inx_rr_Bolt3_390N));
%
ll_Bolt4_0N = datetime(2023,08,23,14,36,00);
rr_Bolt4_0N = datetime(2023,08,23,14,38,00);
inx_ll_Bolt4_0N = find(abs(time_abs_manner - ll_Bolt4_0N)<tol,1,'first');
inx_rr_Bolt4_0N = find(abs(time_abs_manner - rr_Bolt4_0N)<tol,1,'last');
Bolt4_0N_ave = mean(Bolt4(inx_ll_Bolt4_0N:inx_rr_Bolt4_0N));
%
ll_Bolt4_390N = datetime(2023,08,23,14,00,00);
rr_Bolt4_390N = datetime(2023,08,23,14,04,00);
inx_ll_Bolt4_390N = find(abs(time_abs_manner - ll_Bolt4_390N)<tol,1,'first');
inx_rr_Bolt4_390N = find(abs(time_abs_manner - rr_Bolt4_390N)<tol,1,'last');
Bolt4_390N_ave = mean(Bolt4(inx_ll_Bolt4_390N:inx_rr_Bolt4_390N));

% Why this is defined differently from the Gantner avg vector ?
Bolt_av=[Bolt1_0N_ave, Bolt2_0N_ave, Bolt3_0N_ave, Bolt4_0N_ave; Bolt1_390N_ave, Bolt2_390N_ave, Bolt3_390N_ave, Bolt4_390N_ave];
%% Ganter
% Find the time intervals where the bolt is connected to the Gantner
% system. This is done by:
% 1- Define the left and right limits (start and end of the connection).
% Bases on the Excel sheet ??
% 2- Use the find function to find the indexes of these limits on the time
% vector
% 3- Isolate the bolt signals only within this interval
% 4- Do this for each one of the 4 bolts and with 0 and 390Nm pre-tension

ll_G_Bolt1_0N = datetime(2023,08,23,12,15,00);
rr_G_Bolt1_0N = datetime(2023,08,23,12,20,00);
inx_ll_G_Bolt1_0N = find(abs(time_abs_DMS - ll_G_Bolt1_0N) < tol, 1, 'first');
inx_rr_G_Bolt1_0N = find(abs(time_abs_DMS - rr_G_Bolt1_0N) < tol, 1, 'last');
G_Bolt1_0N_ave = mean(DMS2.YData(inx_ll_G_Bolt1_0N:inx_rr_G_Bolt1_0N));

ll_G_Bolt1_390N = datetime(2023,08,23,13,29,00);
rr_G_Bolt1_390N = datetime(2023,08,23,13,31,00);
inx_ll_G_Bolt1_390N = find(abs(time_abs_DMS - ll_G_Bolt1_390N) < tol, 1, 'first');
inx_rr_G_Bolt1_390N = find(abs(time_abs_DMS - rr_G_Bolt1_390N) < tol, 1, 'last');
G_Bolt1_390N_ave = mean(DMS2.YData(inx_ll_G_Bolt1_390N:inx_rr_G_Bolt1_390N));

ll_G_Bolt2_0N = datetime(2023,08,23,13,42,00);
rr_G_Bolt2_0N = datetime(2023,08,23,13,44,00);
inx_ll_G_Bolt2_0N = find(abs(time_abs_DMS - ll_G_Bolt2_0N) < tol, 1, 'first');
inx_rr_G_Bolt2_0N = find(abs(time_abs_DMS - rr_G_Bolt2_0N) < tol, 1, 'last');
G_Bolt2_0N_ave = mean(DMS2.YData(inx_ll_G_Bolt2_0N:inx_rr_G_Bolt2_0N));

ll_G_Bolt2_390N = datetime(2023,08,23,13,36,00);
rr_G_Bolt2_390N = datetime(2023,08,23,13,38,00);
inx_ll_G_Bolt2_390N = find(abs(time_abs_DMS - ll_G_Bolt2_390N) < tol, 1, 'first');
inx_rr_G_Bolt2_390N = find(abs(time_abs_DMS - rr_G_Bolt2_390N) < tol, 1, 'last');
G_Bolt2_390N_ave = mean(DMS2.YData(inx_ll_G_Bolt2_390N:inx_rr_G_Bolt2_390N));

ll_G_Bolt3_0N = datetime(2023,08,23,14,07,40);
rr_G_Bolt3_0N = datetime(2023,08,23,14,09,20);
inx_ll_G_Bolt3_0N = find(abs(time_abs_DMS - ll_G_Bolt3_0N) < tol, 1, 'first');
inx_rr_G_Bolt3_0N = find(abs(time_abs_DMS - rr_G_Bolt3_0N) < tol, 1, 'last');
G_Bolt3_0N_ave = mean(DMS2.YData(inx_ll_G_Bolt3_0N:inx_rr_G_Bolt3_0N));

ll_G_Bolt3_390N = datetime(2023,08,23,13,53,00);
rr_G_Bolt3_390N = datetime(2023,08,23,13,55,00);
inx_ll_G_Bolt3_390N = find(abs(time_abs_DMS - ll_G_Bolt3_390N) < tol, 1, 'first');
inx_rr_G_Bolt3_390N = find(abs(time_abs_DMS - rr_G_Bolt3_390N) < tol, 1, 'last');
G_Bolt3_390N_ave = mean(DMS2.YData(inx_ll_G_Bolt3_390N:inx_rr_G_Bolt3_390N));

ll_G_Bolt4_0N = datetime(2023,08,23,14,28,00);
rr_G_Bolt4_0N = datetime(2023,08,23,14,32,00);
inx_ll_G_Bolt4_0N = find(abs(time_abs_DMS - ll_G_Bolt4_0N) < tol, 1, 'first');
inx_rr_G_Bolt4_0N = find(abs(time_abs_DMS - rr_G_Bolt4_0N) < tol, 1, 'last');
G_Bolt4_0N_ave = mean(DMS2.YData(inx_ll_G_Bolt4_0N:inx_rr_G_Bolt4_0N));

ll_G_Bolt4_390N = datetime(2023,08,23,14,21,05);
rr_G_Bolt4_390N = datetime(2023,08,23,14,22,50);
inx_ll_G_Bolt4_390N = find(abs(time_abs_DMS - ll_G_Bolt4_390N) < tol, 1, 'first');
inx_rr_G_Bolt4_390N = find(abs(time_abs_DMS - rr_G_Bolt4_390N) < tol, 1, 'last');
G_Bolt4_390N_ave = mean(DMS2.YData(inx_ll_G_Bolt4_390N:inx_rr_G_Bolt4_390N));

% Vector with avg values
G_Bolt_av=[G_Bolt1_0N_ave, G_Bolt2_0N_ave, G_Bolt3_0N_ave, G_Bolt4_0N_ave; G_Bolt1_390N_ave, G_Bolt2_390N_ave, G_Bolt3_390N_ave, G_Bolt4_390N_ave];

% Why these steps have not been made for the telemetrie?
GBolt4_diff = G_Bolt4_390N_ave-G_Bolt4_0N_ave;
GBolt3_diff = G_Bolt3_390N_ave-G_Bolt3_0N_ave;
GBolt2_diff = G_Bolt2_390N_ave-G_Bolt2_0N_ave;
GBolt1_diff = G_Bolt1_390N_ave-G_Bolt1_0N_ave;

GBolt_diff=[GBolt1_diff, GBolt2_diff, GBolt3_diff, GBolt4_diff];


%% Plots
% what does 'para' mean?

%Bolt1
y = [G_Bolt1_0N_ave, G_Bolt1_390N_ave];
x = [Bolt1_0N_ave, Bolt1_390N_ave];
para_Bolt1 = polyfit(x,y,1);

figure;
plot(x,y, '*'); hold on; grid on;
xx = -10:0.1:10;
yy = para_Bolt1(1)*xx + para_Bolt1(2);
plot(xx, yy);

para_Bolt1_Offset=-G_Bolt1_0N_ave;
para_Bolt2_Offset=-G_Bolt2_0N_ave;
para_Bolt3_Offset=-G_Bolt3_0N_ave;
para_Bolt4_Offset=-G_Bolt4_0N_ave;


%Bolt1_corr=para_Bolt1(1)*Bolt1+para_Bolt1(2);
%Mit Offset Korrektur
Bolt1_corr=para_Bolt1(1)*Bolt1+para_Bolt1(2)-G_Bolt1_0N_ave;

figure
plot(time_abs_manner,Bolt1_corr); 
% hold on;
% plot(time_abs_manner,Bolt1); 

%Bolt2
y = [G_Bolt2_0N_ave, G_Bolt2_390N_ave];
x = [Bolt2_0N_ave, Bolt2_390N_ave];
para_Bolt2 = polyfit(x,y,1);

%Bolt3
y = [G_Bolt3_0N_ave, G_Bolt3_390N_ave];
x = [Bolt3_0N_ave, Bolt3_390N_ave];
para_Bolt3 = polyfit(x,y,1);

%Bolt4
y = [G_Bolt4_0N_ave, G_Bolt4_390N_ave];
x = [Bolt4_0N_ave, Bolt4_390N_ave];
para_Bolt4 = polyfit(x,y,1);

para_Bolt=[para_Bolt1; para_Bolt2; para_Bolt3; para_Bolt4];

%Displacement
para_Disp=[25;10];

%Force
para_Force_south=[10;6.95];
para_Force_north=[10;5.87];

%Force Bolts
para_Force_bolts=[188;0];

