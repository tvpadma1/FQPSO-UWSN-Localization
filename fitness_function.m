function error = fitness_function(x, anchors, distances)

num_anchor = size(anchors,1);
est_dist = zeros(num_anchor,1);

for i=1:num_anchor
    est_dist(i) = norm(x - anchors(i,:));
end

error = sum((est_dist - distances').^2);
end
