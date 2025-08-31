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

enum RecentSearchItem {
    case empty
    case keyword(String)
}

struct RecentSection {
    var items: [RecentSearchItem]
}

extension RecentSection: SectionModelType { // 밑에서 header를 쓸 일이 없으면 굳이 extension으로 분리할 필요가 있나?
    init(original: RecentSection, items: [RecentSearchItem]) {
        self = original
        self.items = items
    }
}

final class MainViewController: UIViewController {

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
    
    private let searchList = BehaviorRelay<[RecentSection]>(value: [])
    private lazy var collectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: recentLayout())
        cv.backgroundColor = .clear
        cv.register(EmptyCollectionViewCell.self, forCellWithReuseIdentifier: EmptyCollectionViewCell.identifier)
        cv.register(RecentSearchCollectionViewCell.self, forCellWithReuseIdentifier: RecentSearchCollectionViewCell.identifier)
        return cv
    }()
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
    private lazy var movieCollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout())
        cv.backgroundColor = .clear
        cv.register(TodayMovieCollectionViewCell.self, forCellWithReuseIdentifier: TodayMovieCollectionViewCell.identifier)
        return cv
    }()
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
        view.backgroundColor = .black
        
        //collectionView.delegate = self
        movieCollectionView.delegate = self
        
        deleteAll.isHidden = UserDefaultsHelper.recentSearches.value.isEmpty
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
        movieCollectionView.reloadData()
    }
    
    private func callRequest() {
        NetworkManager.shared.callRequest(api: .main, type: Trending.self) { value in
            self.movieList.accept(value.results)
        }
    }

    private func bind() {
        let input = MainViewModel.Input(deletAll: deleteAll.rx.tap)
        
        UserDefaultsHelper.likeMovies
            .map { "\($0.count)개의 무비박스 보관 중" }
            .bind(to: likeCount.rx.title())
            .disposed(by: disposeBag)
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<RecentSection>(configureCell: { dataSource, collectionView, indexPath, item in
            switch item {
            case .empty:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyCollectionViewCell.identifier, for: indexPath) as! EmptyCollectionViewCell
                return cell
                
            case .keyword:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentSearchCollectionViewCell.identifier, for: indexPath) as! RecentSearchCollectionViewCell
                cell.title.text = UserDefaultsHelper.recentSearches.value[indexPath.row]
                cell.deleteAction = {
                    UserDefaultsHelper.deleteKeyword(index: indexPath.row)
                    collectionView.reloadData()
                }
                return cell
            }
        })
                
        UserDefaultsHelper.recentSearches
            .map {
                let items: [RecentSearchItem] = $0.isEmpty ? [.empty] : $0.map { .keyword($0) }
                return [RecentSection(items: items)]
            }
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        UserDefaultsHelper.recentSearches
            .map { $0.isEmpty }
            .bind(to: deleteAll.rx.isHidden)
            .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .bind(with: self) { owner, indexPath in
                guard !UserDefaultsHelper.recentSearches.value.isEmpty else { return }
                let vc = SearchViewController()
                vc.text = UserDefaultsHelper.recentSearches.value[indexPath.row]                
                owner.navigationController?.pushViewController(vc, animated: true)
                owner.navigationItem.backButtonTitle = ""
            }
            .disposed(by: disposeBag)
 
        movieList
            .bind(to: movieCollectionView.rx.items(cellIdentifier: TodayMovieCollectionViewCell.identifier, cellType: TodayMovieCollectionViewCell.self)) { (row, element, cell) in
                cell.configureData(row: element)
                cell.likeButton.rx.tap
                    .asDriver()
                    .drive(with: self) { owner, _ in
                        if UserDefaultsHelper.isLike(id: element.id) {
                            UserDefaultsHelper.removeLikeMovie(id: element.id)
                            cell.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
                        } else {
                            UserDefaultsHelper.addLikeMovie(id: element.id)
                            cell.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                        }
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
                let vc = SearchViewController()                
                owner.navigationController?.pushViewController(vc, animated: true)
                owner.navigationItem.backButtonTitle = ""
                owner.navigationController?.navigationBar.tintColor = UIColor(hex: "98FB98")
            }
            .disposed(by: disposeBag)
    }
    
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
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView {
            if UserDefaultsHelper.recentSearches.value.isEmpty {
                return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
            } else {
                return CGSize(width: 85, height: 35)
            }
        } else {
            return CGSize(width: 210, height: 370)
        }
    }
}
