//
//  ArticleViewModelTests.swift
//  HeadlinesTests
//
//  Created by Ria Chandra.
//  Copyright © 2023 Example. All rights reserved.
//

import XCTest
@testable import Headlines

final class ArticleViewModelTests: XCTestCase {
    private var sut: ArticleViewModel!
    private var mockDataStore: MockDataStore!

    override func setUpWithError() throws {
        mockDataStore = MockDataStore.shared
        sut = ArticleViewModel(dataStore: mockDataStore)
    }
    
    override func tearDownWithError() throws {
        mockDataStore = nil
        sut = nil
    }
    
    func test_get_article_at_selected_index() {
        sut.selectedIndex = 0
        let article = sut.selectedArticle()
        XCTAssertEqual(article?.webTitle, "Title")
        XCTAssertEqual(article?.webPublicationDate, "02/02/2023")
        XCTAssertEqual(article?.fields?.body, "body")
        XCTAssertEqual(article?.fields?.main, "main")
        XCTAssertEqual(article?.isFavorite, false)
    }
    
    func test_selected_article() {
        sut.selectedIndex = 0
        let article = sut.selectedArticle()
        XCTAssertEqual(article?.webTitle, "Title")
        XCTAssertEqual(article?.webPublicationDate, "02/02/2023")
        XCTAssertEqual(article?.fields?.body, "body")
        XCTAssertEqual(article?.fields?.main, "main")
        XCTAssertEqual(article?.isFavorite, false)
    }
    
    func test_toggle_status_favorite_article() {
        sut.selectedIndex = 0
        let article = sut.selectedArticle()
        XCTAssertEqual(article?.isFavorite, false)
        sut.toggleStatus(status: true)
        sut.toggleStatus(status: false)
        sut.selectedIndex = 1
        XCTAssertEqual(sut.selectedArticle()?.isFavorite, true)
    }
    
    func test_get_article_at_invalid_selected_index() {
        sut.selectedIndex = 5
        let article = sut.selectedArticle()
        XCTAssertNil(article)
    }

}
