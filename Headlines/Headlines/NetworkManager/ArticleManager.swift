//
//  ArticleManager.swift
//  Headlines
//
//  Created by Ria Chandra.
//  Copyright © 2023 Example. All rights reserved.
//

import Foundation
protocol ArticleManagerProtocol {
    /**
     Get the list of articles from server
     
     - Returns:
     
     - success - Returns a success response as a result of network API call
     - failure - Returns an error response as a result of network API call
     */
    func fetchArticles() async throws -> [Article]?
}

struct ArticleManager: ArticleManagerProtocol {
    
    private let articleFetchService: ArticleFetchServiceProtocol
    
    init(
        articleFetchService: ArticleFetchServiceProtocol = ArticleFetchService()
    ) {
        self.articleFetchService = articleFetchService
    }
    
    func fetchArticles() async throws -> [Article]? {
        return try await articleFetchService.getArticles()
    }
}

