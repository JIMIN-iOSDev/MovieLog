//
//  CastTitleTableViewCell.swift
//  MovieLog
//
//  Created by Jimin on 8/3/25.
//

import UIKit

class CastTitleTableViewCell: UITableViewCell {
    
    static let identifier = "CastTitleTableViewCell"

    private let title = {
        let label = Label(size: 17, weight: .bold, alignment: .left)
        label.text = "Cast"
        return label
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
    
    private func configureHierarchy() {
        contentView.addSubview(title)
    }
    
    private func configureLayout() {
        title.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
        }
    }
    
    private func configureView() {
        backgroundColor = .clear
    }
}
