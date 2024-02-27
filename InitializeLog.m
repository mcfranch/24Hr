%% Initialize Log 
% Paul J Steffan 2024 Feb 26
% 
% This script is designed to create a simple log of Tasks Run in the EMU.
% In this script, we will create the first value in a table that we will
% initialize for a given patient.



%% THIS IS HUGELY IMPORTANT--YOU NEED TO MAKE SURE THE CURRENT/ FOLDER IS EMPTY!!

%%%%%%%%%%%%%%%%%% MAKE THIS THE CURRENT PATIENT %%%%%%%%%%%%%%%%%%%%%%%%
Patient_ID = 'YEX';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 

EMU_id = "0000";
Meta = "";

%%

T = table(EMU_id,Meta); 

writetable(T,['Current/',Patient_ID,'_log.csv'])




