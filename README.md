# StoryTimeLine
> This library is to display time line like instagram Story Time Line.

[![Swift Version][swift-image]][swift-url]
[![Build Status][travis-image]][travis-url]
[![License][license-image]][license-url]
[![codebeat-badge][codebeat-image]][codebeat-url]

One to two paragraph statement about your product and what it does.

<image src="StoryTimeLine.png" width="800">

## Table of Contents
 - [Installation](#installation)
 - [Usage](#usage)
 - [Demo Video](#demo-video)

## Installation

Add this project on your `Package.swift`

```swift
import PackageDescription

let package = Package(
    dependencies: [
        .Package(url: "https://github.com/Mohamed-Khaterr/StoryTimeLine.git")
    ]
)
```

## Usage

in the Storyboard, add `UIView` and set it's custom class to be `StoryTimeLineView`, then create IBOutlet in the `ViewController` class.

```swift
import StoryTimeLine

@IBOutlet weak var timeLineView: StoryTimeLineView!

override func viewDidLoad() {
    super.viewDidLoad()

    // The number of progress bars that you want to display
    timeLineView.setLineBarsCount(10)

    // Now set the time for each progress bar to be full
    // 1 is equal to 10 seconds
    // So if you want progress bar to take 5 seconds just set it to 0.5
    timeLineView.setAnimatedDuration(1) // Default is 1 which is 10 seconds
}

override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    // To start the animation just call start() method
    timeLineView.start()

    // You can also start animation from specific index
    // and all the previous progress bars will full
    timeLineView.start(from: 3) // The animation will start at fourth progress bar
}
```

### Other methods

```swift
// To pause the animation you can call pause() method
// this method will pause the animation until you resume it
timeLineView.pause()

// To resume the animation you can call resume() method
timeLineView.resume()

// To fill the current progress bar and start animate the next progress bar
// you can call next() method
timeLineView.next()

// To empty the current progress bar and start animate the previous progress bar
// you can call previous() method
timeLineView.previous()

// To reset the time line you can call reset() method
// Which stop the animation and make all progress bars empty
timeLineView.reset()
```

### Appearance
You can update the appearance of the StoryTimeLineView
```swift
// Set the space between each progress bar
timeLineView.spacing = 4 // Default is 1

// Set the track color of each progress bar
timeLineView.trackTintColor = UIColor.green // Default is UIColor.lightGray

// Set the progress color of each progress bar
timeLineView.progressTintColor = UIColor.red // Default is UIColor.white
```

### Delegate
StoryTimeLine comes with a delegation of some events.

```swift
// Set the object that will be notified
timeLineView.delegate = object

extension ViewController: StoryTimeLineDelegate {
    // get notify when the progress bar that will start animation
    func storyTimeLine(_ timeLine: StoryTimeLine, willStartAnimationAt index: Int) {

    }

    // get notify when the progress bar that is finish animation
    func storyTimeLine(_ timeLine: StoryTimeLine, didFinishAnimationAt index: Int) {

    }

    // get notify when all progress bars are full and the the time line is finish
    func storyTimeLine(didFinish timeLine: StoryTimeLine) {

    }
}
```

> You can Check the [Example project](https://github.com/Mohamed-Khaterr/StoryTimeLine/tree/main/Example) to learn more about the library.

## Author

Mohamed Khater – [Mohamed-Khaterr](https://twitter.com/dbader_org) – mohamed.khateerr@gmail.com

Distributed under the MIT license. See `LICENSE` for more information.

[GitHub](https://github.com/Mohamed-Khaterr/StoryTimeLine)

[swift-image]:https://img.shields.io/badge/swift-3.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
[travis-image]: https://img.shields.io/travis/dbader/node-datadog-metrics/master.svg
[travis-url]: https://travis-ci.org/dbader/node-datadog-metrics
[codebeat-image]: https://codebeat.co/badges/c19b47ea-2f9d-45df-8458-b2d952fe9dad
[codebeat-url]: https://codebeat.co/projects/github-com-vsouza-awesomeios-com
