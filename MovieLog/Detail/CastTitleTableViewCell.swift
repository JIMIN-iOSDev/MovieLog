//
//  CastTitleTableViewCell.swift
//  MovieLog
//
//  Created by Jimin on 8/3/25.
//

import UIKit
import SnapKit

class CastTitleTableViewCell: BaseTableViewCell {
    
    static let identifier = "CastTitleTableViewCell"

    private let title = {
        let label = Label(size: 17, weight: .bold, alignment: .left)
        label.text = "Cast"
        return label
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(title)
    }
    
    override func configureLayout() {
        title.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
        }
    }
    
    override func configureView() {
        super.configureView()
    }
}
