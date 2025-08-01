//
//  SearchTableViewCell.swift
//  MovieLog
//
//  Created by Jimin on 8/1/25.
//

import UIKit
import SnapKit
import Kingfisher

class SearchTableViewCell: UITableViewCell {

    static let identifier = "SearchTableViewCell"
    
    private let poster = {
        let image = UIImageView()
        image.backgroundColor = .orange
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
    
    private let title = {
        let label = Label(size: 17, weight: .bold, alignment: .left)
        label.text = "제목"
        label.numberOfLines = 2
        return label
    }()
    
    private let date = {
        let label = Label(size: 15, weight: .regular, alignment: .left)
        label.text = "8888.88.88"
        return label
    }()
    
    private let likeButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = UIColor(hex: "98FB98")
        button.backgroundColor = .clear
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        contentView.addSubview(poster)
        contentView.addSubview(title)
        contentView.addSubview(date)
        contentView.addSubview(likeButton)
    }
    
    func configureLayout() {
        poster.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview().inset(15)
            make.width.equalTo(70)
        }
        title.snp.makeConstraints { make in
            make.top.equalTo(poster.snp.top).offset(4)
            make.leading.equalTo(poster.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-15)
        }
        date.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(4)
            make.leading.equalTo(title.snp.leading)
        }
        likeButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().offset(-15)
        }
    }
    
    func configureView() {
        backgroundColor = .clear
    }
    
    func configureData(row: Result) {
        let url = URL(string: row.poster_path)
        poster.kf.setImage(with: url)
        title.text = row.title
        date.text = row.release_date
    }
}


