parobj = parpool;

hexes = ['aa55'; 'ab55'; 'bb55'; 'aba5'; 'aaff'; 'aba4'; 'ab12'; 'ac90'];
max_mons = [1,5,4,5,3,5,5,9];
to_eliminate = 16*ones(1,8) - max_mons;

ys = zeros(8,16);
num_attempts = 1000;
examples = false(8,16);
example_as = zeros(8,16);

for i = 1:8
    ys(i,:) = ix2prob(hex2dec(hexes(i,:)),16)';
end

parfor i = 1:8
    [successes, as] = bf_search_nchoosek( ys(i,:), to_eliminate(i), num_attempts);
    if size(successes,1) > 0
        examples(i,:) = successes(1,:);
        example_as(i,:) = as(1,:);
    end
end

% save('4D_eq_class_best_results_solutions.mat')
delete(parobj);