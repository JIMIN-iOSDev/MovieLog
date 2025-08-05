//
//  TrendingAPI.swift
//  MovieLog
//
//  Created by Jimin on 8/3/25.
//

import Foundation

struct Trending: Decodable {
    let results: [MovieInfo]
}

struct MovieInfo: Decodable {
    let title: String
    let overview: String
    let poster_path: String
    let id: Int
}
