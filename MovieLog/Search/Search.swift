//
//  Search.swift
//  MovieLog
//
//  Created by Jimin on 8/1/25.
//

import UIKit
import SnapKit

class Search: BaseView {
    
    let searchBar = {
        let sb = UISearchBar()
        sb.searchBarStyle = .minimal
        sb.searchTextField.textColor = .white
        sb.searchTextField.leftView?.tintColor = .white
        sb.searchTextField.backgroundColor = UIColor(hex: "#292929")
        return sb
    }()
    
    let tableView = {
        let tv = UITableView()
        tv.backgroundColor = .clear
        tv.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
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
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-4)
        }
    }
    
    override func configureView() {
        tableView.rowHeight = 130
    }
}
