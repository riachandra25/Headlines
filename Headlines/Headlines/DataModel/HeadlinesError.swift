//
//  HeadlinesError.swift
//  Headlines
//
//  Created by Ria Chandra.
//  Copyright © 2023 Example. All rights reserved.
//

import Foundation

// Enum to capture different error scenario after making API call
public enum HeadlinesError: Error {
    case parsingFailed(details: String)
    case networkError(details: String)
    case configurationError(details: String)
    case serverError(details: String)
}

// set customised error description to display in the UI
extension HeadlinesError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .parsingFailed(let detail),
             .networkError(let detail),
             .configurationError(let detail),
             .serverError(let detail):
            return detail
        }
    }
}
