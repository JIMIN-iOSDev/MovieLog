//
//  DetailViewController.swift
//  MovieLog
//
//  Created by Jimin on 8/2/25.
//

import UIKit

class DetailViewController: UIViewController {

    private let mainView = Detail()
    var movieTitle: String?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupHeader()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    private func setupNavigationBar() {
        navigationItem.title = movieTitle
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        let likeButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(likeButtonTapped))
        navigationItem.rightBarButtonItem = likeButton
        navigationController?.navigationBar.tintColor = UIColor(hex: "98FB98")
    }
    
    @objc func likeButtonTapped() {
        print("좋아요 가 눌림")
    }
    
    private func setupHeader() {
        mainView.tableView.register(DetailTableViewHeader.self, forHeaderFooterViewReuseIdentifier: DetailTableViewHeader.identifier)
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let detailTableViewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: DetailTableViewHeader.identifier) as? DetailTableViewHeader else {
            return UIView()
        }
        return detailTableViewHeader
    }
}
