bent_results_ks = results_ks(IC==1,:);
bent_times_ks = times_ks(IC==1,:);

bent_results_bs = results_bs(IC==1,:);
bent_times_bs = times_bs(IC==1,:);

bent_results_ags = results_ags(IC==1,:);
bent_times_ags = times_ags(IC==1,:);

bent_results_all = results_all(IC==1,:);
bent_times_all = times_all(IC==1,:);

plot(mean(bent_times_bs,1), mean(bent_results_bs,1), 'r')
hold on;
plot(mean(bent_times_ks,1), mean(bent_results_ks,1), 'b')
plot(mean(bent_times_ags,1), mean(bent_results_ags,1), 'g')
plot(mean(bent_times_all,1), mean(bent_results_all,1), 'k')
legend({'Binary-GA', 'k-GA', '3Q-ag-GA', '3Q-all-GA'})
ylabel('Average number of monomials')
xlabel('Average running times')

