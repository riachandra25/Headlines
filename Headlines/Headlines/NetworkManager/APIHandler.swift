//
//  APIHandler.swift
//  Headlines
//
//  Created by Ria Chandra.
//  Copyright © 2023 Example. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift


protocol APIHandlerProtocol {
    /**
     Retrieves a list of articles  by making an API call
     
     - parameters:
     
     - type: response model type
     - url: URL  to download articles through API
     - method:  method to pass when making network call
     
     - Returns:
     
     - success - Returns a success response as a result of network API call
     - failure - Returns an error response as a result of network API call     */
    
    func fetchJSONData<T: Decodable>(with type: T.Type, url: URL, method: HTTPMethod) async throws -> T
}

// MARK: - APIHandlerProtocol Implementation -
struct APIHandler: APIHandlerProtocol {
    
    // session to establish API calls
    private var session : Session
    
    init() {
        let config = URLSessionConfiguration.default
        self.session = Session(configuration: config)
    }
    
    
    func fetchJSONData<T: Decodable>(with type: T.Type, url: URL, method: HTTPMethod) async throws -> T {
        guard let componentURL = prepareComponentURL(url: url)?.url else {
            throw(HeadlinesError.configurationError(details: NSLocalizedString("Configuration Error - Bad URL", comment: "")))
        }
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                componentURL,
                method: method
            ).responseDecodable(of: type.self) { response in
                switch response.result {
                case let .success(data):
                    continuation.resume(returning: data)
                case .failure(_):
                    // Here ideally based on different error type, error scenario should be handled. For this sample app, a generic message is passed here
                    continuation.resume(throwing: HeadlinesError.configurationError(details: NSLocalizedString("Network Error, please try again after sometime", comment: "")))
                }
            }
        }
    }
}

// Build URLComponents with query items
private extension APIHandler {
    func buildQueryItems() -> [String: String] {
        return ["q": "fintech",
                "show-fields": "main,body",
                "api-key": Config.APIKey
        ]
    }
    
    func queryItems(dictionary: [String:String]) -> [URLQueryItem] {
        return dictionary.map {
            URLQueryItem(name: $0.0, value: $0.1)
        }
    }
    
    func prepareComponentURL(url: URL) -> URLComponents? {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = queryItems(dictionary: buildQueryItems())
        return components
    }
}
