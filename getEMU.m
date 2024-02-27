function [EMU_id, Subj, T] = getEMU()

    tableFile = dir(fullfile(pwd,'Current','*.csv'));
    
    % Split the string using underscore as the delimiter
    fileParts = split(tableFile.name, '_');
    Subj = fileParts{1};
    
    if length(tableFile) > 1
        disp('DANGER!!! MORE THAN ONE LOG FILE DETECTED')
        
    else
        T = readtable(fullfile(tableFile.folder,tableFile.name));
        EMU_id_prev = T.EMU_id(end);
        
        EMU_id = sprintf('%04d', EMU_id_prev+1);
    end


end 