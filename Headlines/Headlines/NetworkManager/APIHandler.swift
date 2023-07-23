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
     
     - url: URL  to download articles through API
     - method:  method to pass when making network call
     - completion: completion handler on success/failed API call
     */
    func fetchJSONData<T: Decodable>(with url: URL, method: HTTPMethod, completion: @escaping (_ result: RequestResult<T>) -> ())
}

// MARK: - APIHandlerProtocol Implementation -
struct APIHandler: APIHandlerProtocol {
    
    // session to establish API calls
    private var session : Session
    
    init() {
        let config = URLSessionConfiguration.default
        self.session = Session(configuration: config)
    }
    
    func fetchJSONData<T: Decodable>(with url: URL, method: HTTPMethod, completion: @escaping (_ result: RequestResult<T>) -> ()){
        
        guard let componentURL = prepareComponentURL(url: url)?.url else {
            completion(.failure(error: .configurationError(details: NSLocalizedString("Configuration Error - Bad URL", comment: ""))))
            return
        }
     
        // Network request with generic response decodable
        AF.request(componentURL, method: method).responseDecodable(of: T.self, decoder: JSONDecoder()) { response in
            switch response.result {
            case .success(let value):
                completion(.success(item: value))
            case .failure(_):
                completion(.failure(error: .serverError(details: NSLocalizedString("The server is not available, please try again later", comment: ""))))
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
