function [family, model] = family_BMS(F)
% Demo routine of how to implement a random effects family level BMS analysis. 
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
%   family      % BMS results at the family level
%   model       % BMS results at the model level
% 
% References:
%--------------------------------------------------------------------------
%   Stephan KE, Penny WD, Daunizeau J, Moran RJ, Friston KJ (2009)
%   Bayesian model selection for group studies. NeuroImage 46:1004-1017
% 
%   Penny WD, Stephan KE, Daunizeau J, Joao M, Friston KJ, Schofield T, Leff A (2010)
%   Comparing families of Dynamic Causal Models. PLoS Computational Biology 6:e1000706
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


% Define the family structure
%--------------------------------------------------------------------------
family.infer     = 'RFX';
family.partition = [1 1 1 1 2 2 2 2 3 3 3 3 4 4 4 4];
family.names     = {'VF','F','F+VF','F|VF'};
family.Nsamp     = 1e4;
family.prior     = 'F-unity';


% Call the family level inference function
%--------------------------------------------------------------------------
[family,model] = spm_compare_families(F,family);


return