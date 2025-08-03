//
//  DetailTableViewHeader.swift
//  MovieLog
//
//  Created by Jimin on 8/2/25.
//

import UIKit
import SnapKit

class DetailTableViewHeader: UITableViewHeaderFooterView {

    static let identifier = "DetailTableViewHeader"
    
    private let backdrop = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout())
        cv.backgroundColor = .red
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
}
