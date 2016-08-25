FFX.m and RFX.m are two simple demonstrations of fixed effects and random effects Bayesian model selection (BMS), respectively. Furthermore, family_BMS.m demonstrates random effects BMS at the family level. These three MATLAB scripts can be run using any log evidence matrix that
(i) has dimensions subjects (rows) x models (columns),
(ii) is named "F",
(iii) is saved as .mat file.
An example F matrix is included in the file LogEvidenceMatrix.mat. This represents the negative free energies taken from a recent DCM study on the effective connectivity in the face perception network (Frässle et al., 2016, NeuroImage). The dataset consists of 19 subjects and 16 competing DCMs, which implement different plausible hypotheses of the intra- and inter-hemispheric integration in the core face perception network. NOTE that you would need to adapt the model space partitioning in family_BMS.m for your own purposes when running new analyses.

Additionally, BMA.m is a simple demonstration of Bayesian model averaging (BMA) for the same dataset as described above. The script requires a .mat file that contains all the relevant information on the model space and the results from the random effects BMS. NOTE that this script is just for illustration purposes and will NOT run properly because the respective DCMs are missing.

FFX is stand-alone; RFX, family_BMS, and BMA require SPM12 (which is freely available at http://www.fil.ion.ucl.ac.uk/spm).


  