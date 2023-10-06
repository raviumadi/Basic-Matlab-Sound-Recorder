# Basic-Matlab-Sound-Recorder

A simple tool for quickly recording sounds using MATLAB&reg; command window.

You can control the recording process with simple key presses.

> Sound Recorder
>
>  CONTROLLER KEYS
>
>  s --> Start
>
>  p --> Pause/Resume
>
>  t --> Add Timestamp (ROI)
>
>  d --> Interim Data
>
>  x --> Stop and get data
>
> 

1. Call `displayAudioDeviceInfo` function to list the available inputs and outputs.

2. Call `SoundRecorderController` without arguments for recording from default input at 44.1 kHz.

3. You may use `SoundRecorderController(deviceID, channelNumbers, numChannels, fs)` where the deviceID is known from 1
4. Use `help SoundRecorderController` to see the details of the remaining parameters
