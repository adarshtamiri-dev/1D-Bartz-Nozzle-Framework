function plot_results(x, Mach, h_bartz, Tw, q_flux, nasa_hg)
% Figure initialized with standard monitor dimensions
figure('Color', 'w', 'Position', [100, 100, 800, 600]);

% Subplot 1: Mach Profile Distribution
subplot(3,1,1);
plot(x, Mach, 'b-', 'LineWidth', 2);
ylabel('Mach Number');
title('1D Conjugate Heat Transfer Aerothermal Analysis');
grid on;

% Subplot 2: Heat Transfer Coefficient Validation Match
subplot(3,1,2);
plot(x, nasa_hg ./ 1000, 'k--', 'LineWidth', 1.5); hold on;
plot(x, h_bartz ./ 1000, 'r-', 'LineWidth', 2);
ylabel('h_g (kW/m²-K)');
legend('NASA SP-290 Baseline', 'Developed CHT Solver', 'Location', 'best');
grid on;

% Subplot 3: Structural Wall Thermal & Heat Flux Distribution
subplot(3,1,3);
yyaxis left
plot(x, Tw, 'm-', 'LineWidth', 2);
ylabel('Wall Temp T_w (K)');

yyaxis right
plot(x, q_flux ./ 1e6, 'g-', 'LineWidth', 2);
ylabel('Flux q (MW/m²)');

xlabel('Axial Coordinates x (m)');
grid on;
end
