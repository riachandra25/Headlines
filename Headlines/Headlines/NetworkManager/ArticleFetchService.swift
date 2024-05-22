//
//  ArticleFetchService.swift
//  Headlines
//
//  Created by Ria Chandra.
//  Copyright © 2023 Example. All rights reserved.
//

import Foundation

protocol ArticleFetchServiceProtocol {
    /**
     Retrieves a list of articles from the server.
     
     - Returns: An array of `Article` objects.
     - Throws: An error if the network call fails or the data cannot be fetched.
     */
    func getArticles() async throws -> [Article]
}

struct ArticleFetchService: ArticleFetchServiceProtocol {
    
    private let apiHandler: APIHandlerProtocol
    private let dataStore: StorageHandlerProtocol
    
    init(
        apiHandler: APIHandlerProtocol = APIHandler.shared,
        storageHandler: StorageHandlerProtocol = DataStore.shared
    ) {
        self.apiHandler = apiHandler
        self.dataStore = storageHandler
    }
    
    func getArticles() async throws -> [Article] {
        guard let endpoint = Config.baseURLStr.prepareURL(with: APIEndpoint.search)
        else {
            throw(HeadlinesError.configurationError(details: NSLocalizedString("Configuration Error - Bad URL", comment: "")))
        }
        
        do {
            let result = try await apiHandler.fetchJSONData(with: ResultResponse.self, url : endpoint, method: .get)
            guard let results = result.response.results else {
                throw(HeadlinesError.serverError(details: NSLocalizedString("Server Error", comment: "")))
            }
            dataStore.saveAllArticles(articles: results)
            return results
            
        } catch(let error as HeadlinesError) {
            throw error
        }
        
    }
}
