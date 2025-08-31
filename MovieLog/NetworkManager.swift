//
//  NetworkManager.swift
//  MovieLog
//
//  Created by 서지민 on 8/30/25.
//

import RxSwift
import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() { }
    
    func callRequest<T: Decodable>(api:Router, type: T.Type) -> Single<T> {
        return Single.create { single in
            AF.request(api.endpoint, headers: api.header)
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let value):
                        single(.success(value))
                    case .failure(let error):
                        single(.failure(error))
                    }
                }
            return Disposables.create()
        }
    }
}
