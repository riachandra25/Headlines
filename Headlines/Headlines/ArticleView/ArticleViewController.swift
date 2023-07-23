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
    
    private var isButtonSelected: Bool = false
    let viewModel = ArticleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    @IBAction func favouritesButtonPressed() {
        let favouritesViewController =  FavouritesViewController()
        let navigationController = UINavigationController(rootViewController: favouritesViewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
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
            setFavoriteButtonState()
        }
    }
    
    // set favorite button image with animation
    func setFavoriteButtonState() {
        guard let unselected = UIImage(named: "favourite-off"),
              let selected = UIImage(named: "favourite-on") else {
            return
        }
        let image = isButtonSelected ? selected : unselected
        addToFavoriteButton.flipLikedState(buttonImage: image)
    }
}

// MARK: - UIScrollViewDelegate
extension ArticleViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let parent = self.parent as? ArticlePageViewController,
            parent.dataSource != nil {
            parent.dataSource = nil
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let parent = self.parent as? ArticlePageViewController{
            parent.dataSource = parent
        }
    }
}
