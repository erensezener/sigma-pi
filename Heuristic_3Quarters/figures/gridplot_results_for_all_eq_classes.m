clear;
load('uniques_4d_first_half.mat');
load('compare_all_GAs_updated.mat');

% subplot(3,3,1)
% hold on;
% line1 = plot(mean(times_bs,1), mean(results_bs,1), 'm-x', 'LineWidth',2);
% line2 =plot(mean(times_ks,1), mean(results_ks,1), 'c-o','LineWidth',2);
% line3 =plot(mean(times_all,1), mean(results_all,1), 'g-+', 'LineWidth',2);
% 
% ylabel('Avg. # monomials')
% xlabel('Avg. computation durations')
% title('Avg. results for 4-variable BFs', 'FontWeight','bold', 'FontSize',12)
% xlim([0, 7.5])
% 
% hold off;

classes = [8, 7, 5,6,4,3,2,1];
densities = [9, 5, 3, 5, 5,4,5,1];

for i = 1:8
    
    temp_results_ks = results_ks(IC==i,:);
    temp_times_ks = times_ks(IC==i,:);
    
    temp_results_bs = results_bs(IC==i,:);
    temp_times_bs = times_bs(IC==i,:);
    
    temp_results_all = results_all(IC==i,:);
    temp_times_all = times_all(IC==i,:);
    
    subplot(3,3,classes(i))
    hold on;
    line1 = plot(mean(temp_times_bs,1), mean(temp_results_bs,1), 'm-x', 'LineWidth',2);
    line2 =plot(mean(temp_times_ks,1), mean(temp_results_ks,1), 'c-o','LineWidth',2);
    line3 =plot(mean(temp_times_all,1), mean(temp_results_all,1), 'g-+', 'LineWidth',2);
    %     legend({'Binary-GA', 'k-GA', '3Q-all-GA'})
    line4 =plot(linspace(0,7,5), ones(1,5)*densities(i), 'k:', 'LineWidth',1);
    ylim([densities(i) - 0.2, max(mean(temp_results_ks,1) + 0.3)])
    xlim([0, 7.5])
    
    hold off;
    
    ylabel('Avg. # monomials')
    xlabel('Avg. computation duration')
    title(strcat('Equivalence class: ', num2str(classes(i))), 'FontWeight','bold', 'FontSize',12)
    
end


hL = legend([line1,line2,line3, line4],{'Binary-GA', 'k-GA', '3Q-GA', 'Threshold density'});
% Programatically move the Legend
newPosition = [0.4 0.4 0.2 0.2];
newUnits = 'normalized';
set(hL,'Position', newPosition,'Units', newUnits);

% savefig('eq_class_plots/eq_class_grid_plot.fig')
% print('/eq_class_grid_plot', '-depsc')

