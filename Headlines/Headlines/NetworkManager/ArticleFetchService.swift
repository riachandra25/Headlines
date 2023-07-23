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
     Get the list of articles from server
     
     - parameters:
     
     - success - Returns a success response as a result of network API call
     - failure - Returns an error response as a result of network API call
     */
    func getArticles(success: @escaping (_ articles: [Article]) -> (), failure: @escaping (_ error: HeadlinesError) -> ())
}

struct ArticleFetchService: ArticleFetchServiceProtocol {
    
    private let apiHandler: APIHandlerProtocol
    private let dataStore: StorageHandlerProtocol
    
    init(
        apiHandler: APIHandlerProtocol = APIHandler(),
        storageHandler: StorageHandlerProtocol = DataStore.shared
    ) {
        self.apiHandler = apiHandler
        self.dataStore = storageHandler
    }

    func getArticles(success: @escaping (_ articles: [Article]) -> (), failure: @escaping (_ error: HeadlinesError) -> ()) {
        guard let endpoint = Config.baseURLStr.prepareURL(with: APIEndpoint.search)
        else {
            failure(.configurationError(details: NSLocalizedString("Configuration Error - Bad URL", comment: "")))
            return
        }
        
        apiHandler.fetchJSONData(with: endpoint, method: .get)  { (result: RequestResult<ResultResponse>) in
            switch result {
            case .success(item: let data):
                guard let articles = data.response.results else {
                    return failure(.configurationError(details: NSLocalizedString("There is no article to display", comment: "")))
                }
                //Save data in database storage
                dataStore.saveAllArticles(articles: articles)
                success(articles)
            case .failure(let error):
                failure(error)
            }
        }
    }
}
