//
//  AlertControl+Extension.swift
//  Headlines
//
//  Created by Ria Chandra.
//  Copyright © 2023 Example. All rights reserved.
//

import UIKit

protocol AlertControl {
    
    func displayAlert(with title: String, message: String, actions: [UIAlertAction]?)
}

// alert control extension to display message on viewcontroller
extension AlertControl where Self: UIViewController {
    
    func displayAlert(with title: String, message: String, actions: [UIAlertAction]? = nil) {
        guard presentedViewController == nil else {
            return
        }
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .actionSheet
        )
        
        // present the alert for 2 seconds, not to block the UI as this is just a simple toast message. In real project, it should display a screen capturing error state
        present(alertController, animated: true) {
            Timer.scheduledTimer(withTimeInterval: 2,
                                 repeats: false,
                                 block: { (_) in
                alertController
                    .dismiss(
                        animated: true,
                        completion: nil
                    )
            }
            )
        }
    }
}
