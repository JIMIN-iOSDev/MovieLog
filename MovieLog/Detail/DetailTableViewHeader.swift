//
//  DetailTableViewHeader.swift
//  MovieLog
//
//  Created by Jimin on 8/2/25.
//

import UIKit
import SnapKit

class DetailTableViewHeader: UITableViewHeaderFooterView {
    
    private var backdrops: [Backdrops] = []
    
    private let backdrop = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout())
        cv.isPagingEnabled = true
        cv.backgroundColor = .clear
        return cv
    }()
    
    static func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 300)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
        
        backdrop.delegate = self
        backdrop.dataSource = self
        backdrop.register(BackdropCollectionViewCell.self, forCellWithReuseIdentifier: BackdropCollectionViewCell.identifier)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        contentView.addSubview(backdrop)
    }
    
    private func configureLayout() {
        backdrop.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(backdrops: [Backdrops]) {
        self.backdrops = Array(backdrops.prefix(5))
        backdrop.reloadData()
    }
}

extension DetailTableViewHeader: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return backdrops.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BackdropCollectionViewCell.identifier, for: indexPath) as! BackdropCollectionViewCell
        let url = URL(string: "https://image.tmdb.org/t/p/w780\(backdrops[indexPath.item].file_path)")!
        cell.configure(url: url)
        return cell
    }
}
