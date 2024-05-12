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
    var articleHandler: (() async throws -> ([Article]))?

    func fetchArticles() async throws -> [Article]?    {
        fetchArticlesCallCount += 1
        if let articleHandler = articleHandler {
            return try await articleHandler()
        }
        fatalError("fetchArticles returns can't have a default value thus its result must be set")
    }
}
