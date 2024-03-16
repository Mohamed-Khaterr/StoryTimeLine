//
//  StoryTimeLineView.swift
//
//
//  Created by Khater on 16/03/2024.
//

import UIKit

public class StoryTimeLineView: UIView {
    
    /// The space between each progress bar
    ///
    /// Default is 1
    public var spacing: CGFloat {
        set { stackView.spacing = newValue }
        get { stackView.spacing }
    }
    
    /// The track color of each progress bar
    ///
    /// Default is UIColor.lightGray
    public var trackTintColor: UIColor? = .lightGray {
        didSet {
            for progressBar in progressBars {
                progressBar.trackTintColor = trackTintColor
            }
        }
    }
    
    /// The progress color of each progress bar
    ///
    /// Default is UIColor.white
    public var progressTintColor: UIColor? = .white {
        didSet {
            for progressBar in progressBars {
                progressBar.progressTintColor = progressTintColor
            }
        }
    }
    
    /// CornerRadius of the track and progress
    public var cornerRadius: CGFloat {
        set { 
            layer.cornerRadius = newValue
            for progressBar in progressBars {
                progressBar.cornerRadius = newValue
            }
        }
        
        get { layer.cornerRadius }
    }
    
    // MARK: UI Elements
    private var progressBars = [StoryTimeLineProgressView]()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 1
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Properties
    public weak var delegate: StoryTimeLineDelegate?
    var timer: Timer? {
        willSet {
            timer?.invalidate() // Stop the old timer closure
        }
    }
    var duration: CGFloat?
    var animationHandler: (() -> Void)?
    private var currentProgressBarIndex: Int?
    
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    
    // MARK: Setup UI
    private func setupView() {
        self.backgroundColor = .clear
        setupStackView()
    }
    
    private func setupStackView() {
        self.addSubview(stackView)
        
        // Setup StackView Constraints
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    
    // MARK: User Methods
    
    /// Set the count of progress bars in the Time Line
    /// - Parameter count: Progress bars count
    public func setProgressBarsCount(_ count: Int) {
        for _ in 0..<count {
            let progressBar = StoryTimeLineProgressView()
            progressBar.progressTintColor = progressTintColor
            progressBar.trackTintColor = trackTintColor
            progressBar.cornerRadius = cornerRadius
            progressBar.setProgress(0, animated: false)
            progressBars.append(progressBar)
            stackView.addArrangedSubview(progressBar)
        }
    }
    
    /// Set the time duration that progress bar need to be full
    ///
    /// The default time duration is equal to 1
    ///
    /// - Parameters:
    ///   - duration: Time taken for a single line to finish, default is 1 where 1 is equal to 10 seconds
    public func setAnimatedDuration(_ duration: CGFloat) {
        self.duration = duration
    }
    
    /// Start Animating Time Line
    /// - Parameters:
    ///   - startIndex: Progress bar index to start from and will fill all of the previous progress bars
    ///   - Note: index is base 0
    public func start(from startIndex: Int = 0) {
        guard startIndex >= 0, startIndex < progressBars.count else { return }
        
        if let currentProgressBarIndex = currentProgressBarIndex {
            print("-- currentProgressBarIndex")
            if startIndex > currentProgressBarIndex {
                // Going Forward
                for i in currentProgressBarIndex..<startIndex {
                    DispatchQueue.main.async {
                        // Set all empty progress bars before startIndex to be full
                        self.progressBars[i].setProgress(1, animated: false)
                    }
                }
            } else {
                // Going Backward
                for i in startIndex...currentProgressBarIndex {
                    DispatchQueue.main.async {
                        // Set all fill progress bars after startIndex to be empty
                        self.progressBars[i].setProgress(0, animated: false)
                    }
                }
            }
        } else {
            print("-- Set Progress Bars: \(startIndex)")
            for i in 0..<startIndex {
                print("-- index:", i)
                DispatchQueue.main.async {
                    self.progressBars[i].setProgress(1, animated: false)
                }
            }
        }
        
        var currentIndex = startIndex
        var progressValue: CGFloat = 0.0
        animationHandler = { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if currentIndex >= self.progressBars.count {
                    // All Progress Views are Full
                    self.timer?.invalidate()
                    self.timer = nil // Stop the timer
                    self.delegate?.storyTimeLine(didFinish: self)
                    return
                }
                
                self.currentProgressBarIndex = currentIndex
                progressValue += 0.001
                self.progressBars[currentIndex].setProgress(progressValue, animated: false)
                self.layoutIfNeeded()
            }
            
            if progressValue >= 1 {
                // Current Progress View is Full
                // Go to next Progress View
                self.delegate?.storyTimeLine(self, didFinishAnimationAt: currentIndex)
                currentIndex += 1
                progressValue = 0
                
                if currentIndex < self.progressBars.count {
                    self.delegate?.storyTimeLine(self, willStartAnimationAt: currentIndex)
                }
            }
        }
        
        let duration = self.duration ?? 1 // Default is 1
        
        timer = Timer.scheduledTimer(withTimeInterval: duration * 0.01, repeats: true, block: { [weak self] _ in
            self?.animationHandler?()
        })
    }
    
    
    /// Pause the Time Line Progress
    public func pause() {
        timer?.invalidate()
    }
    
    /// Stop the Time Line Progress
    public func stop() {
        timer = nil
        duration = nil
        animationHandler = nil
    }
    
    /// Resume Time Line Progress
    public func resume() {
        guard let duration = duration else { return }
        timer = Timer.scheduledTimer(withTimeInterval: duration * 0.01, repeats: true, block: { [weak self] _ in
            self?.animationHandler?()
        })
    }
    
    /// Reset the progress bars by making them empty
    /// - Attention: The timer will stop
    public func reset() {
        timer = nil
        
        // Reset previous progress Views
        for progressBar in progressBars {
            progressBar.setProgress(0, animated: false)
        }
        currentProgressBarIndex = nil
    }
    
    /// Fill the current progress bar and start animating on the next progress bar
    public func next() {
        guard let currentProgressBarIndex = currentProgressBarIndex else { return }
        let nextIndex = currentProgressBarIndex + 1
        if nextIndex < progressBars.count {
            start(from: nextIndex)
        }
    }
    
    /// Empty the current progress bar and start animating the previous progress bar
    public func pervious() {
        guard let currentProgressBarIndex = currentProgressBarIndex else { return }
        let previousIndex = currentProgressBarIndex - 1
        if previousIndex >= 0 {
            start(from: previousIndex)
        }
    }
}
