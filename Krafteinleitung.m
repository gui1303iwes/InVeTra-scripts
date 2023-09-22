clc; clear; close all;
% load('Longterm_2023-08-23_14-51-07');
% time_manner = Channel10_time;
% begintime_manner = datetime(2023,08,23,14,51,07);

%
load('Longterm_2023-09-05_11-52-44');
load('Sensitiviy_Offset.mat'); 
time_manner = Channel10_time;
begintime_manner = datetime(2023,09,05,11,52,44);

time_abs_manner = begintime_manner + seconds(time_manner);
Bolt1 = Channel9;
Bolt2 = Channel2;
Bolt3 = Channel11;
Bolt4 = Channel10;

%Bolzen1
Temp=Channel16;

Displacement_south = Channel17;
Displacement_north = Channel18;
Force_cylinder_south = Channel19;
Force_cylinder_north = Channel20;

%Plots in mV/V
Bolt1_strain=para_Bolt1(1)*Bolt1+para_Bolt1(2)+para_Bolt1_Offset;
Bolt2_strain=para_Bolt2(1)*Bolt2+para_Bolt2(2)+para_Bolt2_Offset;
Bolt3_strain=para_Bolt3(1)*Bolt3+para_Bolt3(2)+para_Bolt3_Offset;
Bolt4_strain=para_Bolt4(1)*Bolt4+para_Bolt4(2)+para_Bolt4_Offset;
%Plots in N
%para_Force_bolts=[188;0]; %Wert von Cord
para_Force_bolts=[5484;0]; %Wert aus Gantner
Bolt1=para_Force_bolts(1)*Bolt1_strain+para_Force_bolts(2);
Bolt2=para_Force_bolts(1)*Bolt2_strain+para_Force_bolts(2);
Bolt3=para_Force_bolts(1)*Bolt3_strain+para_Force_bolts(2);
Bolt4=para_Force_bolts(1)*Bolt4_strain+para_Force_bolts(2);

%Plots in kN
Force_cylinder_south=para_Force_south(1)*Force_cylinder_south+para_Force_south(2);
Force_cylinder_north=para_Force_north(1)*Force_cylinder_north+para_Force_north(2);
%Plots in mm
Displacement_south=para_Disp(1)*Displacement_south+para_Disp(2);
Displacement_north=para_Disp(1)*Displacement_north+para_Disp(2);



%%




figure;
subplot(2,2,1);
plot(time_abs_manner, Bolt1_strain);
hold on; grid on ; grid minor;
subplot(2,2,2);
plot(time_abs_manner, Bolt2_strain);
subplot(2,2,3);
plot(time_abs_manner, Bolt3_strain);
subplot(2,2,4);
plot(time_abs_manner, Bolt4_strain);
legend('Bolt1','Bolt2','Bolt3','Bolt4')
% ylabel('Bolt Pretension [N]')


%Mittelwerte
% ll_Ft_Bolt2_0N = datetime(2023,09,05,11,52,52);
% rr_Ft_Bolt2_0N = datetime(2023,09,05,11,54,26);
% inx_ll_Ft_Bolt2_0N = interp1(time_abs_manner, 1:length(time_manner), ll_Ft_Bolt2_0N, 'nearest');
% inx_rr_Ft_Bolt2_0N = interp1(time_abs_manner, 1:length(time_manner), rr_Ft_Bolt2_0N, 'nearest');
% Ft_Bolt2_0N_ave = mean(Ft_Bolt2(inx_ll_Ft_Bolt2_0N:inx_rr_Ft_Bolt2_0N));
%G_Bolt3_0N_ave = mean(DMS2.YData(inx_ll_G_Bolt3_0N:inx_rr_G_Bolt3_0N));

% figure
% plot(time_abs_manner, Temp)

%%

% Temperaturkompensation - funktioniert aber nicht
% L1 = 1; R1 = 50000;
% L2 = 430000; R2 = 480000;
% T = [mean(Temp(L1:R1)), mean(Temp(L2:R2))];
% F = [mean(Bolt2(L1:R1)), mean(Bolt2(L2:R2))];
% para = polyfit(T,F, 1)
% Bolt2_new = Bolt2 - para(1)*(Temp - Temp(1));
% figure
% plot(Bolt2); hold on; plot(Bolt2_new);
%Bolt2=Bolt2_new;

%%
%Tiefpassfilter
lpfilt = designfilt('lowpassfir', 'PassbandFrequency', 10,...
              'StopbandFrequency', 15, 'PassbandRipple', 1, ...
              'StopbandAttenuation', 65, 'SampleRate', 1000,'DesignMethod','kaiserwin');
Ft_Bolt1 = filter(lpfilt,Bolt1);
Ft_Bolt1_strain = filter(lpfilt,Bolt1_strain);
Bolt1_med = medfilt1(Bolt1, 1080);

Ft_Bolt2 = filter(lpfilt,Bolt2);
Ft_Bolt2_strain = filter(lpfilt,Bolt2_strain);
Bolt2_med = medfilt1(Bolt2, 1080);

Ft_Bolt3 = filter(lpfilt,Bolt3);
Ft_Bolt3_strain = filter(lpfilt,Bolt3_strain);
Bolt3_med = medfilt1(Bolt3, 1080);

Ft_Bolt4 = filter(lpfilt,Bolt4);
Ft_Bolt4_strain = filter(lpfilt,Bolt4_strain);
Bolt4_med = medfilt1(Bolt4, 1080);
% Ft_Bolt2_new = filter(lpfilt,Bolt2_new);
% Bolt2_new_med = medfilt1(Bolt2_new, 1080);
%plot(time_manner, Ft_Bolt1);
%hold on
%plot(time_manner, Bolt1);

%%

figure;
% subplot(2,1,1);
% yyaxis left
% plot(time_manner, Bolt1);
% hold on; grid on ; grid minor;
% yyaxis right
% plot(time_manner, Force_cylinder_south);

% subplot(2,1,1);
% yyaxis left
% plot(time_manner, Ft_Bolt2_strain);
% %ylim([-0.086 -0.083])
% hold on; grid on ; grid minor;
% yyaxis right
% plot(time_manner, Force_cylinder_south);
% 
% subplot(2,1,2);
yyaxis left
plot(time_manner, Ft_Bolt2 ); hold on;
%plot(time_manner, Ft_Bolt2_new, 'y');
%ylim([-15 -14])
ylim([88 120])
%xlim([1 400])
plot(time_manner, Bolt2_med, 'y')
hold on
%yline(Ft_Bolt2_0N_ave)
ylabel('Bolt Load [kN]')
xlabel('Time [s]')
hold on; grid on ; grid minor;
yyaxis right
plot(time_manner, Force_cylinder_south);
hold on
plot(time_manner, Force_cylinder_north, 'g');
ylabel('Cylinder Force [kN]')
legend('Bolt1', 'RMS  Bolt 1','Force Cylinder 1','Force Cylinder 2' );

%%
figure
yyaxis left
plot(time_manner, Ft_Bolt1 ); hold on;
%plot(time_manner, Ft_Bolt2_new, 'y');
%ylim([-15 -14])
ylim([100 120])
%xlim([1 400])
plot(time_manner, Bolt1_med, 'y')
hold on
%yline(Ft_Bolt2_0N_ave)
ylabel('Bolt Load [kN]')
xlabel('Time [s]')
hold on; grid on ; grid minor;
yyaxis right
plot(time_manner, Force_cylinder_south);
hold on
plot(time_manner, Force_cylinder_north, 'g');
ylabel('Cylinder Force [kN]')
legend('Bolt1', 'RMS Bolt 1','Force Cylinder 1','Force Cylinder 2' );
%%
figure
yyaxis left
plot(time_manner, Ft_Bolt3 ); hold on;
%plot(time_manner, Ft_Bolt2_new, 'y');
%ylim([-15 -14])
ylim([82 92])
%xlim([1 400])
plot(time_manner, Bolt3_med, 'y')
hold on
%yline(Ft_Bolt2_0N_ave)
ylabel('Bolt Load [kN]')
xlabel('Time [s]')
hold on; grid on ; grid minor;
yyaxis right
plot(time_manner, Force_cylinder_south);
hold on
plot(time_manner, Force_cylinder_north, 'g');
ylabel('Cylinder Force [kN]')
legend('Bolt3', 'RMS  Bolt 3','Force Cylinder 1','Force Cylinder 2' );

%%
figure
yyaxis left
plot(time_manner, Ft_Bolt4 ); hold on;
%plot(time_manner, Ft_Bolt2_new, 'y');
%ylim([-15 -14])
ylim([76 100])
%xlim([1 400])
plot(time_manner, Bolt4_med, 'y')
hold on
%yline(Ft_Bolt2_0N_ave)
ylabel('Bolt Load [kN]')
xlabel('Time [s]')
hold on; grid on ; grid minor;
yyaxis right
plot(time_manner, Force_cylinder_south);
hold on
plot(time_manner, Force_cylinder_north, 'g');
ylabel('Cylinder Force [kN]')
legend('Bolt1', 'RMS  Bolt 1','Force Cylinder 1','Force Cylinder 2' );
%%

