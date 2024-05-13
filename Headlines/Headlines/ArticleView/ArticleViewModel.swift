//
//  ArticleViewModel.swift
//  Headlines
//
//  Created by Ria Chandra.
//  Copyright © 2023 Example. All rights reserved.
//

import Foundation
protocol ArticleViewModelProtocol {
    
    /// return total number of  articles count
    var totalCount: Int { get } 
    
    /// get the specific article from article list
    func selectedArticle() -> Article?
    
    ///  method to change the favorite status
    func toggleStatus(status: Bool)

}

final class ArticleViewModel {
    
    var selectedIndex: Int = 0
    var totalCount: Int {
        return articles?.count ?? 0
    }
    private let dataStore: StorageHandlerProtocol
    private var articles: [Article]? {
        return dataStore.allArticles()
    }
    init(
        dataStore: StorageHandlerProtocol = DataStore.shared
    ) {
        self.dataStore = dataStore
    }
    
}

extension ArticleViewModel: ArticleViewModelProtocol {
    
    func selectedArticle() -> Article? {
        if selectedIndex >= 0 && selectedIndex < articles?.count ?? 0 {
            return articles?[selectedIndex]
        }
        return nil
    }
    
    func toggleStatus(status: Bool) {
        dataStore.updateFavoriteStatus(for: selectedIndex, status: status)
    }
}

