load('All4DClean.mat');

n = 4;
length = size(yCell,1);
D = monsetup(n);

SolMat = zeros(length, 2^n + 1);
%parfor i = 1:16
parfor i = 1:size(yCell,1)/2
    tic
    y = yCell{i,1};
    SolMat(i,:) = [sorted_nsHeuristic(y), y*D];
    %SolMat(i, 2:17) = y * D;
    toc
end