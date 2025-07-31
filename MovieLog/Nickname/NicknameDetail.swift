//
//  NicknameDetail.swift
//  MovieLog
//
//  Created by Jimin on 7/31/25.
//

import UIKit
import SnapKit

class NicknameDetail: BaseView {

    let textField = {
        let tf = UITextField()
        tf.placeholder = "닉네임을 입력하세요"
        tf.textColor = .white
        return tf
    }()
    
    private let line = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let status = {
        let label = UILabel()
        label.textColor = UIColor(hex: "98FB98")
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    override func configureHierarchy() {
        addSubview(textField)
        addSubview(line)
    }
    
    override func configureLayout() {
        textField.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.height.equalTo(44)
        }
        
        line.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom)
            make.horizontalEdges.equalTo(textField.snp.horizontalEdges)
            make.height.equalTo(1)
        }
    }
}
