//
//  UserDefaults.swift
//  MovieLog
//
//  Created by Jimin on 8/4/25.
//

import Foundation

class RecentSearch {
    
    private init() {}
    
    static func saveRecentSearch(keyword: String) {
        var list = UserDefaults.standard.stringArray(forKey: "recentSearches") ?? []
        
        if let index = list.firstIndex(of: keyword) {
            list.remove(at: index)
        }
        
        list.insert(keyword, at: 0)
        
        UserDefaults.standard.set(list, forKey: "recentSearches")
    }
    
    static func getRecentSearch() -> [String] {
        return UserDefaults.standard.stringArray(forKey: "recentSearches") ?? []
    }
    
    static func clearRecentSearch() {
        UserDefaults.standard.removeObject(forKey: "recentSearches")
    }
    
    static func deleteKeyword(index: Int) {
        var list = UserDefaults.standard.stringArray(forKey: "recentSearches") ?? []
        list.remove(at: index)
        UserDefaults.standard.set(list, forKey: "recentSearches")
    }
    
}
