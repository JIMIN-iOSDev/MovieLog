//
//  TodayMovieCollectionViewCell.swift
//  MovieLog
//
//  Created by Jimin on 8/4/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class TodayMovieCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TodayMovieCollectionViewCell"
    
    var disposeBag = DisposeBag()
    
    private let poster = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    private let title = {
        let label = Label(size: 20, weight: .bold, alignment: .left)
        label.text = "제목"
        return label
    }()
    
    private let explain = {
        let label = Label(size: 15, weight: .regular, alignment: .left)
        label.numberOfLines = 3
        return label
    }()
    
    let likeButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = UIColor(hex: "98FB98")
        button.backgroundColor = .clear
        return button
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        contentView.addSubview(poster)
        contentView.addSubview(title)
        contentView.addSubview(explain)
        contentView.addSubview(likeButton)
    }
    
    private func configureLayout() {
        poster.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(280)
        }
        title.snp.makeConstraints { make in
            make.top.equalTo(poster.snp.bottom).offset(4)
            make.leading.equalTo(poster.snp.leading)
            make.width.equalTo(190)
        }
        explain.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(poster.snp.horizontalEdges)
            make.bottom.equalToSuperview()
        }
        likeButton.snp.makeConstraints { make in
            make.centerY.equalTo(title.snp.centerY)
            make.trailing.equalTo(poster.snp.trailing)
        }
    }
    
    func configureData(row: MovieInfo) {
        let baseURL = "https://image.tmdb.org/t/p/w500"
        let url = URL(string: baseURL + row.poster_path)
        poster.kf.setImage(with: url)
        title.text = row.title
        if row.overview == "" {
            explain.text = "줄거리가 없습니다\n\n"
        } else {
            explain.text = row.overview
        }
        
        let isLike = RecentSearch.getLikeMovies().contains(row.id)
        let image = isLike ? "heart.fill" : "heart"
        likeButton.setImage(UIImage(systemName: image), for: .normal)
    }
}
