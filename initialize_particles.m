function particles = initialize_particles(pop_size, dim, bounds)

particles = zeros(pop_size, dim);

for i=1:pop_size
    for d=1:dim
        particles(i,d) = bounds(d,1) + rand*(bounds(d,2)-bounds(d,1));
    end
end

end
