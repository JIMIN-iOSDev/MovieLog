//
//  CreditAPI.swift
//  MovieLog
//
//  Created by Jimin on 8/4/25.
//

import Foundation

struct CreditInfo: Decodable {
    let id: Int
    let cast: [Cast]
}

struct Cast: Decodable {
    let name: String
    let profile_path: String
    let character: String
}
