function proj1_516

aoa = [-7 -4 -2 0 5 8.5 12 14.5 17 19.5 22];    % AoAs collected by CFD

cl = NaN(size(aoa));    % preallocation
cd = NaN(size(aoa));
cm = NaN(size(aoa));

for i = 1:length(aoa)
    [cl(i),cd(i),cm(i)] = readAoA(aoa(i));
end

[aoa2,cl2,cd2,cm2] = xfoil_data;  % extracting xfoil data

graph_comparison(aoa,cl,cd,cm,aoa2,cl2,cd2,cm2); % plotting

end

function [avg_cl,avg_cd,avg_cm] = readAoA(AoA)

cd = importdata([num2str(AoA), '_deg/report-drag-rfile.out']);
cl = importdata([num2str(AoA), '_deg/report-lift-rfile.out']);
cm = importdata([num2str(AoA), '_deg/report-mom-rfile.out']);

cd = cd.data(:,2);
cl = cl.data(:,2);
cm = cm.data(:,2);

n = 300; % averaging over the last 200 points or however many is available

if numel(cd) < n
    avg_cd = sum(cd)/numel(cd);
    avg_cl = sum(cl)/numel(cl);
    avg_cm = -sum(cm)/numel(cm);
else
    avg_cd = sum(cd(end-n:end))/(n+1);
    avg_cl = sum(cl(end-n:end))/(n+1);
    avg_cm = -sum(cm(end-n:end))/(n+1);
end

% shifting moment about leading edge to quarter chord
avg_cm = avg_cm + avg_cl/4;

end

function [aoa,cl,cd,cm] = xfoil_data

data = importdata('xfoil_data');

aoa = data(:,1);
cl = data(:,2);
cd = data(:,3);
cm = data(:,5);

end

function graph_comparison(aoa,cl,cd,cm,aoa2,cl2,cd2,cm2)

error_plot = 0; % 1 shows error bar
drag_error_plot = 0; % 1 to plot just the drag
forces_plot = 1;

% Cl, Cd, Cm plots

if error_plot
    
    % 10% error bar plots for Cl and Cd
    err_cl = cl2 * 0.1;
    err_cd = cd2 * 0.1;
    errorbar(aoa2,cl2,err_cl); hold on;
    errorbar(aoa2,cd2,err_cd)
    plot(aoa,cl,'-o',aoa,cd,'-o','linewidth',3); hold off;
    grid on; grid minor;
    xlabel('AoA [deg]'); ylabel('Aerodynamic Coefficients [-]');
    title('C_l and C_d vs. AoA with error bars');
    legend('C_l Xfoil','C_d Xfoil','C_l CFD','C_d CFD','Location','nw');
    set(gca,'fontname','times','fontsize',18)
    
elseif drag_error_plot

    figure;
    err_cd = cd2 * 0.1;
    errorbar(aoa2,cd2,err_cd); hold on;
    plot(aoa,cd,'-o','linewidth',3); hold off;
    xlabel('AoA [deg]'); grid on; grid minor;   
    ylabel('Coefficients of drag, C_d [-]');
    title('Coefficients of drag vs. AoA');
    
    legend('C_d CFD','C_d Xfoil','Location','nw');
    set(gca,'fontname','times','fontsize',18)

    
elseif forces_plot
    
    rho = 1.225;    % [kg/m^3]
    V = 17.88;      % [m/s]
    q = 1/2*rho*V^2;    % [Pa]
    c = 1;              % chord length
    
    % dimensionalization
    L = cl*q*c;
    D = cd*q*c;
    M = cm*q*c^2;
    
    figure;
    plot(aoa,L,'-o',aoa,D,'-o',aoa,M,'-o','linewidth',3);
    
    xlabel('AoA [deg]'); grid on; grid minor;
    ylabel('Aerodynamic Forces and Moments [N, N.m]');
    title('Aerodynamic Forces and Moments vs. AoA');
    
    legend('Lift','Drag','Moment, c/4','Location','nw');
    set(gca,'fontname','times','fontsize',18)

    
    
else
    
    % aerodynamic coefficients plotting
    figure;
    
    subplot(1,2,1);
    plot(aoa,cl,'-o',aoa2,cl2,aoa,cd,'-o',aoa2,cd2, ...
                    aoa,cm,'-o',aoa2,cm2,'linewidth',3);
    
    xlabel('AoA [deg]'); grid on; grid minor;
    ylabel('Aerodynamic Coefficients [-]');
    title('Aerodynamic Coefficients vs. AoA');
    
    legend('C_l CFD','C_l Xfoil','C_d CFD','C_d Xfoil','C_{m,c/4} CFD',...
                                        'C_{m,c/4} Xfoil','Location','nw');
    set(gca,'fontname','times','fontsize',18)

    subplot(1,2,2)
    plot(aoa,cl./cd,'-o',aoa2,cl2./cd2,'linewidth',3);
    xlabel('AoA [deg]'); ylabel('L/D ratio [-]');
    grid on; grid minor;
    title('L/D ratio vs. AoA');
    legend('L/D CFD','L/D Xfoil','location','nw');
    set(gca,'fontname','times','fontsize',18)

end

end