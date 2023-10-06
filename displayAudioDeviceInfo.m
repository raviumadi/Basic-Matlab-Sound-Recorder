function [inputs, outputs] = displayAudioDeviceInfo()
    % displayAudioDeviceInfo  Display audio device information in a table.
    %
    % Syntax:
    %   displayAudioDeviceInfo()
    %
    % Description:
    %   This function lists all the parameters from the 'audiodevinfo'
    %   function in a neat table.
    %
    
    % Get audio device information using audiodevinfo
    deviceInfo = audiodevinfo;
    
    inputs = struct2table(deviceInfo.input);
    outputs = struct2table(deviceInfo.output);

    % Display the table
    disp('INPUTS');
    disp(inputs);
    disp(" ");
    disp('OUTPUTS');
    disp(outputs);
end
