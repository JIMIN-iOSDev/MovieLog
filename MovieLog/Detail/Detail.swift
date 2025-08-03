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
        let tv = UITableView()
        tv.backgroundColor = .yellow
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
