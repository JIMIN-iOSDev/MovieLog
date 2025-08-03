//
//  SynopsisTableViewCell.swift
//  MovieLog
//
//  Created by Jimin on 8/3/25.
//

import UIKit
import SnapKit

class SynopsisTableViewCell: BaseTableViewCell {

    static let identifier = "SynopsisTableViewCell"
    
    let synopsis = {
        let label = Label(size: 15, weight: .regular, alignment: .left)
        label.numberOfLines = 3
        return label
    }()
    
    override func configureHierarchy() {
        contentView.addSubview(synopsis)
    }
    
    override func configureLayout() {
        synopsis.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.bottom.equalToSuperview().inset(10)
        }
    }
    
    override func configureView() {
        super.configureView()
    }
}
