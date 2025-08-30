//
//  RecentSearchCollectionViewCell.swift
//  MovieLog
//
//  Created by Jimin on 8/4/25.
//

import UIKit
import SnapKit

class RecentSearchCollectionViewCell: UICollectionViewCell {
    
    var deleteAction: (() -> Void)?
    
    private let background = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 18
        view.clipsToBounds = true
        return view
    }()
    
    let title = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    private let delete = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        
        delete.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
    }
    
    @objc private func deleteTapped() {
        deleteAction?()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        addSubview(background)
        addSubview(title)
        addSubview(delete)
    }
    
    private func configureLayout() {
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        title.snp.makeConstraints { make in
            make.centerY.equalTo(background.snp.centerY)
            make.leading.equalToSuperview().offset(16)
        }
        delete.snp.makeConstraints { make in
            make.centerY.equalTo(background.snp.centerY)
            make.trailing.equalToSuperview().offset(-8)
        }
    }
}
