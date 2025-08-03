//
//  Main.swift
//  MovieLog
//
//  Created by Jimin on 7/31/25.
//

import UIKit
import SnapKit

class Main: BaseView {

    private let infoBox = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#292929")
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private let nickName = {
        let label = Label(size: 18, weight: .bold, alignment: .left)
        label.text = "달콤한 기모청바지"
        return label
    }()
    
    private let date = {
        let label = Label(size: 13, weight: .regular, alignment: .right)
        label.text = "88.88.88 가입 >"
        return label
    }()
    
    private let likeCount = {
        let button = UIButton()
        button.setTitle("1000개의 무비박스 보관중", for: .normal)
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
    
    private let deleteAll = {
        let button = UIButton()
        button.setTitle("전체 삭제", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.setTitleColor(UIColor(hex: "98FB98"), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    let searchList = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: recentLayout())
        cv.backgroundColor = .clear
        cv.register(RecentSearchCollectionViewCell.self, forCellWithReuseIdentifier: RecentSearchCollectionViewCell.identifier)
        return cv
    }()
    
    static func recentLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 85, height: 35)
        layout.sectionInset = UIEdgeInsets(top: 4, left: 10, bottom: 10, right: 10)
        return layout
    }
    
    private let todayMovie = {
        let label = Label(size: 18, weight: .bold, alignment: .left)
        label.text = "오늘의 영화"
        return label
    }()
    
    let movieList = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout())
        cv.backgroundColor = .clear
        cv.register(TodayMovieCollectionViewCell.self, forCellWithReuseIdentifier: TodayMovieCollectionViewCell.identifier)
        return cv
    }()
    
    static func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        layout.itemSize = CGSize(width: 210, height: 370)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 4, right: 10)
        return layout
    }
    
    override func configureHierarchy() {
        addSubview(infoBox)
        addSubview(nickName)
        addSubview(date)
        addSubview(likeCount)
        addSubview(recentSearch)
        addSubview(deleteAll)
        addSubview(searchList)
        addSubview(todayMovie)
        addSubview(movieList)
    }
    
    override func configureLayout() {
        infoBox.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
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
        searchList.snp.makeConstraints { make in
            make.top.equalTo(recentSearch.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(80)
        }
        todayMovie.snp.makeConstraints { make in
            make.top.equalTo(searchList.snp.bottom)
            make.leading.equalToSuperview().offset(15)
        }
        movieList.snp.makeConstraints { make in
            make.top.equalTo(todayMovie.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-8)
        }
    }
}
