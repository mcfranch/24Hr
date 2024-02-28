function [] = setEMU(EMU_ID, Task_ID, T)

    if ~exist('T','var')
      table_file = dir(fullfile(pwd,'Current','*.csv'));
      T = readtable(fullfile(table_file.folder,table_file.name));
    else
      table_file = dir(fullfile(pwd,'Current','*.csv'));
    end

    emu_id = str2num(EMU_ID);
    
    emu_id_prev = T.emu_id(end);
    
    if emu_id == emu_id_prev + 1
        new_row = cell2table({emu_id,Task_ID},"VariableNames", ["emu_id","task_id"]);
        T = [T;new_row];
        writetable(T,fullfile(table_file.folder,table_file.name))
    else
       disp('ERROR: Attempted to save a non-consecutive EMU number') 
    end

end