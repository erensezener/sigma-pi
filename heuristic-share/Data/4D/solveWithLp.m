Sols = zeros(size(Solutions,1), 16);
NoMons = zeros(size(Solutions,1), 1);

parfor i = 1:size(Solutions,1)
   [n,a] = mainHeuristic(Solutions{i,1});
   Sols(i,:) =  a;
   NoMons(i,:) = n;
end