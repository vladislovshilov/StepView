**StepView** is a library for building fully customize step views in your ios app. It provides an easy way to configure this views and use them.

[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/vladislovshilov/StepView/issues) ![swift](https://img.shields.io/badge/swift-4.0+-orange.svg) ![xcode](https://img.shields.io/badge/Xcode-9.0+-blue.png) ![ios](https://img.shields.io/badge/ios-8.0+-blue.svg) ![pod](https://img.shields.io/cocoapods/v/StepView.svg?style=flat) ![license](https://img.shields.io/cocoapods/l/StepView.png)

## Example *(works well both on the device and on the simulator)*

![example gif](https://media.giphy.com/media/450INtPPuYp3h7W07H/giphy.gif) ![example gif1](https://media.giphy.com/media/7A1drTOKUM46ElGgqF/giphy.gif)

## Usage:
### Storyboard:

1. Set a view custom class as the StepView

![storyboard example1](https://i.ibb.co/QJvnjNn/Screen-Shot-2018-12-18-at-12-38-52-PM.png)

2. Configure view from attribute inspector as you want.

![storyboard example2](https://i.ibb.co/MpF7s44/Screen-Shot-2018-12-18-at-12-42-48-PM.png)

3. Profit

![storyboard example3](https://i.ibb.co/yPkvtX4/Screen-Shot-2018-12-18-at-12-43-26-PM.png)

### Code:
```
let stepView = StepView(frame: view.frame, numberOfSteps: 5, circleBorderColor: .black)
stepView.center = view.center
view.addSubview(stepView)
```

## Installation:
### Cocoapods:
Add the following entry to your Podfile:
```
pod 'StepView'
```
Then run ```pod install```.

Don't forget to ```import StepView``` in every file you'd like to use StepView.
