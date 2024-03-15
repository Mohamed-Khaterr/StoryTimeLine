//
//  File.swift
//  
//
//  Created by Khater on 16/03/2024.
//

import Foundation

public protocol StoryTimeLineDelegate: AnyObject {
    func storyTimeLine(_ timeLine: StoryTimeLine, willStartAnimationAt index: Int)
    func storyTimeLine(_ timeLine: StoryTimeLine, didFinishAnimationAt index: Int)
    func storyTimeLine(didFinish timeLine: StoryTimeLine)
}
