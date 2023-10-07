% Example 1: Record sounds, mark timestamps, etc and save data
% Author: Ravi Umadi. 2023

% save path - enter your saving folder path
saveRec = "../rec";

% Toggle true/false for custom parameter values
customiseParameters = false;


if customiseParameters
    % Obtain device information
    [inputs, outputs] = displayAudioDeviceInfo;

    % Define parameters - replace from 'inputs' and 'outputs' if desired.
    % Comment out
    deviceID = [];
    while isempty(deviceID) || ~ismember(deviceID, inputs.ID)
        deviceID = input("Enter the input device ID:     ");
    end
    channelNumbers = 1;
    numChannels = 1;
    % Default sampling rate
    fs = 44100;
    % Start recroder
    SoundRecorderController(deviceID, channelNumbers, numChannels, fs)
else
    % Default sampling rate
    fs = 44100;
    % Record with default settings
    SoundRecorderController;
end

recStart = datetime("now", "Format", "uuuu-MM-dd-HH-mm-ss");
interimData_file = fullfile(saveRec, strcat(string(recStart), "_interim.wav"));
fullrec_file = fullfile(saveRec, strcat(string(recStart), "_fullrec.wav"));

%  Sound Recorder starts and waits for key input to start recording

%  CONTROLLER KEYS
%  s --> Start
%  p --> Pause/Resume
%  t --> Add Timestamp (ROI)
%  d --> Interim Data
%  x --> Stop and get data

% Note: Interim data: This is handy when recording for long
% sessions and subsequent events of interest are unpredictable. Everytime
% 'd' is pressed the interim data is updated to that timepoint.

% Grab data and write out

% Save interim data
if exist('interimData', 'var')
    saveInterim = [];
    while isempty(saveInterim) || ~ismember(saveInterim, ['y','n'])
        saveInterim = input("Do you want to save the interim file?[y/n]:     ", 's');
    end
    if isequal(saveInterim, 'y')
        audiowrite(interimData_file, interimData, fs);
        disp("Interim file saved")
    end
end

% Save full recording
if exist('recordedData', 'var')
    saveFullrec = [];
    while isempty(saveFullrec) || ~ismember(saveFullrec, ['y','n'])
        saveFullrec = input("Do you want to save the full recording file?[y/n]:     ", 's');
    end
    if isequal(saveFullrec, 'y')
        audiowrite(fullrec_file, recordedData, fs);
        disp("Full recording file saved")
    end
end

% Save timstamps - timestamps are in sample number. 
if exist("timestamps", "var")
    saveTimestamps = [];
    while isempty(saveTimestamps) || ~ismember(saveTimestamps, ['y','n'])
        saveTimestamps = input("Do you want to save the timstamps?[y/n]:     ", 's');
    end
    if isequal(saveTimestamps, 'y')
        tablefile = fullfile(saveRec, strcat(string(recStart), "_timestamps.xls"));
        writetable(table(timestamps), tablefile);
        disp("Timestamps saved")
    end
end
