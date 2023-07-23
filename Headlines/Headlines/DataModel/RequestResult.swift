//
//  RequestResult.swift
//  Headlines
//
//  Created by Ria Chandra.
//  Copyright © 2023 Example. All rights reserved.
//

import Foundation

// Enum to capture API response - Success or Failure
public enum RequestResult<T> {
    case success(item: T)
    case failure(error: HeadlinesError)
}

