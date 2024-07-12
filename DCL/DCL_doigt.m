clc
clear variables
clear global

format longg

%% Variables
Theta_1 = pi/2;
Theta_2 = pi/2;

syms F_T

%% Forces et Moments de forces connus

% F_app
% Force maximale appliquée sur la tomate
F_app = 11.5;

% F_A_g
m_A = 0.016;
g = 9.81;
h_cm_A = 0.05254;
F_A_g = m_A * g * h_cm_A

% F_B_g
m_B = 0.013;
g = 9.81;
h_cm_B = 0.08146;
F_B_g = m_B * g * h_cm_B

% M_S_t
G = 2.1029 * 10^11;
d = 0.0007112;
N = 5;
c = 0.008636;

K_t = (G*d^4) / (32*N*c);

M_S_t = K_t * Theta_1

% M_S_e
r = 0.009;
Delta_X = Theta_2 * r;

K_t = 147.1058;
F_S_e = K_t * Delta_X;

M_S_e = F_S_e * r

%% Somme des forces en X
F_A_T = 0

%% Somme des forces en Y
F_B_T = F_T + F_app + F_A_g + F_B_g

%% Somme des moments de force autour du point d'origine

% M_F_T
r_F_T = [0 0 0];
F_T_xyz = [0 -F_T 0];
M_F_T_xyz = cross(r_F_T, F_T_xyz);
M_F_T = M_F_T_xyz(3)

% M_F_A_g
r_F_A_g = [-0.00284381 0.05264065 0];
F_A_g_xyz = [0 -F_A_g 0];
M_F_A_g_xyz = cross(r_F_A_g, F_A_g_xyz);
M_F_A_g = M_F_A_g_xyz(3)

% M_F_B_g
r_F_B_g = [-0.01929528 0.08145802 0];
F_B_g_xyz = [0 -F_B_g 0];
M_F_B_g_xyz = cross(r_F_B_g, F_B_g_xyz);
M_F_B_g = M_F_B_g_xyz(3)

% M_F_A_T
r_F_A_T = [0.01125000 0.05020238 0];
F_A_T_xyz = [F_A_T 0 0];
M_F_A_T_xyz = cross(r_F_A_T, F_A_T_xyz);
M_F_A_T = M_F_A_T_xyz(3)

% M_F_B_T
r_F_B_T = [-0.02844456 0.07260238 0];
F_B_T_xyz = [0 F_B_T 0];
M_F_B_T_xyz = cross(r_F_B_T, F_B_T_xyz);
M_F_B_T = M_F_B_T_xyz(3)

% M_F_app
r_F_app = [-0.03724456 0.07260238 0];
F_app_xyz = [0 -F_app 0];
M_F_app_xyz = cross(r_F_app, F_app_xyz);
M_F_app = M_F_app_xyz(3)

% Somme des moments
% Sum_M_O = -M_S_t - M_S_e + M_F_T + M_F_A_g + M_F_B_g + M_F_A_T + M_F_B_T + M_F_app == 0;
Sum_M_O = -M_S_t - M_S_e + M_F_T + M_F_A_g + M_F_B_g + M_F_app == 0;

% Solution symbolique
F_T = solve(Sum_M_O, F_T)

% Solution numérique
F_T = double(F_T)