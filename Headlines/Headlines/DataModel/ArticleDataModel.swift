//
//  ArticleDataModel.swift
//  Headlines
//
//  Created by Ria Chandra.
//  Copyright © 2023 Example. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

// Data model to store article info fetched through API call
struct ResultResponse: Decodable {
    let response: Result
}

struct Result: Decodable {
    let results: [Article]?
}

@objcMembers class Article: Object, Decodable {
    dynamic var webTitle: String?
    dynamic var webPublicationDate: String?
    dynamic var fields: Body?
    dynamic var isFavorite: Bool = false
    
    enum CodingKeys: String, CodingKey {
      case webTitle,
           webPublicationDate,
           fields
    }
    
    convenience init(webTitle: String? =  nil,
                     webPublicationDate: String? =  nil,
                     fields: Body? = nil,
                     isFavorite: Bool = false
    ) {
        self.init()
        self.webTitle = webTitle
        self.webPublicationDate = webPublicationDate
        self.fields = fields
        self.isFavorite = isFavorite
    }
}


@objcMembers class Body: Object, Decodable {
    dynamic var body: String?
    dynamic var main: String?

    convenience init(body: String? = nil,
         main: String? = nil
    ) {
        self.init()
        self.body = body
        self.main = main
    }
}


