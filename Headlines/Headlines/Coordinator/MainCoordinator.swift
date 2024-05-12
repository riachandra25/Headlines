//
//  MainCoordinator.swift
//  Headlines
//
//  Copyright © 2023 Example. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Coordinator Protocol
protocol Coordinator {
    var navigationController: UINavigationController { get }
    func start()
}


// MARK: - Main Coordinator
class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // Load Article screen
    func start() {
        let viewModel = ArticlePageViewModel()
        let viewController = ArticlePageViewController(viewModel: viewModel)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
    // Show Favorite List screen
    func showFavorites() {
        let favoriteViewModel = FavoritesViewModel()
        let favoritesViewController = FavouritesViewController(viewModel: favoriteViewModel)
        
        // This has been added for the specific UI requirement
        let navController = UINavigationController(rootViewController: favoritesViewController)
        navController.modalPresentationStyle = .fullScreen
        navigationController.topViewController?.present(navController, animated: true)
    }
}
