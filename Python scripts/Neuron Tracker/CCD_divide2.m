


% %
% figuring out size of data set

dim = size(data);
t = dim(1); % number of time point
n = dim(2); % number of ROIs

% BG_avg = mean(BG,2);
% 
% 
% for i = 1:n
% data_mBG(:,i) = data(:,i) - BG_avg;
% end
% 
% % % 
% % 
% % for i = 1:n
% % data(:,i) = data(:,i) + BG_avg;
% % end
% % 
% data_mBG_min = mean(data_mBG,2);
% data_mBG_min_SD = std(data_mBG,0,2);




figure(1)
plot(data(:,2:n));
% hold on
% plot(BG, '+','LineWidth', 3);
% hold off

%plot(data(:,3:3:15), 'LineWidth', 5);
set(gca, 'FontSize', 20)
set(gca,'XTick', 0:24:t);
title('Raw Trace');
xlabel('Time (h)');
ylabel('Integrated Density');

figure(9)


plot(data(:,3:3:15), 'LineWidth', 5);
set(gca, 'FontSize', 20)
set(gca,'XTick', 0:24:t);
title('Representative Raw Trace');
xlabel('Time (h)');
ylabel('Integrated Density');

% data = data_mBG;

% adjacent frame minimization
% data_min = data;
% for j = 2:n
%     for i = 1:t-1
%         data_min(i,j) = min(data(i,j), data(i+1,j));
%     end
%     
% end

%detrend

trend = zeros(size(data));

for i = 13:t-11
trend(i,:) = mean(data(i-12:i+11,:));
end

detrend = data./trend;

detrend(t-12:t,:) = [];
detrend(1:12,:) = [];
% 
% trend = zeros(size(data));
% 
% for i = 24:t
% trend(i,:) = mean(data(i-23:i,:));
% end
% 
% detrend = data./trend;
% % 
% % detrend(t-23:t,:) = [];
% % trend(t-23:t,:) = [];
% detrend(1:23,:) = [];
% 
% trend(1:23,:) = [];



%% normalization

mini = zeros(1,n);
maxi = zeros(1,n);
for j = 2:n
    mini(1,j) = min(detrend(:,j));
    maxi(1,j) = max(detrend(:,j));
    
end
data_norm = detrend;
for j=2:n
    data_norm(:,j) = ((detrend(:,j)-mini(1,j))./(maxi(1,j)-mini(1,j)));
end

%peak finder

peak = zeros(n,1);
peak_value = 0;
for j = 1:n
    peak_value = 0;
    for i = 108:132    %% choose 24 h time frame here
        if data_norm(i,j) > peak_value;
            peak(j,1) = i;
            peak_value = data_norm(i,j);
        end
    end
end


% figure(2)
% plot(trend(:,2:n));
% set(gca, 'FontSize', 20)
% set(gca,'XTick', 0:24:t);
% title('Trend');
% xlabel('Time (h)');
% ylabel('Integrated Density');


figure(3)
plot(detrend(:,2:n));
set(gca, 'FontSize', 20)
set(gca,'XTick', 0:24:t);
title('Detrended');
xlabel('Time (h)');
ylabel('Integrated Density');

% figure(4)
% plot(data_norm(:,2:n));
% set(gca, 'FontSize', 20);
% set(gca,'XTick', 0:24:t);
% title('Norm');
% xlabel('Time (h)');
% ylabel('Integrated Density');

peak(1) = [];
figure(5)
rastor = data_norm';
rastor(1,:) = [];
rastor = [peak rastor];
rastor = sortrows(rastor,-1);
imagesc(rastor(:,2:t-24));
set(gca,'XTick', 0:24:t);
hold on
plot(rastor(:,1),1:size(rastor(:,1)),'r','LineWidth',3);
set(gca, 'FontSize', 20);
xlabel('Time (h)');
ylabel('ROI');
colorbar
hold off

figure(6)
phase_map = [roi peak];
scatter(phase_map(:,2),phase_map(:,1),100,phase_map(:,3),'fill')
colormap(hsv)
set(gca, 'FontSize', 20)
% hold on
% scatter(roi_out(:,2),roi_out(:,1),300,roi_out(:,3),'fill','d')
% hold off
%set(gca,'Ydir','reverse')
% xlim([0 7])
% ylim([0 6])
xlim([0 700])
ylim([100 600])
c = colorbar
caxis([108 132]);
c.Label.String = 'Peak Phase (h)';

figure(7)
datax = data;
datax(:,1) = [];
data_avg = mean(datax,2);

plot(data_avg,'LineWidth',5);
set(gca, 'FontSize', 20);
set(gca,'XTick', 0:24:t);
title('Average');
xlabel('Time (h)');
ylabel('Integrated Density');


figure(8)
detrendx = detrend;
detrendx(:,1) = [];
detrend_avg = mean(detrendx,2);

plot(detrend_avg,'LineWidth',5);
set(gca, 'FontSize', 20);
set(gca,'XTick', 0:24:t);
title('Average Detrended');
xlabel('Time (h)');
ylabel('Integrated Density');


figure(9)


% plot(data(:,391), 'LineWidth', 5);
% hold on
% plot(data(:,127), 'LineWidth', 5);
% plot(data(:,354), 'LineWidth', 5);
% plot(data(:,381), 'LineWidth', 5);
% plot(data(:,382), 'LineWidth', 5);
% hold off
% set(gca, 'FontSize', 20)
% set(gca,'XTick', 0:24:t);
% title('Representative Raw Trace CC<0.8');
% xlabel('Time (h)');
% ylabel('Integrated Density');




% scatter(roi_SCN(:,2),roi_SCN(:,1),300,roi_SCN(:,3),'fill')
% hold on
% scatter(roi_out(:,2),roi_out(:,1),300,roi_out(:,3),'fill','d')
% hold off
% set(gca,'Ydir','reverse')
% colorbar

