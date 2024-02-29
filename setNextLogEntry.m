function setNextLogEntry(newEntry)
if nargin == 0
    newEntry = "";
end

    tableFile = dir(fullfile(userpath,'PatientData','+CurrentPatientLog'));
    tableFile = tableFile(~[tableFile.isdir]);
    if length(tableFile) > 1
        message = 'DANGER!! MORE THAN ONE FILE DETECTED IN +CURRENTPATIENTLOG FOLDER';
        msgbox(message,'More than one file detected','error')
        return
    else
        T = readtable(fullfile(tableFile.folder,tableFile.name));
        
        % New EMU ID
        emu_id_prev = str2double(T.emu_id(end));
        emu_id = emu_id_prev + 1;
        emu_id_new = sprintf('%04d',emu_id);
        
        Task_ID = newEntry;
        success_id = "0";
        
        
        new_row = cell2table({emu_id,Task_ID,success_id},"VariableNames", ["emu_id","task_id","success_id"]);
        T = [T;new_row];
        writetable(T,fullfile(table_file.folder,table_file.name));
    end

end