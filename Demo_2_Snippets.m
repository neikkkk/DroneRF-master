close all; clear; clc
filename = 'D:\Data\';  % Path of raw RF data

%% Parameters
BUI{1,1} = {'00000'};                         % BUI of RF background activities
BUI{1,2} = {'10000','10001','10010','10011'}; % BUI of the Bebop drone RF activities
BUI{1,3} = {'10100','10101','10110','10111'}; % BUI of the AR drone RF activities
BUI{1,4} = {'11000'};                         % BUI of the Phantom drone RF activities
fs = 40e6;
opt = [1 1 5 ; 2 4 10 ; 4 1 7];

%% Main
for i = 1:3
    % Loading
    x = csvread([filename BUI{1,opt(i,1)}{opt(i,2)} 'L_' num2str(opt(i,3)) '.csv']);
    y = csvread([filename BUI{1,opt(i,1)}{opt(i,2)} 'H_' num2str(opt(i,3)) '.csv']);
    x = x./max(abs(x));
    y = y./max(abs(y));
    t = 0:1/fs:(length(x)-1)/fs;
    % Plotting
    figure('Color',[1,1,1],'position',[100, 60, 840, 600]);
    plot(t,x); hold on; plot(t,y-2,'r'); ylim([-3.1 1.1]);
    grid on; grid minor; xlabel('Time (s)','fontsize',18);
    legend('x^(^L^)','x^(^H^)','Orientation','Horizontal','location','southwest')
    set(gca,'fontweight','bold','fontsize',20,'FontName','Times','yticklabel','');
    set(gcf,'Units','inches'); screenposition = get(gcf,'Position');
    set(gcf,'PaperPosition',[0 0 screenposition(3:4)],'PaperSize',screenposition(3:4));
end

%% Saving
Q = input('Do you want to save the results (Y/N)\n','s');
if(Q == 'y' || Q == 'Y')
    for i = 1:3
        print(i,['snippet_' num2str(i)],'-dpdf','-r512');
    end
else
    return
end
