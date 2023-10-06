classdef SoundRecorder < handle
    %SOUNDRECORDER A class for recording sound using MATLAB's audiorecorder.
    %   This class provides methods to control the recording process and retrieve the recorded data.
    
    properties (Access = public)
        recorder        % Audiorecorder object
        isRecording     % Flag indicating if recording is in progress
        isPaused        % Flag indicating if recording is paused
        startTime       % Start time of the recording
    end
    
    methods
        function obj = SoundRecorder(deviceID, channelNumber, numChannels, fs)
            %SOUNDRECORDER Construct a SoundRecorder object.
            %   obj = SoundRecorder(deviceID, channelNumbers, numChannels, fs) creates a
            %   SoundRecorder object with the specified parameters.
            %
            %   deviceID (optional) - The ID of the audio input device to use. If not provided,
            %   the default audio input device will be used.
            %
            %   channelNumbers (optional) - The channel numbers to record. If not provided, the
            %   first channel will be used.
            %
            %   numChannels (optional) - The number of channels to record. If not provided, mono
            %   sound (1 channel) will be recorded.
            %
            %   fs (optional) - The sampling frequency in Hz. If not provided, a default sampling
            %   frequency of 44100 Hz will be used.
            
            if nargin < 1
                deviceID = -1;  % Default audio input device
            end

            if nargin < 2
                channelNumber = 1;  % Default channel numbers
            end

            if nargin < 3
                numChannels = 1;  % Default number of channels
            end

            if nargin < 4
                fs = 44100;  % Default sampling frequency
            end
            
            obj.recorder = audiorecorder(fs, 16, numChannels, deviceID);
            obj.isRecording = false;
            obj.isPaused = true;
            obj.startTime = 0;
        end
        
        function startRecording(obj)
            %STARTRECORDING Start the recording process.
            
            if ~obj.isRecording && obj.isPaused
                fprintf('Recording started...\n');
                obj.startTime = tic;  % Start the timer
                record(obj.recorder);
                obj.isRecording = true;
                obj.isPaused = false;
            end
        end
        
        function pauseRecording(obj)
            %PAUSERECORDING Pause the recording process.
            
            if obj.isRecording && ~obj.isPaused
                fprintf('Recording paused.\n');
                pause(obj.recorder);
                obj.isPaused = true;
            end
        end
        
        function resumeRecording(obj)
            %RESUMERECORDING Resume the recording process.
            
            if obj.isRecording && obj.isPaused
                fprintf('Recording resumed.\n');
                resume(obj.recorder);
                obj.isPaused = false;
            end
        end
        
        function stopRecording(obj)
            %STOPRECORDING Stop the recording process.
            
            if obj.isRecording
                fprintf('Recording stopped.\n');
                stop(obj.recorder);
                obj.isRecording = false;
                obj.isPaused = false;
            end
        end

        function elapsed = getElapsedTime(obj)
            %GETELAPSEDTIME Get the elapsed time since recording started.
            
            if obj.isRecording && ~obj.isPaused
                elapsed = toc(obj.startTime);
            else
                elapsed = 0;
            end
        end
        
        function recordedData = retrieveRecordedData(obj)
            %RETRIEVERECORDEDDATA Retrieve the recorded audio data.
            %   recordedData = retrieveRecordedData(obj) returns the recorded audio data as a
            %   column vector.
            
            recordedData = getaudiodata(obj.recorder);
        end
    end
end
