//
//  Detail.swift
//  MovieLog
//
//  Created by Jimin on 8/2/25.
//

import UIKit
import SnapKit

class Detail: BaseView {

    let tableView = {
        let tv = UITableView(frame: CGRect.zero, style: .grouped)
        tv.sectionHeaderHeight = 270
        tv.sectionFooterHeight = 0
        tv.backgroundColor = .clear
        return tv
    }()
    
    override func configureHierarchy() {
        addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
