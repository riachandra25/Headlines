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
public class ResultResponse: Decodable {
    let response: Result
}

public class Result: Decodable {
    let results: [Article]?
}

public class Article: Object, Decodable {
    @Persisted var webTitle: String?
    @Persisted var webPublicationDate: String?
    @Persisted var  fields: Body?
    @Persisted var isFavorite: Bool = false
    
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


public class Body: Object, Decodable {
    @Persisted var body: String?
    @Persisted var main: String?
    
    convenience init(body: String? ,
                     main: String?
    ) {
        self.init()
        self.body = body
        self.main = main
    }
}


