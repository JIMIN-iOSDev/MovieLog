//
//  SearchViewController.swift
//  MovieLog
//
//  Created by Jimin on 8/1/25.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {

    private let mainView = Search()
    var list: [Result] = []
    var page = 1
    var isEnd = false
    var text: String?
    var searchClick: (() -> Void)?
    var likeChange: (() -> Void)?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "영화 검색"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        callRequest(query: text!)
        mainView.searchBar.delegate = self
    }
    
    func callRequest(query: String) {
        let url = "https://api.themoviedb.org/3/search/movie?query=\(query)&include_adult=false&language=ko-KR&page=\(page)"
        let header: HTTPHeaders = [
            "Authorization": "Bearer \(APIKey.TMDBToken)"
        ]
        AF.request(url, headers: header)
            .responseDecodable(of: SearchResult.self) { response in
                switch response.result {
                case .success(let value):
                    if self.page < value.total_pages {
                        self.isEnd = false
                    } else {
                        self.isEnd = true
                    }
                    self.list.append(contentsOf: value.results)
                    self.mainView.tableView.reloadData()
                    if self.page == 1 {
                        self.mainView.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                    }
                case .failure(let error):
                    print("fail: \(error)")
            }
        }
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        if UserDefaultsHelper.isLike(id: list[sender.tag].id) {
            UserDefaultsHelper.removeLikeMovie(id: list[sender.tag].id)
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
        } else {
            UserDefaultsHelper.addLikeMovie(id: list[sender.tag].id)
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        cell.configureData(row: list[indexPath.row])
        cell.selectionStyle = .none
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.movieTitle = list[indexPath.row].title
        vc.overview = list[indexPath.row].overview
        vc.movieId = list[indexPath.row].id
        vc.likeChange = {
            tableView.reloadData()
            self.likeChange?()
        }
        navigationController?.pushViewController(vc, animated: true)
        navigationItem.backButtonTitle = ""
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (list.count - 3) && isEnd == false {
            page += 1
            callRequest(query: text!)
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        list.removeAll()
        page = 1
        self.text = mainView.searchBar.text
        callRequest(query: text!)
        UserDefaultsHelper.saveRecentSearch(keyword: text!)
        searchClick?()
        mainView.searchBar.text = ""
        view.endEditing(true)
    }
}
