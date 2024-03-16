//
//  StoryTimeLineProgressView.swift
//
//
//  Created by Khater on 16/03/2024.
//

import Foundation
import UIKit

public class StoryTimeLineProgressView: UIView {
    
    // MARK: - Private Properties
    private let progressBar: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var progressBarWidthConstraint: NSLayoutConstraint = progressBar.widthAnchor.constraint(equalToConstant: 0)
    
    // MARK: - Public Properties
    
    /// Track tint color
    public var trackTintColor: UIColor? {
        set { backgroundColor = newValue }
        get { backgroundColor }
    }
    
    /// Progress bar tint color
    public var progressTintColor: UIColor? {
        set { progressBar.backgroundColor = newValue }
        get { progressBar.backgroundColor }
    }
    
    /// Current value of the progress bar
    public var progress: CGFloat {
        layoutIfNeeded()
        return progressBarWidthConstraint.constant / frame.width
    }
    
    /// CornerRadius of the track and progress
    public var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            progressBar.layer.cornerRadius = newValue
        }
        get { layer.cornerRadius }
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProgressView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupProgressView()
    }
    
    // MARK: - Setup
    private func setupProgressView() {
        backgroundColor = .lightGray
        clipsToBounds = true
        setProgressBarConstraints()
    }
    
    private func setProgressBarConstraints() {
        self.addSubview(progressBar)
        
        NSLayoutConstraint.activate([
            progressBar.topAnchor.constraint(equalTo: self.topAnchor),
            progressBar.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            progressBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            progressBarWidthConstraint
        ])
    }
    
    // MARK: - Methods
    public func setProgress(_ progress: CGFloat, animated: Bool) {
        layoutIfNeeded()
        if animated {
            UIView.animate(withDuration: 1) { [weak self] in
                self?.updateProgressBarValue(progress)
            }
        } else {
            self.updateProgressBarValue(progress)
        }
    }
    
    private func updateProgressBarValue(_ newValue: CGFloat) {
        let multiplier: CGFloat
        if newValue > 1 {
            multiplier = 1
        } else if newValue < 0 {
            multiplier = 0
        } else {
            multiplier = newValue
        }
        
        progressBarWidthConstraint.constant = frame.width * multiplier
        progressBar.layoutIfNeeded()
    }
}
