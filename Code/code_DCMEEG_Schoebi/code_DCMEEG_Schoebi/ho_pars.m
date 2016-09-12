function [P, M, U] = ho_pars(ho_sys)

%% Create a single source, dummy DCM input
% Create M     
M = struct();
M.FS = 'spm_fy_erp';
M.G = 'spm_lx_erp';
M.IS = 'spm_gen_erp_cp16';
M.f = 'spm_fx_erp_cp16';
M.dur = 16;
M.ons = 264;
M.ns = 4999;
M.x = [0, 0, 0, 0, 0, 0, 0, 0, 0]; 

% Create U
U = struct();
U.X = 0;
U.name = {''};
U.dt = 5e-04;


% Between source connection
P = struct();


P.A{1} = -Inf; 
P.A{2} = -Inf;
P.A{3} = -Inf;

P.B{1} = 0;

P.C = -Inf;

P.T = zeros(1, 2);  % ns x 2: log weighting of kernel pars tau_e, tau_i
P.G = zeros(1, 2);  % ns x 2: log weighting of kernel pars H_e,  H_i
P.H = [-Inf, -Inf, -Inf, -Inf]; % 1 x 4: Weighting on intrinsic connectivity parameters
P.S = zeros(1, 2); % 1 x 2: log weighting of sigmoid pars R_1, R_2
P.D = zeros(1, 1); % ns x ns: log weighting on between source delay
P.R = zeros(1, 2);

P.s = 13; % Spring COnstant for demonstration purpose CPC2016
P.fr = -Inf; % Friction for demonstation purpose CPC2016

switch ho_sys
    case 'noS_noF_noU_noA'
        P.s = -Inf;
    case 'noF_noU_noA'
        M.x = [1, 0, 0, 0, 0, 0, 0, 0, 0]; 
    case 'F_noU_noA'
        M.x = [1, 0, 0, 0, 0, 0, 0, 0, 0]; 
        P.fr = 5;
    case 'F_U_noA'
        P.fr = 5;
        P.C = 15;
    case 'F_U_A'
        P.H = [-Inf, 10, -Inf, -Inf];
        P.fr = 5;
        P.C = 15;
end






