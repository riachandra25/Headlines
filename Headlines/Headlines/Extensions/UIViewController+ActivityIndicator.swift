//
//  UIViewController+ActivityIndicator.swift
//  Headlines
//
//  Copyright © 2023 Example. All rights reserved.
//

import Foundation
import UIKit


// Simple loading indicator component
extension UIViewController {
    private var activityIndicator: UIActivityIndicatorView? {
        return view.subviews.compactMap { $0 as? UIActivityIndicatorView }.first
    }
    
    public func displayActivityIndicator(shouldDisplay: Bool) -> Void {
        if shouldDisplay {
            showActivityIndicator() // display loading indicator
        } else {
            hideActivityIndicator() // hide loading indicator
        }
    }
    private func showActivityIndicator(style: UIActivityIndicatorView.Style = .medium, color: UIColor? = nil) {
        guard activityIndicator == nil else {
            return
        }
        let activityIndicator = UIActivityIndicatorView(style: style)
        activityIndicator.center = self.view.center
        if let color = color {
            activityIndicator.color = color
        }
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
    }
    
    private func hideActivityIndicator() {
        self.activityIndicator?.stopAnimating()
        self.activityIndicator?.removeFromSuperview()
    }
}
