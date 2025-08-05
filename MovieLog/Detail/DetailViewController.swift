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
    var overview: String?
    var movieId: Int?
    private var likeButton: UIBarButtonItem!
    var likeChange: (() -> Void)?
    private var synopsisExpand = false
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupHeader()
        setupTableViewCell()
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    private func setupNavigationBar() {
        navigationItem.title = movieTitle
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        likeButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(likeButtonTapped))
        navigationItem.rightBarButtonItem = likeButton
        navigationController?.navigationBar.tintColor = UIColor(hex: "98FB98")
        let image = RecentSearch.isLike(id: movieId!) ? "heart.fill" : "heart"
        likeButton.image = UIImage(systemName: image)
    }
    
    @objc func likeButtonTapped() {
        if RecentSearch.isLike(id: movieId!) {
            RecentSearch.removeLikeMovie(id: movieId!)
        } else {
            RecentSearch.addLikeMovie(id: movieId!)
        }
        let image = RecentSearch.isLike(id: movieId!) ? "heart.fill" : "heart"
        likeButton.image = UIImage(systemName: image)
        likeChange?()
    }
    
    private func setupHeader() {
        mainView.tableView.register(DetailTableViewHeader.self, forHeaderFooterViewReuseIdentifier: DetailTableViewHeader.identifier)
    }
    
    private func setupTableViewCell() {
        mainView.tableView.register(SynopsisTitleTableViewCell.self, forCellReuseIdentifier: SynopsisTitleTableViewCell.identifier)
        mainView.tableView.register(SynopsisTableViewCell.self, forCellReuseIdentifier: SynopsisTableViewCell.identifier)
        mainView.tableView.register(CastTitleTableViewCell.self, forCellReuseIdentifier: CastTitleTableViewCell.identifier)
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SynopsisTitleTableViewCell.identifier, for: indexPath) as! SynopsisTitleTableViewCell
            cell.moreButtonTapped = {
                self.synopsisExpand.toggle()
                tableView.reloadRows(at: [IndexPath(row: 1, section: 0), IndexPath(row: 2, section: 0)], with: .automatic)
            }
            cell.updateButtonTitle(expand: synopsisExpand)
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SynopsisTableViewCell.identifier, for: indexPath) as! SynopsisTableViewCell
            if overview == "" {
                cell.synopsis.text = "줄거리가 없습니다"
            } else {
                cell.synopsis.text = overview
            }
            cell.updateLine(expand: synopsisExpand)
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CastTitleTableViewCell.identifier, for: indexPath) as! CastTitleTableViewCell
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 3 {
            return 44
        } else if indexPath.row == 2 {
            return synopsisExpand ? UITableView.automaticDimension : 70
        } else {
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let detailTableViewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: DetailTableViewHeader.identifier) as? DetailTableViewHeader else {
            return UIView()
        }
        return detailTableViewHeader
    }
}
