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
    var text: String?
    
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
        let url = "https://api.themoviedb.org/3/search/movie?query=\(query)&include_adult=false&language=ko-KR&page=1"
        let header: HTTPHeaders = [
            "Authorization": "Bearer \(APIKey.TMDBToken)"
        ]
        AF.request(url, headers: header)
            .responseDecodable(of: SearchResult.self) { response in
                switch response.result {
                case .success(let value):
                    self.list.append(contentsOf: value.results)
                    self.mainView.tableView.reloadData()
                case .failure(let error):
                    print("fail")
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
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        list.removeAll()
        callRequest(query: mainView.searchBar.text!)
        mainView.searchBar.text = ""
        view.endEditing(true)
    }
}
