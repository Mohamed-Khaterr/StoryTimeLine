//
//  ViewController.swift
//  Example
//
//  Created by Mohamed Khater on 16/03/2024.
//

import UIKit
import StoryTimeLine

class ViewController: UIViewController {

    @IBOutlet weak var timeLineView: StoryTimeLineView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLineView.delegate = self
        
        // The number of progress bars that you want to display
        timeLineView.setProgressBarsCount(10)
        
        
        // Now set the time for each progress bar to be full
        // 1 is equal to 10 seconds
        // So if you want progress bar to take 3 seconds just set it to 0.3
        timeLineView.setAnimatedDuration(0.3)
        
        
        // Appearance
        
        // Set the cornerRadius of the tack and progress
        timeLineView.cornerRadius = 2
        
        // Set the space between each progress bar
        // timeLineView.spacing = 4
        
        // Set the track color of each progress bar
        // timeLineView.progressTintColor = .purple
        
        // Set the progress color of each progress bar
        // timeLineView.trackTintColor = .gray
    }
    
    @IBAction private func start(_ sender: UIButton) {
        timeLineView.start()
        // timeLineView.start(from: 3)
    }
    
    @IBAction private func pause(_ sender: UIButton) {
        timeLineView.pause()
    }
    
    @IBAction private func resume(_ sender: UIButton) {
        timeLineView.resume()
    }
    
    @IBAction private func next(_ sender: UIButton) {
        timeLineView.next()
    }
    
    @IBAction private func previous(_ sender: UIButton) {
        timeLineView.pervious()
    }
    
    @IBAction private func reset(_ sender: UIButton) {
        timeLineView.reset()
    }
}

// MARK: - StoryTimeLineDelegate
extension ViewController: StoryTimeLineDelegate {
    func storyTimeLine(_ timeLine: StoryTimeLine.StoryTimeLineView, willStartAnimationAt index: Int) {
        print("willStartAnimationAt", index)
    }
    
    func storyTimeLine(_ timeLine: StoryTimeLine.StoryTimeLineView, didFinishAnimationAt index: Int) {
        print("didFinishAnimationAt", index)
    }
    
    func storyTimeLine(didFinish timeLine: StoryTimeLine.StoryTimeLineView) {
        print("didFinish")
    }
}

