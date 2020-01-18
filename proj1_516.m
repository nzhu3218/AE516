function proj1_516

% aoa = [-7 -4 -2 0 5 11 17 23];  % the plan

aoa = [-7 -4 -2 0 5 12];

cl = NaN(size(aoa));
cd = NaN(size(aoa));
cm = NaN(size(aoa));

for i = 1:length(aoa)
   
    [cl(i),cd(i),cm(i)] = readAoA(aoa(i));
    
end

% Cl, Cd, Cm, L/D and compare against Xfoil
% table of the above values vs AoA

[aoa2,cl2,cd2,cm2] = xfoil_data;

graph_comparison(aoa,cl,cd,cm,aoa2,cl2,cd2,cm2);

end

function [avg_cl,avg_cd,avg_cm] = readAoA(AoA)

disp(AoA)
cd = importdata([num2str(AoA), '_deg/report-drag-rfile.out']);
cl = importdata([num2str(AoA), '_deg/report-lift-rfile.out']);
cm = importdata([num2str(AoA), '_deg/report-mom-rfile.out']);

cd = cd.data(:,2);
cl = cl.data(:,2);
cm = cm.data(:,2);

n = 200;    % averaging over the last 200 points

avg_cd = sum(cd(end-200:end))/(n+1);
avg_cl = sum(cl(end-200:end))/(n+1);
avg_cm = -sum(cm(end-200:end))/(n+1);

end

function [aoa,cl,cd,cm] = xfoil_data

data = importdata('xfoil_data');

aoa = data(:,1);
cl = data(:,2);
cd = data(:,3);
cm = data(:,5);

end

function graph_comparison(aoa,cl,cd,cm,aoa2,cl2,cd2,cm2)

% Cl, Cd, Cm

subplot(1,2,1)
plot(aoa,cl,aoa2,cl2,aoa,cd,aoa2,cd2,aoa,cm,aoa2,cm2,'linewidth',3);
grid on; grid minor;
title('Aerodynamic Coefficients vs. AoA');
legend('C_l CFD','C_l Xfoil','C_d CFD','C_d Xfoil','C_{m,1/4} CFD',...
                                            'C_{m,1/4} Xfoil','Location','nw');
set(gca,'fontname','times','fontsize',16)

% L/D
subplot(1,2,2)
plot(aoa,cl./cd,aoa2,cl2./cd2,'linewidth',3);
grid on; grid minor;
title('L/D ratio vs. AoA');
legend('L/D CFD','L/D Xfoil');
set(gca,'fontname','times','fontsize',16)

end