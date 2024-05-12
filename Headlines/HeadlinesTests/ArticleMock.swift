//
//  ArticleMock.swift
//  HeadlinesTests
//
//  Created by Ria Chandra.
//  Copyright © 2023 Example. All rights reserved.
//

import XCTest
@testable import Headlines
import RealmSwift
import Realm

struct ArticleMock {
    
    static func articles() -> [Article] {
        let article1 = Article(webTitle: "Title",
                              webPublicationDate: "02/02/2023",
                              fields: Body(body: "body",
                              main: "main"),
                              isFavorite: false
                            )
        let article2 = Article(webTitle: "Title",
                              webPublicationDate: "02/02/2023",
                              fields: Body(body: "body",
                              main: "main"),
                              isFavorite: true
                            )
        return [article1, article2]
    }
}
