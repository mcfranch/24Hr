function updateSuccessLogEntry()

tableFile = dir(fullfile(userpath,'PatientData','+CurrentPatientLog'));
tableFile = tableFile(~[tableFile.isdir]);
if length(tableFile) > 1
    message = 'DANGER!! MORE THAN ONE FILE DETECTED IN +CURRENTPATIENTLOG FOLDER';
    msgbox(message,'More than one file detected','error')
    return
else
    T = readtable(fullfile(tableFile.folder,tableFile.name));
    T.success_id(end) = "1";
    writetable(T,fullfile(table_file.folder,table_file.name));
end

end