//
//  MainViewController.swift
//  MovieLog
//
//  Created by Jimin on 7/31/25.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {

    private let mainView = Main()
    private var list: [MovieInfo] = []
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNav()
        callRequest()
        
        mainView.searchList.delegate = self
        mainView.searchList.dataSource = self
        mainView.movieList.delegate = self
        mainView.movieList.dataSource = self
        
        mainView.deleteAll.addTarget(self, action: #selector(deleteAllTapped), for: .touchUpInside)
    }
    
    @objc func deleteAllTapped() {
        RecentSearch.clearRecentSearch()
        mainView.searchList.reloadData()
    }
    
    private func configureNav() {
        navigationItem.title = "MovieLog"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonTapped))
        navigationItem.rightBarButtonItem = searchButton
        navigationController?.navigationBar.tintColor = UIColor(hex: "98FB98")
    }
    
    @objc func searchButtonTapped() {
        let vc = EmptyViewController()
        vc.searchClick = {
            self.mainView.searchList.reloadData()
        }
        navigationController?.pushViewController(vc, animated: true)
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = UIColor(hex: "98FB98")
    }
    
    func callRequest() {
        let url = "https://api.themoviedb.org/3/trending/movie/day?language=ko-KR&page=1"
        let header: HTTPHeaders = [
            "Authorization": "Bearer \(APIKey.TMDBToken)"
        ]
        AF.request(url, headers: header)
            .responseDecodable(of: Trending.self) { response in
                switch response.result {
                case .success(let value):
                    self.list.append(contentsOf: value.results)
                    self.mainView.movieList.reloadData()
                case .failure(let error):
                    print("fail: \(error)")
            }
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == mainView.searchList {
            let count = RecentSearch.getRecentSearch().count
            return count == 0 ? 1 : count
        } else {
            return list.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == mainView.searchList {
            let recent = RecentSearch.getRecentSearch()
            if recent.isEmpty {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyCollectionViewCell.identifier, for: indexPath) as! EmptyCollectionViewCell
                mainView.deleteAll.isHidden = true
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentSearchCollectionViewCell.identifier, for: indexPath) as! RecentSearchCollectionViewCell
                cell.title.text = RecentSearch.getRecentSearch()[indexPath.row]
                cell.deleteAction = {
                    RecentSearch.deleteKeyword(index: indexPath.row)
                    collectionView.reloadData()
                }
                mainView.deleteAll.isHidden = false
                return cell
            }
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TodayMovieCollectionViewCell.identifier, for: indexPath) as! TodayMovieCollectionViewCell
            cell.configureData(row: list[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == mainView.searchList {
            if RecentSearch.getRecentSearch().isEmpty {
                return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
            } else {
                return CGSize(width: 85, height: 35)
            }
        } else {
            return CGSize(width: 210, height: 370)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == mainView.searchList {
            guard !RecentSearch.getRecentSearch().isEmpty else { return }
            let vc = SearchViewController()
            navigationController?.pushViewController(vc, animated: true)
            navigationItem.backButtonTitle = ""
            vc.text = RecentSearch.getRecentSearch()[indexPath.row]
        } else {
            let vc = DetailViewController()
            navigationController?.pushViewController(vc, animated: true)
            navigationItem.backButtonTitle = ""
            vc.movieTitle = list[indexPath.row].title
            vc.overview = list[indexPath.row].overview
        }
    }
}
