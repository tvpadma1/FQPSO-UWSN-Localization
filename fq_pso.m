function best_pos = fq_pso(fitness, params)

pop_size = params.pop_size;
max_iter = params.max_iter;
dim = params.dim;
bounds = params.bounds;

particles = initialize_particles(pop_size, dim, bounds);
pbest = particles;
pbest_val = inf(pop_size,1);

for i=1:pop_size
    pbest_val(i) = fitness(particles(i,:));
end

[gbest_val, idx] = min(pbest_val);
gbest = particles(idx,:);

for iter = 1:max_iter

    beta = fuzzy_controller(iter/max_iter);

    for i=1:pop_size

        u = rand(1,dim);
        p = (pbest(i,:) + gbest)/2;

        particles(i,:) = p + beta .* abs(particles(i,:) - p) .* log(1./u);

        for d=1:dim
            particles(i,d) = max(bounds(d,1), min(bounds(d,2), particles(i,d)));
        end

        f = fitness(particles(i,:));

        if f < pbest_val(i)
            pbest(i,:) = particles(i,:);
            pbest_val(i) = f;
        end
    end

    [new_best, idx] = min(pbest_val);
    if new_best < gbest_val
        gbest = pbest(idx,:);
        gbest_val = new_best;
    end
end

best_pos = gbest;
end
