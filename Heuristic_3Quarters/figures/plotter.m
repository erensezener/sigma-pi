load('compare_all_GAs_updated.mat')


l_heuristic_result_time = [4.97, 0.065];
b_heuristic_result_time = [5.81, 0.02];
threeq_result_result_time = [8.27, 0.0007];



plot(mean(times_bs,1), mean(results_bs,1), 'm-x', 'LineWidth',2);
hold on;
plot(mean(times_ks,1), mean(results_ks,1), 'c-o','LineWidth',2);

% plot(mean(times_ags,1), mean(results_ags,1), 'g')
plot(mean(times_all,1), mean(results_all,1), 'g-+', 'LineWidth',2);
scatter(threeq_result_result_time(2), threeq_result_result_time(1), 'b>', 'LineWidth', 5);
scatter(b_heuristic_result_time(2), b_heuristic_result_time(1), 'ks', 'LineWidth', 5);
scatter(l_heuristic_result_time(2), l_heuristic_result_time(1), 'rd', 'LineWidth', 5);

xlim([0 7])
% legend({'Binary-GA', 'k-GA', '3Q-ag-GA', '3Q-all-GA'})
legend({'Binary-GA', 'k-GA', '3Q-all-GA', '3-Quarters', 'B-Heuristic', 'L-Heuristic'})

ylabel('Avg. # monomials')
xlabel('Avg. computation duration')