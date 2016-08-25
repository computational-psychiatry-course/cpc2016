function [sumF, pp, logGBF] = FFX(F)
% Demo routine of how to implement a fixed effects BMS analysis.
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
%   sumF      	% summed log model evidences (normalized -> best model = 0)
%   pp          % posterior probabilities
%   logGBF    	% matrix of pairwise log group Bayes factors
% 
% References:
%--------------------------------------------------------------------------
%   Penny WD, Stephan KE, Mechelli A, Friston KJ (2004)
%   Comparing Dynamic Causal Models, NeuroImage 22:1157-1172
% 
%   Stephan KE, Weiskopf N, Drysdale PM, Robinson PA, Friston KJ (2007)
%   Comparing hemodynamic models with DCM, NeuroImage 38:387-401
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


% Compute posterior probabilities
%--------------------------------------------------------------------------
sumF	= sum(F,1);
sumF    = sumF - max(sumF);
pp      = exp(sumF)./sum(exp(sumF));


% Illustrate FFX results
%--------------------------------------------------------------------------

% close all open figures
close all

% Plot group-wise summed log-evidences 
% (equivalent to log GBF of best model compared to all others)
figure;
col = [0.6 0.6 0.6];
colormap(col);
bar(sumF);
title('Log Group Bayes Factor (GBF)')
xlabel('model','FontSize',14,'FontWeight','bold')
ylabel('log GBF','FontSize',14,'FontWeight','bold')
set(gca,'FontSize',14);

% Plot posterior probabilities
figure;
col = [0.6 0.6 0.6];
colormap(col);
bar(pp);
title('Posterior probability')
xlabel('model','FontSize',14,'FontWeight','bold')
ylabel('posterior prob.','FontSize',14,'FontWeight','bold')
set(gca,'FontSize',14);


% Compute pairwise log group Bayes factor (log GBF)
%--------------------------------------------------------------------------
logGBF = zeros(M,M);
for j = 1:M,
    for k = 1:M,
        logGBF(j,k) = sumF(j)-sumF(k);
    end
end


% Plot pairwise log group Bayes factor (log GBF) 
%--------------------------------------------------------------------------
figure
colormap('parula')
imagesc(logGBF)
axis square
colorbar
caxis([-30 30])
title('log Group Bayes Factor (log GBF_i_j)')
xlabel('model i','FontSize',14,'FontWeight','bold')
ylabel('model j','FontSize',14,'FontWeight','bold')
set(gca,'FontSize',14);


return