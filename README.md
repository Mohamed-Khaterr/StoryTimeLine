# StoryTimeLine
![Xcode: Version](https://img.shields.io/badge/Xcode-15.2-lightgray?logo=Xcode)
![Swift: Version](https://img.shields.io/badge/Swift-5.9-lightgray?logo=Swift)
![iOS: Version](https://img.shields.io/badge/iOS-12.0+-lightgray) 

This library is to display time line like instagram Story Time Line.

<image src="StoryTimeLine.png" width="800">

## Table of Contents
- [Overview](#overview)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Example Project](#example-project)
- [License](#license)
- [Author](#author)

## Overview
StoryTimeLine is a custom UIView designed to visualize a timeline with progress bars. This Swift package provides an easy-to-use interface for creating and animating timeline.

### Features
- **Customizable Appearance**: Customize the appearance of the progress bars with options to set track and progress tint colors.
- **Flexible Configuration**: Adjust the spacing between progress bars and set the duration for animated progress.
- **Interactive Control**: Pause, resume, stop, reset, and navigate through the timeline with next and previous methods.
- **Delegate Support**: Utilize delegate methods to receive notifications on animation completion and progress updates.

## Requirements
- iOS 12.0+
- Swift 5.9+

## Installation
To add StoryTimeLine as a dependency to your project, follow these steps:
1. Open your Swift project in Xcode.
2. Navigate to `File` -> `Add Package Dependencies`.
3. Paste `https://github.com/Mohamed-Khaterr/StoryTimeLine.git` into the search bar.
4. Choose the version you want to use and click `Add Package`.

```swift
let package = Package(
    dependencies: [
        .Package(url: "https://github.com/Mohamed-Khaterr/StoryTimeLine.git")
    ]
)
```

### Manually
If you prefer not to use any of the dependency managers above, you can integrate `StoryTimeLine` into your project manually. Just copy all the `*.swift` files from the [StoryTimeLine/Sources](https://github.com/Mohamed-Khaterr/StoryTimeLine/tree/main/Sources/StoryTimeLine) folder into your Xcode project.

## Usage
in the Storyboard, add `UIView` and set it's custom class to be `StoryTimeLineView` and module `StoryTimeLine`, then create IBOutlet in the `ViewController` class.

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

## Example Project
Take a look at the example project over [here](https://github.com/Mohamed-Khaterr/StoryTimeLine/tree/main/Example)

1. Download it.
2. Open the Example.xcworkspace in Xcode.
3. Enjoy!

## License
StoryTimeLine is available under the MIT license. See the [LICENSE]() file for more info.

## Author
Mohamed Khater – [Mohamed-Khaterr](https://www.linkedin.com/in/mohamed-khaterr) – mohamed.khateerr@gmail.com
