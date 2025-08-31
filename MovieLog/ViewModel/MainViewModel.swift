//
//  MainViewModel.swift
//  MovieLog
//
//  Created by 서지민 on 8/30/25.
//

import Foundation
import RxSwift
import RxCocoa

class MainViewModel {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let callRequestTrigger: PublishRelay<Void>
        let deletAll: ControlEvent<Void>
        let likeButtonTap: PublishRelay<MovieInfo>
    }
    
    struct Output {
        let movieList: Driver<[MovieInfo]>
    }
    
    private let movieList = BehaviorRelay<[MovieInfo]>(value: [])
    
    func transform(input: Input) -> Output {
        
        input.callRequestTrigger
            .flatMapLatest { _ in
                NetworkManager.shared.callRequest(api: .main, type: Trending.self)
                    .map { $0.results }
            }
            .bind(to: movieList)
            .disposed(by: disposeBag)
        
        input.deletAll
            .asDriver()
            .drive(with: self) { owner, _ in
                UserDefaultsHelper.clearRecentSearch()
            }
            .disposed(by: disposeBag)
        
        input.likeButtonTap
            .bind(with: self) { owner, movie in
                if UserDefaultsHelper.isLike(id: movie.id) {
                    UserDefaultsHelper.removeLikeMovie(id: movie.id)
                } else {
                    UserDefaultsHelper.addLikeMovie(id: movie.id)
                }
                owner.movieList.accept(owner.movieList.value)
            }
            .disposed(by: disposeBag)
        
        return Output(movieList: movieList.asDriver())
    }
}
