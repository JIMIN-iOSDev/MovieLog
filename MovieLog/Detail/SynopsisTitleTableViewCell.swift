//
//  SynopsisTitleTableViewCell.swift
//  MovieLog
//
//  Created by Jimin on 8/3/25.
//

import UIKit
import SnapKit

class SynopsisTitleTableViewCell: BaseTableViewCell {

    static let identifier = "SynopsisTitleTableViewCell"
    
    private let title = {
        let label = Label(size: 17, weight: .bold, alignment: .left)
        label.text = "Synopsis"
        return label
    }()
    
    private let moreButton = {
        let button = UIButton()
        button.setTitle("More", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.setTitleColor(UIColor(hex: "98FB98"), for: .normal)
        button.backgroundColor = .clear
        return button
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(title)
        contentView.addSubview(moreButton)
    }
    
    override func configureLayout() {
        title.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
        }
        moreButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    override func configureView() {
        super.configureView()
    }
}
