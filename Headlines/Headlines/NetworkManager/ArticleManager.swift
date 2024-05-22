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
     Retrieves a list of articles from the server.
     
     - Returns: An array of `Article` objects.
     - Throws: An error if the network call fails or the data cannot be fetched.
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

