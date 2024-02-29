function [emu_id, Subj, T] = getEMU()
    

    tableFile = dir(fullfile(pwd,'Current','*.csv'));
    
    % Split the string using underscore as the delimiter
    fileParts = split(tableFile.name, '_');
    Subj = fileParts{1};
    
    if length(tableFile) > 1
        disp('DANGER!!! MORE THAN ONE LOG FILE DETECTED')
        
    else
        T = readtable(fullfile(tableFile.folder,tableFile.name));
        emu_id_prev = T.emu_id(end);
        
        emu_id = sprintf('%04d', emu_id_prev+1);
    end


end 