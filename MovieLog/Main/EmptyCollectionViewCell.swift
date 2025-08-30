//
//  EmptyCollectionViewCell.swift
//  MovieLog
//
//  Created by Jimin on 8/5/25.
//

import UIKit
import SnapKit

class EmptyCollectionViewCell: UICollectionViewCell {
    
    private let label = {
        let label = Label(size: 15, weight: .regular, alignment: .center)
        label.text = "최근 검색어 내역이 없습니다"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
