//
//  ImageAPI.swift
//  MovieLog
//
//  Created by Jimin on 8/5/25.
//

import Foundation

struct Image: Decodable {
    let backdrops: [Backdrops]
}

struct Backdrops: Decodable {
    let file_path: String
}
