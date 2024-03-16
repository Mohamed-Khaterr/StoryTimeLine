//
//  StoryTimeLineDelegate.swift
//  
//
//  Created by Khater on 16/03/2024.
//

import Foundation

public protocol StoryTimeLineDelegate: AnyObject {
    func storyTimeLine(_ timeLine: StoryTimeLineView, willStartAnimationAt index: Int)
    func storyTimeLine(_ timeLine: StoryTimeLineView, didFinishAnimationAt index: Int)
    func storyTimeLine(didFinish timeLine: StoryTimeLineView)
}

public extension StoryTimeLineDelegate {
    func storyTimeLine(_ timeLine: StoryTimeLineView, willStartAnimationAt index: Int) {}
    func storyTimeLine(_ timeLine: StoryTimeLineView, didFinishAnimationAt index: Int) {}
    func storyTimeLine(didFinish timeLine: StoryTimeLineView) {}
}
