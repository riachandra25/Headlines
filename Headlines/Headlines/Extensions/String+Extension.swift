//
//  String+Extension.swift
//  Headlines
//
//  Created by Ria Chandra.
//  Copyright © 2023 Example. All rights reserved.
//

import Foundation

extension String {
    
  //convert string to url with endpoint
  func prepareURL(with endPoint: APIEndpoint) -> URL? {
    guard let endpointUrl = URL(string: self)
       else {
         return nil
     }
    return endpointUrl.appendingPathComponent(endPoint.rawValue)
  }
    
    // Strip tags from string
    var strippingTags: String {
        var result = self.replacingOccurrences(of: "</p> <p>", with: "\n\n") as NSString
        
        var range = result.range(of: "<[^>]+>", options: .regularExpression)
        while range.location != NSNotFound {
            result = result.replacingCharacters(in: range, with: "") as NSString
            range = result.range(of: "<[^>]+>", options: .regularExpression)
        }
        return result as String
    }
    
    var url: URL? {
        guard let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else { return nil }
        let matches = detector.matches(in: self, options: [], range: NSRange(location: 0, length: (self as NSString).length))
        return matches.first?.url
    }
}
