//
//  SearchViewController.swift
//  MovieLog
//
//  Created by Jimin on 8/1/25.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {

    private let mainView = Search()
    
    var text: String?
    var page = 1
    var isEnd = false
    
    override func loadView() {
        self.view = mainView
    }
    
    private let disposeBag = DisposeBag()
    
    private let list = BehaviorRelay<[Result]>(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        navigationItem.title = "영화 검색"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        if let text, !text.isEmpty {
            callRequest(query: text)
        }
    }
    
    private func bind() {
        list
            .bind(to: mainView.tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)) { (row, element, cell) in
                cell.configureData(row: self.list.value[row])
                cell.selectionStyle = .none
                cell.likeButton.rx.tap
                    .bind(with: self) { owner, _ in
                        if UserDefaultsHelper.isLike(id: owner.list.value[row].id) {
                            UserDefaultsHelper.removeLikeMovie(id: owner.list.value[row].id)
                            cell.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
                        } else {
                            UserDefaultsHelper.addLikeMovie(id: owner.list.value[row].id)
                            cell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                        }
                    }
                    .disposed(by: cell.disposeBag)
            }
            .disposed(by: disposeBag)
        
        mainView.tableView.rx.itemSelected
            .bind(with: self) { owner, indexPath in
                let vc = DetailViewController()
                vc.movieTitle = owner.list.value[indexPath.row].title
                vc.overview = owner.list.value[indexPath.row].overview
                vc.movieId = owner.list.value[indexPath.row].id
                
                owner.navigationController?.pushViewController(vc, animated: true)
                owner.navigationItem.backButtonTitle = ""
            }
            .disposed(by: disposeBag)
        
        mainView.searchBar.rx.searchButtonClicked
            .bind(with: self) { owner, _ in
                let text = owner.mainView.searchBar.text ?? ""
                owner.text = text
                owner.page = 1
                owner.callRequest(query: text)
                UserDefaultsHelper.saveRecentSearch(keyword: text)
                owner.mainView.searchBar.text = ""
                owner.view.endEditing(true)
            }
            .disposed(by: disposeBag)
        
        mainView.tableView.rx.willDisplayCell
            .filter { _, indexPath in
                return indexPath.row == (self.list.value.count - 3) && (!self.isEnd)
            }
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .bind(with: self) { owner, _ in
                owner.page += 1
                owner.callRequest(query: owner.text!)
            }
            .disposed(by: disposeBag)
    }
    
    private func callRequest(query: String) {
        NetworkManager.shared.callRequest(api: .search(query, page), type: SearchResult.self) { value in
            if self.page < value.total_pages {
                self.isEnd = false
            } else {
                self.isEnd = true
            }
            
            if self.page == 1 {
                self.list.accept(value.results)
                self.mainView.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            } else {
                self.list.accept(self.list.value + value.results)
            }
        }
    }
}
