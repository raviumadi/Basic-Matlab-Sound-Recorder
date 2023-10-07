# Basic-Matlab-Sound-Recorder

A simple tool for quickly recording sounds using MATLAB&reg; command window.

**Check `/examples` for a working demo**

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
5. Mark regions of interest by pressing `t` to obtain timestamps of the event. This comes in handy for post-processing
6. Extended use: Incorporate into script designs for writing out `.wav` and clipping from timestamp etc.

Have fun!

## License

This project is licensed under the MIT License - see the [LICENSE](license.md) file for details.
