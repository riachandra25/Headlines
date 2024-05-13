//
//  ArticlePagViewController.swift
//  Headlines
//
//  Created by Ria Chandra.
//  Copyright © 2023 Example. All rights reserved.
//

import UIKit

final class ArticlePageViewController: UIViewController {
    
    var viewModel: ArticlePageViewModel
    var coordinator: MainCoordinator?

    private var pageController: UIPageViewController?
    
    init(viewModel: ArticlePageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = NSLocalizedString("Today's Headlines", comment: "")
        setupPageController()
        displayActivityIndicator(shouldDisplay: true)
        view.backgroundColor = .systemBackground
        getArticlesList()
    }
}

// MARK: - UIPageViewControllerDataSource
extension ArticlePageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if viewModel.canMoveBackward() {
            return currentViewController()
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, 
                            viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        if viewModel.canMoveForward() {
            return currentViewController()
        }
        return nil
    }
}

extension ArticlePageViewController: AlertControl {
    
    //get articles through API call
    func getArticlesList()  {
        Task {
            do {
                let _ = try await viewModel.getArticles()
                DispatchQueue.main.async { [weak self] in
                    guard let self else {
                        return
                    }
                    self.displayActivityIndicator(shouldDisplay: false)
                    self.reload()
                }
            } catch(let error as HeadlinesError) {
                DispatchQueue.main.async { [weak self] in
                    guard let self else {
                        return
                    }
                    self.displayActivityIndicator(shouldDisplay: false)
                    // Ideally, it should show the UI handling the error state with retry or try later message
                    self.displayErrorMessage(with: error)
                }
            }
        }
    }
}

private extension ArticlePageViewController {
    func setupPageController() {
        pageController = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
        pageController?.dataSource = self
        pageController?.view.backgroundColor = .clear
        pageController?.view.frame = CGRect(x: 0,y: 0,width: self.view.frame.width,height: self.view.frame.height)
        if let pageViewController = pageController {
            addChild(pageViewController)
            view.addSubview(pageViewController.view)
        }
       
        pageController?.didMove(toParent: self)
    }
    func reload() {
        let articleViewController = currentViewController()
        pageController?.setViewControllers([articleViewController], direction: .forward, animated: true)
    }
    
    func currentViewController() -> ArticleViewController {
        let articleViewController = ArticleViewController()
        articleViewController.favoriteButtonTapped = { [weak self] in
                self?.coordinator?.showFavorites()
            }
               
        articleViewController.viewModel.selectedIndex = viewModel.selectedIndex
        return articleViewController
    }
    
  
    func displayErrorMessage(with error: HeadlinesError) {
        displayActivityIndicator(shouldDisplay: false)
        displayAlert(with: NSLocalizedString("Error", comment: "") ,
                     message: error.localizedDescription,
                     actions: nil
        )
    }

}
