//
//  ArticlePageViewModel.swift
//  Headlines
//
//  Created by Ria Chandra.
//  Copyright © 2023 Example. All rights reserved.
//
import Foundation

protocol ArticlePageViewModelProtocol {
    
    /// return total number of  articles count
    var totalCount: Int { get }
    
    /**
     Get the list of articles from server
     
     - parameters:
     
     - completionHandler - Returns a success or failure response as a result of network API call
     */
    func getArticlesList(with completionHandler: @escaping (RequestResult<[Article]>)  -> ())
    
}


final class ArticlePageViewModel {
    var selectedIndex: Int = 0
    var totalCount: Int {
        return articles.count
    }
    private var isFetchInProgress: Bool = false // check if article fetching is in progress
    private let articleManager: ArticleManagerProtocol
    private var articles: [Article] = [] // populate the list of articles fetched through API call
    init(
        articleManager: ArticleManagerProtocol = ArticleManager()
    ) {
        self.articleManager = articleManager
    }
}

extension ArticlePageViewModel: ArticlePageViewModelProtocol {
  
    func getArticlesList(with completionHandler: @escaping (RequestResult<[Article]>)  -> ()) {
        guard !isFetchInProgress else {
          return
        }
        isFetchInProgress  = true
        articleManager.fetchArticles { [weak self] result in
            guard let self else {
              return
            }
            self.isFetchInProgress = false
            switch result {
            case .success(item: let articles):
                self.articles = articles
                completionHandler(.success(item: articles))
            case .failure(error: let error):
                completionHandler(.failure(error: error))
            }
        }
    }
    
    // Check if the page can be swipped backward
    func canMoveBackward() -> Bool {
        if selectedIndex > 0 && selectedIndex < totalCount {
            selectedIndex -= 1
            return true
        }
        return false
    }
    
    // Check if the page can be swipped forward
    func canMoveForward() -> Bool {
        if selectedIndex >= 0 && selectedIndex < totalCount - 1 {
            selectedIndex += 1
            return true
        }
        return false
    }
}

