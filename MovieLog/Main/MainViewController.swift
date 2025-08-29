//
//  MainViewController.swift
//  MovieLog
//
//  Created by Jimin on 7/31/25.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa
import RxDataSources

struct RecentSection {
    var items: [RecentSearchItem]
}

extension RecentSection: SectionModelType {
    init(original: RecentSection, items: [RecentSearchItem]) {
        self = original
        self.items = items
    }
}

enum RecentSearchItem {
    case empty
    case keyword(String)
}

class MainViewController: UIViewController {

    private let infoBox = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#292929")
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private let nickName = {
        let label = Label(size: 18, weight: .bold, alignment: .left)
        label.text = UserDefaults.standard.string(forKey: "NickName")
        return label
    }()
    
    private let date = {
        let label = Label(size: 13, weight: .regular, alignment: .right)
        label.text = "\(UserDefaults.standard.string(forKey: "Date") ?? "") 가입 >"
        return label
    }()
    
    let likeCount = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hex: "#4A6246")
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.isEnabled = false
        return button
    }()
    
    private let recentSearch = {
        let label = Label(size: 18, weight: .bold, alignment: .left)
        label.text = "최근 검색어"
        return label
    }()
    
    let deleteAll = {
        let button = UIButton()
        button.setTitle("전체 삭제", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.setTitleColor(UIColor(hex: "98FB98"), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    private let dataSource = RxCollectionViewSectionedReloadDataSource<RecentSection>(configureCell: { dataSource, collectionView, indexPath, item in
        switch item {
        case .empty:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyCollectionViewCell.identifier, for: indexPath) as! EmptyCollectionViewCell
            return cell
            
        case .keyword(let text):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentSearchCollectionViewCell.identifier, for: indexPath) as! RecentSearchCollectionViewCell
            cell.title.text = RecentSearch.getRecentSearch()[indexPath.row]
            cell.deleteAction = {
                RecentSearch.deleteKeyword(index: indexPath.row)
                collectionView.reloadData()
            }
            return cell
        }
    })
    
    private let searchList = BehaviorRelay<[RecentSection]>(value: [])
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: recentLayout())
    private func recentLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 4, left: 10, bottom: 10, right: 10)
        return layout
    }
    
    private let todayMovie = {
        let label = Label(size: 18, weight: .bold, alignment: .left)
        label.text = "오늘의 영화"
        return label
    }()
    
    private let movieList = BehaviorRelay<[MovieInfo]>(value: [])
    private lazy var movieCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    private func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 4, right: 10)
        return layout
    }
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callRequest()
        bind()
        configureNav()
        configureHierarchy()
        configureLayout()
        
        collectionView.register(EmptyCollectionViewCell.self, forCellWithReuseIdentifier: EmptyCollectionViewCell.identifier)
        collectionView.register(RecentSearchCollectionViewCell.self, forCellWithReuseIdentifier: RecentSearchCollectionViewCell.identifier)
        movieCollectionView.register(TodayMovieCollectionViewCell.self, forCellWithReuseIdentifier: TodayMovieCollectionViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
        movieCollectionView.reloadData()
        likeCount.setTitle("\(RecentSearch.getLikeMovies().count)개의 무비박스 보관중", for: .normal)
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
                    self.movieList.accept(value.results)
                case .failure(let error):
                    print("fail: \(error)")
            }
        }
    }

    private func bind() {
                
        searchList
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        searchList
            .map {
                !($0.first?.items.contains {
                    if case .keyword = $0 { return true }
                    return false
                } ?? false)
            }
            .bind(to: deleteAll.rx.isHidden)
            .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .withLatestFrom(searchList) { indexPath, sections in
                return indexPath
            }
            .bind(with: self) { owner, indexPath in                
                guard !RecentSearch.getRecentSearch().isEmpty else { return }
                let vc = SearchViewController()
                vc.text = RecentSearch.getRecentSearch()[indexPath.row]
                vc.likeChange = {
                    owner.collectionView.reloadData()
                }
                owner.navigationController?.pushViewController(vc, animated: true)
                owner.navigationItem.backButtonTitle = ""
            }
            .disposed(by: disposeBag)
        
        deleteAll.rx.tap
            .asDriver()
            .drive(with: self) { owner, _ in
                RecentSearch.clearRecentSearch()
                owner.collectionView.reloadData()
            }
            .disposed(by: disposeBag)
        
        movieList
            .bind(to: movieCollectionView.rx.items(cellIdentifier: TodayMovieCollectionViewCell.identifier, cellType: TodayMovieCollectionViewCell.self)) { (row, element, cell) in
                cell.configureData(row: element)
                cell.likeButton.rx.tap
                    .asDriver()
                    .drive(with: self) { owner, _ in
                        if RecentSearch.isLike(id: element.id) {
                            RecentSearch.removeLikeMovie(id: element.id)
                            cell.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
                        } else {
                            RecentSearch.addLikeMovie(id: element.id)
                            cell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                        }
                        owner.likeCount.setTitle("\(RecentSearch.getLikeMovies().count)개의 무비박스 보관중", for: .normal)
                    }.disposed(by: cell.disposeBag)                
            }
            .disposed(by: disposeBag)
        
        movieCollectionView.rx.itemSelected
            .withLatestFrom(movieList) { indexPath, movie in
                return movie[indexPath.row]
            }
            .bind(with: self) { owner, movie in
                let vc = DetailViewController()
                vc.movieTitle = movie.title
                vc.overview = movie.overview
                vc.movieId = movie.id
                vc.likeChange = {
                    
                }
                owner.navigationController?.pushViewController(vc, animated: true)
                owner.navigationItem.backButtonTitle = ""
            }
            .disposed(by: disposeBag)
    }
    
    private func configureNav() {
        navigationItem.title = "MovieLog"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = searchButton
        navigationController?.navigationBar.tintColor = UIColor(hex: "98FB98")
        searchButton.rx.tap
            .asDriver()
            .drive(with: self) { owner, _ in
                let vc = EmptyViewController()
                vc.searchClick = {
                    self.collectionView.reloadData()
                }
                owner.navigationController?.pushViewController(vc, animated: true)
                owner.navigationItem.backButtonTitle = ""
                owner.navigationController?.navigationBar.tintColor = UIColor(hex: "98FB98")
            }
            .disposed(by: disposeBag)
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    private func configureHierarchy() {
        [infoBox, nickName, date, likeCount, recentSearch, deleteAll, collectionView, todayMovie, movieCollectionView]
            .forEach { view.addSubview($0) }
    }
    
    private func configureLayout() {
        infoBox.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(120)
        }
        nickName.snp.makeConstraints { make in
            make.top.equalTo(infoBox.snp.top).offset(20)
            make.leading.equalTo(infoBox.snp.leading).offset(20)
        }
        date.snp.makeConstraints { make in
            make.centerY.equalTo(nickName.snp.centerY)
            make.trailing.equalTo(infoBox.snp.trailing).offset(-20)
        }
        likeCount.snp.makeConstraints { make in
            make.top.equalTo(nickName.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(infoBox.snp.horizontalEdges).inset(20)
            make.height.equalTo(44)
        }
        recentSearch.snp.makeConstraints { make in
            make.top.equalTo(infoBox.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(15)
        }
        deleteAll.snp.makeConstraints { make in
            make.centerY.equalTo(recentSearch.snp.centerY)
            make.trailing.equalToSuperview().offset(-15)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(recentSearch.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(80)
        }
        todayMovie.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.leading.equalToSuperview().offset(15)
        }
        movieCollectionView.snp.makeConstraints { make in
            make.top.equalTo(todayMovie.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-8)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView {
            if RecentSearch.getRecentSearch().isEmpty {
                return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
            } else {
                return CGSize(width: 85, height: 35)
            }
        } else {
            return CGSize(width: 210, height: 370)
        }
    }
}
