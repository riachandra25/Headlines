//
//  ViewController.swift
//  Headlines
//
//  Created by Ria Chandra.
//  Copyright © 2023 Example. All rights reserved.
//

import UIKit
import SDWebImage

final class ArticleViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var addToFavoriteButton: AnimatedButton!
    @IBOutlet weak var scrollView: UIScrollView!
    var favoriteButtonTapped: (() -> Void)?
    
    private var isButtonSelected: Bool = false
    let viewModel = ArticleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    @IBAction func favouritesButtonPressed() {
        favoriteButtonTapped?()
    }
    
    @IBAction func addToFavoriteButtonClicked() {
        isButtonSelected = !isButtonSelected
        setFavoriteButtonState()
        self.viewModel.toggleStatus(status: isButtonSelected)
    }
}

private extension ArticleViewController {
    
    // bind view model data with view
    func bindViewModel() {
        if let article = viewModel.selectedArticle() {
            headlineLabel.text = article.webTitle
            bodyLabel.text = article.fields?.body?.strippingTags
            imageView.sd_setImage(with: article.fields?.main?.url?.absoluteURL, placeholderImage: UIImage(named: "placeholder.png"))
            isButtonSelected = article.isFavorite
            setInitialState()
        }
    }
    
    // set favorite button image with animation
    func setFavoriteButtonState() {
        if let image = getFavoriteImage() {
            addToFavoriteButton.flipLikedState(buttonImage: image)
        }
    }
    
    // set initial favorite button state
    func setInitialState() {
        if let image = getFavoriteImage() {
            addToFavoriteButton.setLinkedState(buttonImage: image)
        }
    }
    
    // set favorite button image initial state without animation
    func getFavoriteImage() -> UIImage? {
        guard let unselected = UIImage(named: "favourite-off"),
              let selected = UIImage(named: "favourite-on") else {
            return nil
        }
        return isButtonSelected ? selected : unselected
    }
}

