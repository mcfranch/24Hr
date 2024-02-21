function onlineNSP = TaskComment(filename,event)
address = {'192.168.137.3','192.168.137.178'};

%% Find/Open Connections to Available Blackrock NSPs
availableNSPs = zeros(size(address));
for i=1:length(address)
    try
        cbmex('open','central-addr',address{i},'instance',i-1)
    catch
        continue
    end
    fprintf('NSP%d Active\n',i)
    availableNSPs(i) = 1;
end
onlineNSP = find(availableNSPs==1);

%% Blackrock Filename Suffix Check
if numel(onlineNSP)==1
    suffix = {[]};
else
    suffix = strcat(repmat({'_NSP-'},numel(onlineNSP),1),cellstr(num2str(onlineNSP(:))));
end

%% Check Character Length
commentLength = numel([filename,suffix{1}])+7;
if commentLength>127
    error('The name for this task exceeds the 120 character length limit. Please shorten name.')
end

%% Event Type
switch event
    case 'start'
        eventCode = '$START:';
        eventColor = 65280;
    case 'stop'
        eventCode = '$STOP:';
        eventColor = 65280;
    case 'kill'
        eventCode = '$KILL:';
        eventColor = 255;
    case 'error'
        eventCode = '$ERR:';
        eventColor = 255;
end

%% Sending Comment
for i = onlineNSP
    cbmex('comment', eventColor, 0,[eventCode,filename,suffix{i}],'instance',i-1);
end

end