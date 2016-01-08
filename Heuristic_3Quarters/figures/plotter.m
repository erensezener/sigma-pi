plot(mean(times_bs,1), mean(results_bs,1), 'r')
hold on;
plot(mean(times_ks,1), mean(results_ks,1), 'b')
plot(mean(times_ags,1), mean(results_ags,1), 'g')
plot(mean(times_all,1), mean(results_all,1), 'k')
legend({'Binary-GA', 'k-GA', '3Q-ag-GA', '3Q-all-GA'})
xlabel('Average number of monomials')
ylabel('Average running times')