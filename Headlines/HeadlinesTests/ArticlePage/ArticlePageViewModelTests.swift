
//  ArticlePageViewModel.swift
//  HeadlinesTests
//
//  Created by Ria Chandra.
//  Copyright © 2023 Example. All rights reserved.


import XCTest
import RealmSwift
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
    
    func test_getArticleList_success_response()  {
        let articleData = ArticleMock.articles()
        mockArticleManager.articleHandler = { articleData }
        let expectation = expectation(description: "Fetch the articles")
        Task {
            do {
                
                let articles = try await sut.getArticles()
                
                // Then
                XCTAssertEqual(articles.count, 2) // Assuming the mock returns 2 articles
                let article = articles.first
                XCTAssertEqual(article?.webTitle, "Title")
                XCTAssertEqual(article?.webPublicationDate, "02/02/2023")
                XCTAssertEqual(article?.fields?.body, "body")
                XCTAssertEqual(article?.fields?.main, "main")
                XCTAssertEqual(article?.isFavorite, false)
                expectation.fulfill()
            } catch {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
        wait(for: [expectation], timeout: 20)
    }
    
    func test_getArticleList_failure_response_with_configuration_error() {
        mockArticleManager.articleHandler = { throw HeadlinesError.configurationError(details: "Configuration Error")
        }
        let expectation = expectation(description: "Error handler for article response")
        Task {
            do {
                _ = try await sut.getArticles()
                XCTFail("Expected an error but got success")
            } catch(let error as HeadlinesError) {
                XCTAssertNotNil(error)
                
                XCTAssertEqual(error.localizedDescription, "Configuration Error")
                expectation.fulfill()

            }
        }
        wait(for: [expectation], timeout: 20)

    }
    
    func test_getArticleList_failure_response_with_network_error() {
        mockArticleManager.articleHandler = { throw HeadlinesError.networkError(details: "Server Error")
        }
        let expectation = expectation(description: "Error handler for article response")
        Task {
            do {
                _ = try await sut.getArticles()
                XCTFail("Expected an error but got success")
            } catch(let error as HeadlinesError) {
                XCTAssertNotNil(error)
                XCTAssertEqual(error.localizedDescription, "Server Error")
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 20)

    }

    func test_pages_can_move_forward_and_backward() {
        let articleData = ArticleMock.articles()
        mockArticleManager.articleHandler = { articleData }
        let expectation = expectation(description: "Fetch the articles")
        Task {
            do {
                let _ = try await sut.getArticles()
                sut.selectedIndex = 0
                XCTAssertEqual(sut.canMoveForward(), true)
                XCTAssertEqual(sut.selectedIndex, 1)
                XCTAssertEqual(sut.canMoveForward(), false)
                XCTAssertEqual(sut.selectedIndex, 1)
                XCTAssertEqual(sut.canMoveBackward(), true)
                XCTAssertEqual(sut.selectedIndex, 0)
                XCTAssertEqual(sut.canMoveBackward(), false)
                XCTAssertEqual(sut.selectedIndex, 0)
                expectation.fulfill()
            } catch {
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
        wait(for: [expectation], timeout: 10)
    }
}
