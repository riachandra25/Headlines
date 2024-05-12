//
//  DataStore.swift
//  Headlines
//
//  Created by Ria Chandra.
//  Copyright © 2023 Example. All rights reserved.
//

import Foundation
import RealmSwift

protocol StorageHandlerProtocol {
    
    /// return total number of favorite articles
    var favoriteCount: Int { get }
    
    /**
     save the list of articles in data store
     
     - parameters:
     
     - articles: list of articles to store
     */
    func saveAllArticles(articles: [Article])
    
    /// return the list of all articles
    func allArticles() -> [Article]?
    
    /// return a list of favorite articles
    func favoriteArticles() -> [Article]?
    
    /// update the status of favorite article based on user selection
    func updateFavoriteStatus(for index: Int, status: Bool)
}

// MARK: - StorageHandlerProtocol Implementation -
final class DataStore: StorageHandlerProtocol {
    
    public static let shared = DataStore()
    
    private let realm: Realm
    
    var favoriteCount: Int {
        return allArticles()?.filter {
            $0.isFavorite == true
        }.count ?? 0
    }
    
    private init() {
        realm = try! Realm()
    }
    
    func favoriteArticles() -> [Article]? {
        let favoriteArticles = realm
            .objects(Article.self)
            .filter {
                $0.isFavorite == true
            }
        return Array(favoriteArticles)
    }
    
    func allArticles() -> [Article]? {
        let all = realm.objects(Article.self)
        return Array(all)
    }
    
    @MainActor
    func saveAllArticles(articles: [Article]) {
        Task {
            try? realm.write {
                let updatedList = updateFavoriteArticles(with: articles)
                if let articleList = allArticles() {
                    realm.delete(articleList)
                }
                realm.add(updatedList ?? articles)
            }
        }
    }
    
    func updateFavoriteStatus(for index: Int, status: Bool) {
        try? realm.write {
            let article = allArticles()?[index]
            article?.isFavorite = status
        }
    }
}

private extension DataStore {
    
    func updateFavoriteArticles(with articles: [Article]) -> [Article]? {
        guard let articleList = allArticles(),
              !articleList.isEmpty else {
            return nil
        }
        let favoriteArticles = articleList.filter { $0.isFavorite == true }
        if favoriteArticles.isEmpty {
            return nil
        }
        let updatedList = articles.map {
            let article = $0
            if favoriteArticles.filter(
                { $0.webTitle == article.webTitle }
            ).count > 0 {
                article.isFavorite = true
            }
            return article
        }
        
        return updatedList
    }
}
