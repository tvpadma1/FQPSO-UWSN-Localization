clc;
clear;
close all;

data = readtable('../data/sample_dataset.csv');

X = data.X; Y = data.Y; Z = data.Z;
Type = data.Type;

isAnchor = strcmp(Type,'Anchor');

anchor_pos = [X(isAnchor), Y(isAnchor), Z(isAnchor)];
unknown_pos = [X(~isAnchor), Y(~isAnchor), Z(~isAnchor)];

num_unknown = size(unknown_pos,1);
num_anchor = size(anchor_pos,1);

dist_matrix = zeros(num_unknown, num_anchor);

for i = 1:num_unknown
    for j = 1:num_anchor
        d = norm(unknown_pos(i,:) - anchor_pos(j,:));
        noise = data.ToA_Noise(i);
        dist_matrix(i,j) = d + noise;
    end
end

params.pop_size = 30;
params.max_iter = 50;
params.dim = 3;
params.bounds = [0 1000; 0 1000; 0 500];

estimated_pos = zeros(size(unknown_pos));

for i = 1:num_unknown
    fitness = @(x) fitness_function(x, anchor_pos, dist_matrix(i,:));
    estimated_pos(i,:) = fq_pso(fitness, params);
end

error = sqrt(sum((estimated_pos - unknown_pos).^2,2));
fprintf('Mean Localization Error: %.4f m\n', mean(error));
