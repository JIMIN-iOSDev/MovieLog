//
//  Search.swift
//  MovieLog
//
//  Created by Jimin on 8/1/25.
//

import UIKit
import SnapKit

class Search: BaseView {

    private let searchBar = {
        let sb = UISearchBar()
        sb.searchBarStyle = .minimal
        sb.searchTextField.leftView?.tintColor = .white
        sb.searchTextField.backgroundColor = UIColor(hex: "#292929")
        return sb
    }()
    
    private let tableView = {
        let tv = UITableView()
        tv.backgroundColor = .yellow
        return tv
    }()
    
    override func configureHierarchy() {
        addSubview(searchBar)
        addSubview(tableView)
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }

}
