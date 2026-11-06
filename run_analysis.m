% =========================================================================
% MAIN DASHBOARD: 1D CHT SOLVER & NASA SP-290 VALIDATION
% =========================================================================
clear; clc; close all;

fprintf('===================================================================\n');
fprintf('  STARTING EXECUTION: CONJUGATE HEAT TRANSFER SOLVER & VALIDATION  \n');
fprintf('===================================================================\n\n');

% 1. Execute Numerical Core Solver Framework
[x, Mach, h_bartz, Tw, q_flux, nasa_hg, nasa_peak_Tw] = bartz_solver();
[~, throat_idx] = min(abs(x));

% 2. Calculate Validation Error Profiles
hg_error_dist = abs(h_bartz - nasa_hg) ./ nasa_hg * 100;
mean_val_error = mean(hg_error_dist);

calculated_peak_throat_temp = Tw(throat_idx);
peak_temp_margin = abs(calculated_peak_throat_temp - nasa_peak_Tw) / nasa_peak_Tw * 100;

% 3. Print Calculated Numerical Results directly to Console
fprintf('Mean Dataset Validation Error: %.2f%%\n', mean_val_error);
fprintf('Peak Throat Temperature Margin: %.2f%%\n', peak_temp_margin);
fprintf('Calculated Peak Throat Wall Temperature: %.1f K\n\n', calculated_peak_throat_temp);

% 4. Call Graphic Visualizer Framework
plot_results(x, Mach, h_bartz, Tw, q_flux, nasa_hg);
