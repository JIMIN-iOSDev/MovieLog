//
//  EmptyViewController.swift
//  MovieLog
//
//  Created by Jimin on 8/1/25.
//

import UIKit

class EmptyViewController: UIViewController {

    private let mainView = Empty()
    var searchClick: (() -> Void)?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "영화 검색"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        mainView.searchBar.becomeFirstResponder()
        mainView.searchBar.delegate = self
    }
}

extension EmptyViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let vc = SearchViewController()
        navigationController?.pushViewController(vc, animated: true)
        navigationItem.backButtonTitle = ""
        vc.text = searchBar.text
        RecentSearch.saveRecentSearch(keyword: searchBar.text!)
        searchClick?()
        vc.searchClick = searchClick
        searchBar.text = ""
    }
}

