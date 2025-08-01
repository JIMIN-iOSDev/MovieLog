//
//  MainViewController.swift
//  MovieLog
//
//  Created by Jimin on 7/31/25.
//

import UIKit

class MainViewController: UIViewController {

    private let mainView = Main()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNav()
    }
    
    private func configureNav() {
        navigationItem.title = "MovieLog"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
        navigationItem.rightBarButtonItem = searchButton
        navigationController?.navigationBar.tintColor = UIColor(hex: "98FB98")
    }
    
    @objc func searchButtonTapped() {
        navigationController?.pushViewController(EmptyViewController(), animated: true)
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = UIColor(hex: "98FB98")
    }
}
