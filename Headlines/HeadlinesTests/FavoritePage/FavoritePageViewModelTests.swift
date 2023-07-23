//
//  FavoritePageViewModelTests.swift
//  HeadlinesTests
//
//  Created by Ria Chandra.
//  Copyright © 2023 Example. All rights reserved.
//

import XCTest
@testable import Headlines

final class FavoritePageViewModelTests: XCTestCase {

    private var sut: FavoritesViewModel!
    private var mockDataStore: MockDataStore!

    override func setUpWithError() throws {
        mockDataStore = MockDataStore.shared
        sut = FavoritesViewModel(dataStore: mockDataStore)
    }
    
    override func tearDownWithError() throws {
        mockDataStore = nil
        sut = nil
    }

    func test_get_article_at_selected_index() {
        let article = sut.article(at: 0)
        XCTAssertEqual(article?.webTitle, "Title")
        XCTAssertEqual(article?.webPublicationDate, "02/02/2023")
        XCTAssertEqual(article?.fields?.body, "body")
        XCTAssertEqual(article?.fields?.main, "main")
        XCTAssertEqual(article?.isFavorite, true)
    }
    
    func test_get_article_at_invalid_selected_index() {
        let article = sut.article(at: 5)
        XCTAssertNil(article)
    }
    
    func test_filter_with_search_criteria() {
        let searchedList = sut.filterArticleList(with: "Title")
        XCTAssertEqual(searchedList?.count, 1)
        XCTAssertEqual(searchedList?.first?.webTitle, "Title")
    }
    
    func test_filter_with_search_criteria_missmatch() {
        let searchedList = sut.filterArticleList(with: "Fail")
        XCTAssertEqual(searchedList?.count, 0)
    }

}
