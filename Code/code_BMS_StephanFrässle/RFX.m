function [alpha, exp_r, xp, pxp, bor] = RFX(F)
% Demo routine of how to implement a random effects BMS analysis. 
% This function requires SPM12, which is freely available 
% at http://www.fil.ion.ucl.ac.uk/spm/software/
%
% Input:
%--------------------------------------------------------------------------
%   F           % name of MATLAB file with matrix F containing log model evidences
%               % or directly a matrix containing the log model evidences
%                   dimensions: N x M
%                  	rows: subjects
%                   columns: models
% 
% Output:
%--------------------------------------------------------------------------
%   alpha       % vector of model probabilities
%   exp_r       % expectation of the posterior p(r|y)
%   xp          % exceedance probabilities
%   pxp         % protected exceedance probabilities
%   bor         % Bayes Omnibus Risk (probability that model frequencies are equal)
% 
% References:
%--------------------------------------------------------------------------
%   Stephan KE, Penny WD, Daunizeau J, Moran RJ, Friston KJ (2009)
%   Bayesian model selection for group studies. NeuroImage 46:1004-1017
% 
%   Rigoux L, Stepha, KE, Friston KJ, Daunizeau, J (2014)
%   Bayesian model selection for group studies - Revisited. NeuroImage 84:971-85
% 
% 
%__________________________________________________________________________
% Stefan Frässle, Klaas Enno Stephan, August 2016


% Load matrix of log model evidences (dimensions N x M)
%--------------------------------------------------------------------------
if ( ischar(F) )
    load(F)
end

% N: number of subjects
N = size(F,1);

% M: number of models
M = size(F,2);


% Call the random effects BMS function
%--------------------------------------------------------------------------
[alpha, exp_r, xp, pxp, bor] = spm_BMS(F, 1e6, 1, 0, 1, ones(1,M));


% Illustrate single subject log Bayes factor of model 10 and 11
%--------------------------------------------------------------------------

% close all open figures
close all

% Plot log Bayes factor
figure;
col = [0.6 0.6 0.6];
colormap(col);
bar(F(:,10)-F(:,11));
title('Single subject log Bayes factor (log BF_1_0_,_1_1)')
xlabel('subject','FontSize',14,'FontWeight','bold')
ylabel('log BF_1_0_,_1_1','FontSize',14,'FontWeight','bold')
set(gca,'FontSize',14);


return