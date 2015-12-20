clear
load('All4DClean.mat');

y = zeros(896/2,16);
it = 0;

for i=1:32768
    
    if Solutions{i,2} >= 9
        y(i,:) = Solutions{i,1};
    end
end