function [onlineNSP] = TaskComment(event,filename)
%TASKCOMMENT Sends a comment to Blackrock NSPs based on filename and given
%event flag
%
% CODE PURPOSE
% (1) Deliver a comment to addressed instances of Blackrock Central that
% annotates the moment in which a task was either started, ended, or halted
% due to an error or manual termination.
% (2) Provide a vector 'onlineNSP' holding the indices of Blackrock Central
% that were detected. This variable can then be used throughout a task code
% to deliver other commands to both or either instance of Blackrock Central
%
% SYNTAX
% [onlineNSP] = TaskComment(filename,event)
%
% INPUT
% filename - a string/char array of the desired filename to be used for any
%           recordings collected from the utilization of this function.
%           File extensions and file paths are stripped from the provided
%           filename input
% event - a string/char array denoting the type of event this comment is
%           representing. Available options include 'start','stop','kill',
%           and 'error', and 'annotate' for any task-related comments you want to send during the experiment.
%
% OUTPUT
% onlineNSP - an integer array representing the indices of the NSPs which
%           successfully established a connection to the computer/MATLAB
%           session
%
% Author: Joshua Adkinson

if nargin==1
    filename = '';
end

%% Get IP Addresses of NSP ethernet ports
% address = {'192.168.137.3','192.168.137.178'};
address = getIPAddressesFromPortNames({'NSP1','NSP2'});


%% Strip away any filepath/file extention information
[~,filename] = fileparts(filename);


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


%% Blackrock Filename Prefix/Suffix Check
% Find prefix from file name:
% now for testing: hardcoded
% prefix = regexp(filename,'^[a-zA-Z0-9]+-[a-zA-Z0-9]+','match');
% if isempty(prefix) || numel(prefix)>1
%     error('Invalid filename prefix')
% end
EMU = '0003';
subj = 'TEST';
prefix = {'EMU-',EMU,'_subj-',subj,'_'};

if numel(onlineNSP)==1
    suffix = {[]};
else
    suffix = strcat(repmat({'_NSP-'},numel(onlineNSP),1),cellstr(num2str(onlineNSP(:))));
end


%% Check Character Length
commentLength = numel([filename,suffix{1}])+7;
if commentLength>92
    error('The name for this task exceeds the 92 character length limit. Please shorten name.')
end


%% Event Type
switch event
    case 'start'
        eventCode = '$TASKSTART ';
        eventColor = 65280;
    case 'stop'
        eventCode = '$TASKSTOP ';
        eventColor = 16711935;
    case 'kill'
        eventCode = '$TASKKILL ';
        eventColor = 255;
    case 'error'
        eventCode = '$TASKERR ';
        eventColor = 255;
    case 'annotate'
        eventCode = '@EVENT ';
        eventColor = 16711680;
end


%% Sending Comments
%Event Comment
for i = 1:numel(onlineNSP)
    comment = [eventCode,prefix{1}];
    cbmex('comment', eventColor, 0,comment,'instance',onlineNSP(i)-1);
    disp(comment)
end

%TaskID Comment
if strcmp(event,'start')
    for i = 1:numel(onlineNSP)
        comment = ['$TASKID ',filename,suffix{i}];
        cbmex('comment', eventColor, 0,comment,'instance',onlineNSP(i)-1);
        disp(comment)
    end
end

end
