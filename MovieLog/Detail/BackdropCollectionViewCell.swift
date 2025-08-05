//
//  BackdropCollectionViewCell.swift
//  MovieLog
//
//  Created by Jimin on 8/5/25.
//

import UIKit
import SnapKit
import Kingfisher

class BackdropCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BackdropCollectionViewCell"
    
    private let image = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
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
        contentView.addSubview(image)
    }
    
    private func configureLayout() {
        image.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(url: URL) {
        image.kf.setImage(with: url)
    }
}
