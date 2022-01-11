//
//  ReminderListHeader.swift
//  Today
//
//  Created by Boris Bolshakov on 10.01.22.
//

import UIKit

final class ReminderListHeader: UIView {
    
    private var contentView = UIView()
    var progressContainerView = UIView()
    var heightConstraint: NSLayoutConstraint?
    
    private var percentCompleteView: UIView = {
        let comepleteView = UIView()
        comepleteView.backgroundColor = .lightGray
        return  comepleteView
    }()
    
    private var percentIncompleteView: UIView = {
        let incompleteView = UIView()
        incompleteView.backgroundColor = .systemGray3
        return incompleteView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 320)
    }
    
    func commonInit() {
        
        addSubview(contentView)
        contentView.backgroundColor = .systemGray5
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(progressContainerView)
        progressContainerView.backgroundColor = .purple
        progressContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        progressContainerView.addSubview(percentIncompleteView)
        percentIncompleteView.translatesAutoresizingMaskIntoConstraints = false
        
        progressContainerView.addSubview(percentCompleteView)
        percentCompleteView.translatesAutoresizingMaskIntoConstraints = false
        
        
        // ContentView
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        // ProgressContainerView
        NSLayoutConstraint.activate([
            progressContainerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            progressContainerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            progressContainerView.widthAnchor.constraint(equalToConstant: 260),
            progressContainerView.heightAnchor.constraint(equalToConstant: 260)
        ])
        
        // IncompleteView
        NSLayoutConstraint.activate([
            percentIncompleteView.topAnchor.constraint(equalTo: progressContainerView.topAnchor),
            percentIncompleteView.leadingAnchor.constraint(equalTo: progressContainerView.leadingAnchor),
            percentIncompleteView.trailingAnchor.constraint(equalTo: progressContainerView.trailingAnchor),
            percentIncompleteView.bottomAnchor.constraint(equalTo: percentCompleteView.topAnchor)
        ])
        
        // CompleteView
        NSLayoutConstraint.activate([
            percentCompleteView.leadingAnchor.constraint(equalTo: progressContainerView.leadingAnchor),
            percentCompleteView.trailingAnchor.constraint(equalTo: progressContainerView.trailingAnchor),
            percentCompleteView.bottomAnchor.constraint(equalTo: progressContainerView.bottomAnchor),
        ])
        
        heightConstraint = NSLayoutConstraint(
            item: percentCompleteView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 0
        )
        

        percentCompleteView.addConstraint(heightConstraint ?? percentCompleteView.heightAnchor.constraint(equalToConstant: 130.0))
  
    }
    
}
