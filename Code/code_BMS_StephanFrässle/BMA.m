function [bma] = BMA(model_space,BMS)
% Demo routine of how to implement random effects Bayesian model averaging. 
% This function requires SPM12, which is freely available 
% at http://www.fil.ion.ucl.ac.uk/spm/software/
%
% Input:
%--------------------------------------------------------------------------
%   model_space     % name of MATLAB file containing the model space information.
%                   % This file is generated automatically by SPM when running
%                   % BMS or can be scripted. It contains the data from all 
%                   % subjects, sessions, and models.
%   BMS             % name of MATLAB file containing the BMS results or
%                   % directly the BMS structure
% 
% Output:
%--------------------------------------------------------------------------
%   bma             % BMA results
% 
% References:
%--------------------------------------------------------------------------
%   Penny WD, Stephan KE, Daunizeau J, Joao M, Friston KJ, Schofield T, Leff A (2010)
%   Comparing families of Dynamic Causal Models. PLoS Computational Biology 6:e1000706
% 
% 
%__________________________________________________________________________
% Stefan Frässle, Klaas Enno Stephan, August 2016


% Load model space (containing data for all subjects, sessison, and models)
%--------------------------------------------------------------------------
if ( ischar(model_space) )
    load(model_space)
end

% N: number of subjects
N = size(F,1);

% M: number of models
M = size(F,2);


% Load random effects BMS results
%--------------------------------------------------------------------------
if ( ischar(BMS) )
    load(BMS)
end


% Specify the settings for BMA
%--------------------------------------------------------------------------

% Posterior model probabilities (N x M)
post = BMS.DCM.rfx.model.g_post;

% Models to use in BMA
indx = [0 0 0 0 0 0 0 0 1 1 1 1 0 0 0 0];

% Number of samples
nsamp = 1e4;

% Posterior odds ratio for defining Occam's window
odds_ratio = 0.05;


% Call the family level inference function
%--------------------------------------------------------------------------
bma = spm_dcm_bma(post,indx,subj,nsamp,odds_ratio);


return