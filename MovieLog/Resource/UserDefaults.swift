//
//  UserDefaults.swift
//  MovieLog
//
//  Created by Jimin on 8/4/25.
//

import Foundation
import RxSwift
import RxCocoa

class UserDefaultsHelper {
    
    private init() {}
    
    static let recentSearches = BehaviorRelay(value: UserDefaults.standard.stringArray(forKey: "recentSearches") ?? [])
    static let likeMovies = BehaviorRelay(value: Set(UserDefaults.standard.array(forKey: "LikeMovie") as? [Int] ?? []))
    
    static func saveRecentSearch(keyword: String) {
        var list = recentSearches.value
        
        if let index = list.firstIndex(of: keyword) {
            list.remove(at: index)
        }
        
        list.insert(keyword, at: 0)
        UserDefaults.standard.set(list, forKey: "recentSearches")
        recentSearches.accept(list)
    }
    
    static func clearRecentSearch() {
        UserDefaults.standard.removeObject(forKey: "recentSearches")
        recentSearches.accept([])
    }
    
    static func deleteKeyword(index: Int) {
        var list = recentSearches.value
        list.remove(at: index)
        UserDefaults.standard.set(list, forKey: "recentSearches")
        recentSearches.accept(list)
    }
    
    static func addLikeMovie(id: Int) {
        var list = likeMovies.value
        list.insert(id)
        UserDefaults.standard.set(Array(list), forKey: "LikeMovie")
        likeMovies.accept(list)
    }
    
    static func removeLikeMovie(id: Int) {
        var list = likeMovies.value
        list.remove(id)
        UserDefaults.standard.set(Array(list), forKey: "LikeMovie")
        likeMovies.accept(list)
    }
    
    static func isLike(id: Int) -> Bool {
        return likeMovies.value.contains(id)
    }
}
