# Qt Material-Design Components
A Qt Quick port of some components using Google Material Design.

## Contents
### MaterialProgressBar
 This component will show a progress bar just like this:
 ![](https://raw.githubusercontent.com/unixzii/QtMaterialDesignComponents/master/contents/1.gif)
 You can use this to represent the progress of a buffering work.
#### API
##### Functions
 * `start()` - This function will make the progress bar begin a buffering animation.
 * `end()` - This function will force the buffering animation stop.It will be called automatically when the buffering finished.
 * `hide()` - Make the progress bar hide smoothly.
##### Properties
 * `bufferedValue: int` - Current buffered value(from 0 to 100).
 * `value: int` - Current playback or other progress value(from 0 to 100).

### MaterialProgressIndicator
 This component will show a ring just like this:
  ![](https://raw.githubusercontent.com/unixzii/QtMaterialDesignComponents/master/contents/2.gif)
  You can use this to represent a undetermined progress.
#### API
##### Properties
 * `isColorChangable: bool` - Whether the ring can change color after a turn.
 * `currentColorIndex` - Current color(value from: 0, 1, 2, 3).

## Usage
 Just add qml files to your project and it's ready to go.

## References
 * [Qt Doc](http://doc.qt.io/)
 * [Google Material Design Official Guide](https://design.google.com)