//
//  SearchViewController.swift
//  MovieLog
//
//  Created by Jimin on 8/1/25.
//

import UIKit

class SearchViewController: UIViewController {

    private let mainView = Search()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "영화 검색"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}
