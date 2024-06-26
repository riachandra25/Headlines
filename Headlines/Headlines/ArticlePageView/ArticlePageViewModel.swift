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
     Fetches the list of articles from the server.
     
     - Returns: An array of `Article` objects.
     - Throws: An error if the network call fails or the data cannot be fetched.
     */
    func getArticles() async throws -> [Article]
    
}


final class ArticlePageViewModel {
    
    var selectedIndex: Int = 0
    
    private let articleManager: ArticleManagerProtocol
    private var articles: [Article] = [] // populate the list of articles fetched through API call
    
    init(
        articleManager: ArticleManagerProtocol = ArticleManager()
    ) {
        self.articleManager = articleManager
    }
}

extension ArticlePageViewModel: ArticlePageViewModelProtocol {
    
    var totalCount: Int {
        return articles.count
    }
    
    func getArticles() async throws -> [Article] {
        
        guard let articles = try await articleManager.fetchArticles() else {
            throw(HeadlinesError.networkError(details: NSLocalizedString("Server Error", comment: "")))
        }
        self.articles = articles
        return articles
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

