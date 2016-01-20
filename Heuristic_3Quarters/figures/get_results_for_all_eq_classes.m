clear;
load('uniques_4d_first_half.mat');
load('compare_all_GAs_updated.mat');

classes = [8, 7, 5,6,4,3,2,1];

parfor i = 1:8
    
    temp_results_ks = results_ks(IC==i,:);
    temp_times_ks = times_ks(IC==i,:);
    
    temp_results_bs = results_bs(IC==i,:);
    temp_times_bs = times_bs(IC==i,:);
    
%     temp_results_ags = results_ags(IC==i,:);
%     temp_times_ags = times_ags(IC==i,:);
    
    temp_results_all = results_all(IC==i,:);
    temp_times_all = times_all(IC==i,:);
    
    figure;
    plot(mean(temp_times_bs,1), mean(temp_results_bs,1), 'r')
    hold on;
    plot(mean(temp_times_ks,1), mean(temp_results_ks,1), 'b')
%     plot(mean(temp_times_ags,1), mean(temp_results_ags,1), 'g')
    plot(mean(temp_times_all,1), mean(temp_results_all,1), 'k')
%     xlim([0 7]);
%     ylim([0.5 14]);
%     legend({'Binary-GA', 'k-GA', '3Q-ag-GA', '3Q-all-GA'})
    legend({'Binary-GA', 'k-GA', '3Q-all-GA'})

    ylabel('Average number of monomials')
    xlabel('Average running times')
    title(strcat('Results for equivalence class: ', num2str(classes(i))))
    savefig(strcat('eq_class_plots/eq_class_plots_', num2str(classes(i)), '.fig'))
    print(strcat('pngs/eq_class_plots_', num2str(classes(i))),'-dpng')
    hold off;
    
end

