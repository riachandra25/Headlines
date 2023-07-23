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
     
     - parameters:
     
     - completionHandler - Returns a success or failure response as a result of network API call
     */
    func fetchArticles(with completionHandler: @escaping (RequestResult<[Article]>)  -> ())
}

struct ArticleManager: ArticleManagerProtocol {
    
    private let articleFetchService: ArticleFetchServiceProtocol
    
    init(
        articleFetchService: ArticleFetchServiceProtocol = ArticleFetchService()
    ) {
        self.articleFetchService = articleFetchService
    }
    
    func fetchArticles(with completionHandler: @escaping (RequestResult<[Article]>)  -> ()) {
        articleFetchService.getArticles(success: { articles in
            completionHandler(.success(item: articles))
        }, failure: { error in
            completionHandler(.failure(error: error))
        })
    }
}



