//
//  Router.swift
//  MovieLog
//
//  Created by 서지민 on 8/30/25.
//

import Foundation
import Alamofire

enum Router {
    case main
    case detail(Int)
    case search(String, Int)
    
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var endpoint: URL {
        switch self {
        case .main:
            return URL(string: baseURL + "trending/movie/day?language=ko-KR&page=1")!
        case .detail(let id):
            return URL(string: baseURL + "movie/\(id)/images")!
        case .search(let query, let page):
            return URL(string: baseURL + "search/movie?query=\(query)&include_adult=false&language=ko-KR&page=\(page)")!
        }
    }
    
    var header: HTTPHeaders {
        return ["Authorization": "Bearer \(APIKey.TMDBToken)"]
    }
}
