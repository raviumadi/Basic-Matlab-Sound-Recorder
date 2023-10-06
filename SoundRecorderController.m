function SoundRecorderController(deviceID, channelNumbers, numChannels, fs)
% SOUNDRECORDERCONTROLLER Capture key inputs and control the SoundRecorder.
%   SoundRecorderController(deviceID, channelNumbers, numChannels, fs) creates a SoundRecorder object with the specified
%   parameters and starts capturing key inputs to control the recording process. The optional inputs are:
%   - deviceID: The ID of the audio input device to use. If not provided, the default audio input device will be used.
%   - channelNumbers: The channel numbers to record. If not provided, the first channel will be used.
%   - numChannels: The number of channels to record. If not provided, mono sound (1 channel) will be recorded.
%   - fs: The sampling frequency in Hz. If not provided, a default sampling frequency of 44100 Hz will be used.

% Set default values if the optional inputs are not provided
if nargin < 1
    deviceID = -1;              % Default audio input device
end

if nargin < 2
    channelNumbers = 1;         % First channel
end

if nargin < 3
    numChannels = 1;            % Record mono sound
end

if nargin < 4
    fs = 44100;                 % Sample rate
end

% Create a SoundRecorder object with the specified parameters
recorder = SoundRecorder(deviceID, channelNumbers, numChannels, fs);
fprintf(" Sound Recorder\n CONTROLLER KEYS\n s --> Start\n p --> Pause/Resume\n" + ...
    " t --> Add Timestamp (ROI)\n" + ...
    " d --> Interim Data\n x --> Stop and get data\n")

timestampData = [];  % Initialize empty array for timestamps

% Start an infinite loop to capture key inputs
while true
    % Wait for a key press
    waitforbuttonpress;

    % Check the pressed key and perform the corresponding action
    key = get(gcf, 'CurrentCharacter');
    if strcmp(key, 's')
        % Pressed 's' to start recording
        recorder.startRecording();
        %         fprintf('Recording started...\n');
    elseif strcmp(key, 'p')
        % Pressed 'p' to pause/resume recording

        if ~recorder.isPaused
            recorder.pauseRecording();
        else
            recorder.resumeRecording();
        end
    elseif strcmp(key, 't')
        % Pressed 't' to add a timestamp
        timestamp = fs*recorder.getElapsedTime();
        timestampData = [timestampData; timestamp];
        fprintf('Timestamp added: %f seconds\n', timestamp/fs);
        assignin('base', 'timestamps', timestampData);

    elseif strcmp(key, 'x')
        % Pressed 'x' to stop recording
        recorder.stopRecording();
        recordedData = recorder.retrieveRecordedData();
        assignin('base', 'recordedData', recordedData);  % Assign recordedData to MATLAB workspace
        fprintf('Recorded Data Retrieved \n');
        close(gcf);
        break;  % Exit the loop
    elseif strcmp(key, 'd')
        % Pressed 'd' to retrieve recorded data
        interimData = recorder.retrieveRecordedData();
        assignin('base', 'interimData', interimData);  % Assign recordedData to MATLAB workspace

        fprintf('Recorded data retrieved.\n');
        % Add your code to process the recorded data here
    end
end

end
