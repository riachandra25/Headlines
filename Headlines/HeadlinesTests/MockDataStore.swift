//
//  MockDataStore.swift
//  HeadlinesTests
//
//  Created by Ria Chandra.
//  Copyright © 2023 Example. All rights reserved.
//

import XCTest
@testable import Headlines

final class MockDataStore: StorageHandlerProtocol {
    var favoriteCount: Int {
        return ArticleMock.articles().count
    }
    public static let shared = MockDataStore()

    func saveAllArticles(articles: [Article]) {
    }
    
    func allArticles() -> [Article]? {
        return ArticleMock.articles()
    }
    
    func favoriteArticles() -> [Article]? {
        return allArticles()?.filter { $0.isFavorite == true }
    }
    
    func updateFavoriteStatus(for index: Int, status: Bool) {
        let article = allArticles()?[index]
        article?.isFavorite = status
    }
    
    init() {
    }
}
