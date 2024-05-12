//
//  FavoritesViewModel.swift
//  Headlines
//
//  Created by Ria Chandra.
//  Copyright © 2023 Example. All rights reserved.
//

import Foundation

protocol FavoritesViewModelProtocol {
    
    /// return total number of favorite articles
    var totalFavoriteCount: Int { get }
    
    /**
     get the specific article from favourite article list
     
     - Returns:
     
     - index: the index of the array to get the article  details
     */
    func article(at index: Int) -> Article?
    
    /**
     get the list of searched favorite articles
     
     - parameters:
     
     - searchText: user inputted string to search
     */
    func filterArticleList(with searchText: String) -> [Article]?
    
    /**
     filter the article list with user search text
     
     - parameters:
     
     - searchText: user inputted string to search
     */
    func filterArticles(with searchText: String)
}

final class FavoritesViewModel {
    
    var totalFavoriteCount: Int {
        if !favoriteSearchText.isEmpty {
            return filteredList.count
        }
        return dataStore.favoriteCount
    }
    
    private let dataStore: StorageHandlerProtocol
    private var favoriteSearchText: String = ""
    
    private var articles: [Article]? {
        if !favoriteSearchText.isEmpty {
            return filteredList
        }
        return dataStore.favoriteArticles()
    }
    
    private var filteredList: [Article] = []
    
    init(
        dataStore: StorageHandlerProtocol = DataStore.shared
    ) {
        self.dataStore = dataStore
    }
}

extension FavoritesViewModel: FavoritesViewModelProtocol {
    
    func article(at index: Int) -> Article? {
        if index >= 0 && index < articles?.count ?? 0 {
            return articles?[index]
        }
        return nil
    }
    
    func filterArticleList(with searchText: String) -> [Article]? {
        return dataStore.favoriteArticles()?.filter {
            if let webTitle = $0.webTitle {
                return webTitle.lowercased().contains(searchText.lowercased())
            }
            return false
        }
    }
    
    func filterArticles(with searchText: String) {
        favoriteSearchText = searchText
        if let filterArticles = filterArticleList(with: searchText) {
            filteredList = filterArticles
        } else {
            filteredList = []
        }
    }
}

