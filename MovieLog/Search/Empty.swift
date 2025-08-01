//
//  Empty.swift
//  MovieLog
//
//  Created by Jimin on 8/1/25.
//

import UIKit
import SnapKit

class Empty: BaseView {

    let searchBar = {
        let sb = UISearchBar()
        sb.searchBarStyle = .minimal
        sb.searchTextField.textColor = .white
        sb.searchTextField.leftView?.tintColor = .white
        sb.searchTextField.backgroundColor = UIColor(hex: "#292929")
        return sb
    }()
    
    override func configureHierarchy() {
        addSubview(searchBar)
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        }
    }
}
