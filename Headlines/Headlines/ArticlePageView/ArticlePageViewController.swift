//
//  ArticlePagViewController.swift
//  Headlines
//
//  Created by Ria Chandra.
//  Copyright © 2023 Example. All rights reserved.
//

import UIKit

final class ArticlePageViewController: UIPageViewController {
    
    var loadingActivityView: UIActivityIndicatorView?
    let viewModel = ArticlePageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingActivityView = UIActivityIndicatorView(style: .gray)
        startActivityView()
        view.backgroundColor = .white
        self.dataSource = self
        getArticles()
    }
}

// MARK: - UIPageViewControllerDataSource
extension ArticlePageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if viewModel.canMoveBackward() {
            return (pageViewController as? ArticlePageViewController)?.viewController()
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewModel.canMoveForward() {
            return (pageViewController as? ArticlePageViewController)?.viewController()
        }
        return nil
    }
}

extension ArticlePageViewController: AlertControl {
    
    //get articles through API call
    func getArticles() {
        viewModel.getArticlesList { response in
            DispatchQueue.main.async { [weak self] in
                guard let self else {
                    return
                }
                self.stopActivityView()
                switch response {
                case .success(item: ):
                    self.reload()
                case .failure(error: let error):
                    // Ideally this should be a toastview
                    // Separate error view with retry button should be displayed
                    let action = UIAlertAction(title: "OK", style: .default)
                    self.displayAlert(with: "Alert" ,
                                       message: error.errorDescription ?? "" ,
                                       actions: [action]
                    )
                }
            }
        }
    }
}

private extension ArticlePageViewController {
    
    func reload() {
        let articleViewController = viewController()
        setViewControllers([articleViewController], direction: .forward, animated: true)
    }
    
    func viewController() -> ArticleViewController {
        let articleViewController = ArticleViewController()
        articleViewController.viewModel.selectedIndex = viewModel.selectedIndex
        return articleViewController
    }
    
    func startActivityView() {
        guard let loadingView = loadingActivityView else {
            return
        }
        loadingView.startAnimating()
        loadingView.center = self.view.center
        view.addSubview(loadingView)
    }
    
    func stopActivityView() {
        guard let loadingView = loadingActivityView else {
            return
        }
        loadingView.stopAnimating()
        loadingView.removeFromSuperview()
    }
}
