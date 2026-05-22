function beta = fuzzy_controller(progress)

if progress < 0.3
    beta = 1.0;
elseif progress < 0.7
    beta = 0.5;
else
    beta = 0.2;
end

end
