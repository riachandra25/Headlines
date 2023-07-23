//
//  AnimatedButton.swift
//  Headlines
//
//  Created by Ria Chandra.
//  Copyright © 2023 Example. All rights reserved.
//

import UIKit

class AnimatedButton: UIButton {
    private var isLiked = false
    
    var image: UIImage?
    
    private let unlikedScale: CGFloat = 0.7
    private let likedScale: CGFloat = 1.8
    
    public func flipLikedState(buttonImage: UIImage) {
        image = buttonImage
        isLiked = !isLiked
        animate()
    }
    // add simple animation for favorite button
    private func animate() {
        setImage(image, for: .normal)
        
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            guard let self else {
                return
            }
            let newImage = self.image
            let newScale = self.isLiked ? self.likedScale : self.unlikedScale
            self.transform = transform.scaledBy(x: newScale, y: newScale)
            self.setImage(newImage, for: .normal)
        }, completion: { [weak self] _ in
            UIView.animate(withDuration: 0.1, animations: {
                self?.transform = CGAffineTransform.identity
            })
        })
    }
}
