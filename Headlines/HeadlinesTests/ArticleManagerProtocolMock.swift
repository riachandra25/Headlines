//
//  ArticleManagerMock.swift
//  HeadlinesTests
//
//  Created by Ria Chandra.
//  Copyright © 2023 Example. All rights reserved.
//

import XCTest
@testable import Headlines

final class ArticleManagerProtocolMock: ArticleManagerProtocol {
    init() {
    }
    private(set) var fetchArticlesCallCount = 0
    var testResponse: RequestResult<[Article]>?
    func fetchArticles(with completionHandler: @escaping (RequestResult<[Article]>)  -> ()) {
        fetchArticlesCallCount += 1
        if let response = testResponse {
             completionHandler(response)
             return
        }
        fatalError("fetchArticles completion handler returns can't have a default value thus its result must be set")
    }
}
