
//  ArticlePageViewModel.swift
//  HeadlinesTests
//
//  Created by Ria Chandra.
//  Copyright © 2023 Example. All rights reserved.


import XCTest
@testable import Headlines

final class ArticlePageViewModelTests: XCTestCase {
    private var sut: ArticlePageViewModel!
    private var mockArticleManager: ArticleManagerProtocolMock!

    override func setUpWithError() throws {
        mockArticleManager = ArticleManagerProtocolMock()
        sut = ArticlePageViewModel(articleManager: mockArticleManager)
    }

    override func tearDownWithError() throws {
        mockArticleManager = nil
        sut = nil
    }
    
    func test_getArticleList_success_response() {
        let articles = ArticleMock.articles()
        mockArticleManager.testResponse = RequestResult.success(item: articles)
        let expectation = expectation(description: "Fetch the articles")
        sut.getArticlesList { response in
            switch response {
            case .success(item: let articles):
                XCTAssertEqual(articles.count, 2)
                let article = articles.first
                XCTAssertEqual(article?.webTitle, "Title")
                XCTAssertEqual(article?.webPublicationDate, "02/02/2023")
                XCTAssertEqual(article?.fields?.body, "body")
                XCTAssertEqual(article?.fields?.main, "main")
                XCTAssertEqual(article?.isFavorite, false)
                expectation.fulfill()
            default:
              XCTFail()
            }
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test_getArticleList_failure_response_with_configuration_error() {
        mockArticleManager.testResponse = RequestResult.failure(error: .configurationError(details: "Configuration Error"))
        let expectation = expectation(description: "Error handler for article response")
        sut.getArticlesList { response in
            switch response {
            case .failure(error: let error):
                XCTAssertNotNil(error)
                XCTAssertEqual(error.errorDescription, "Configuration Error")
                expectation.fulfill()
            default:
              XCTFail()
            }
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test_getArticleList_failure_response_with_network_error() {
        mockArticleManager.testResponse = RequestResult.failure(error: .networkError(details: "Server Error"))
        let expectation = expectation(description: "Error handler for article response")
        sut.getArticlesList { response in
            switch response {
            case .failure(error: let error):
                XCTAssertNotNil(error)
                XCTAssertEqual(error.errorDescription, "Server Error")
                expectation.fulfill()
            default:
              XCTFail()
            }
        }
        wait(for: [expectation], timeout: 10)
    }
    
    func test_pages_can_move_forward_and_backward() {
        mockArticleManager.testResponse = RequestResult.success(item: ArticleMock.articles())
        let expectation = expectation(description: "Fetch the articles")
        sut.getArticlesList { response in
            switch response {
            case .success(item: let articles):
                XCTAssertEqual(articles.count, 2)
                expectation.fulfill()
            default:
              XCTFail()
            }
        }
        sut.selectedIndex = 0
        XCTAssertEqual(sut.canMoveForward(), true)
        XCTAssertEqual(sut.selectedIndex, 1)
        XCTAssertEqual(sut.canMoveForward(), false)
        XCTAssertEqual(sut.selectedIndex, 1)
        XCTAssertEqual(sut.canMoveBackward(), true)
        XCTAssertEqual(sut.selectedIndex, 0)
        XCTAssertEqual(sut.canMoveBackward(), false)
        XCTAssertEqual(sut.selectedIndex, 0)
        wait(for: [expectation], timeout: 10)
    }
}
