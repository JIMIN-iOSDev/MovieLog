//
//  SearchAPI.swift
//  MovieLog
//
//  Created by Jimin on 8/1/25.
//

import Foundation

struct SearchResult: Decodable {
    let results: [Result]
    let total_pages: Int
    let total_results: Int
}

struct Result: Decodable {
    let title: String
    let poster_path: String
    let genre_ids: [Int]
    let release_date: String
    let overview: String
    let id: Int
}
