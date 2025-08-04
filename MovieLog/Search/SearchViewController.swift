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
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        cell.configureData(row: list[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        navigationController?.pushViewController(vc, animated: true)
        navigationItem.backButtonTitle = ""
        vc.movieTitle = list[indexPath.row].title
        vc.overview = list[indexPath.row].overview
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
        RecentSearch.saveRecentSearch(keyword: text!)
        searchClick?()
        mainView.searchBar.text = ""
        view.endEditing(true)
    }
}
