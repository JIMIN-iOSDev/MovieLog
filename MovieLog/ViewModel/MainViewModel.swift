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
//        let recentCellSelected: ControlEvent<IndexPath>
        let deletAll: ControlEvent<Void>
    }
    
    struct Output {
       
    }
    
    func transform(input: Input) -> Output {
        input.deletAll
            .asDriver()
            .drive(with: self) { owner, _ in
                UserDefaultsHelper.clearRecentSearch()
            }
            .disposed(by: disposeBag)
        
        return Output()
    }
}
