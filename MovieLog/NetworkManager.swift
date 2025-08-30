//
//  NetworkManager.swift
//  MovieLog
//
//  Created by 서지민 on 8/30/25.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() { }
    
    func callRequest<T: Decodable>(api:Router, type: T.Type, success: @escaping (T) -> Void) {
        AF.request(api.endpoint, headers: api.header)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    success(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
