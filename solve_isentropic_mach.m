function M = solve_isentropic_mach(A_ratio, gamma, is_supersonic, options)
    % Bypasses the root finder directly at the throat plane
    if abs(A_ratio - 1.0) < 1e-5
        M = 1.0;
        return;
    end
    
    % Implicit Isentropic Area relation equation
    area_eqn = @(M) (1/M) * ((2 / (gamma + 1)) * (1 + 0.5 * (gamma - 1) * M^2))^((gamma + 1) / (2 * (gamma - 1))) - A_ratio;
    
    % Bounded guess ranges to prevent numerical divergence
    if is_supersonic
        guess_interval = [1.001, 10.0];
    else
        guess_interval = [0.001, 0.999];
    end
    
    try
        M = fzero(area_eqn, guess_interval, options);
    catch
        % Robust structural fallback if bounds clip at grid transitions
        if is_supersonic
            M = fzero(area_eqn, 2.0, options);
        else
            M = fzero(area_eqn, 0.3, options);
        end
    end
end
