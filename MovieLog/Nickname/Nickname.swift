//
//  Nickname.swift
//  MovieLog
//
//  Created by 서지민 on 7/31/25.
//

import UIKit
import SnapKit

class Nickname: BaseView {

    let textField = {
        let tf = UITextField()
        tf.textColor = .white
        tf.isUserInteractionEnabled = false
        return tf
    }()
    
    private let line = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let editButton = {
        let button = UIButton()
        button.setTitle("편집", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        return button
    }()
    
    let endButton = {
        let button = Button()
        button.setTitle("완료", for: .normal)
        return button
    }()
    
    override func configureHierarchy() {
        addSubview(textField)
        addSubview(line)
        addSubview(editButton)
        addSubview(endButton)
    }
    
    override func configureLayout() {
        textField.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(44)
        }
        
        editButton.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.top)
            make.trailing.equalToSuperview().offset(-10)
            make.width.equalTo(90)
            make.height.equalTo(50)
        }
        
        line.snp.makeConstraints { make in
            make.top.equalTo(editButton.snp.bottom)
            make.leading.equalToSuperview().offset(13)
            make.trailing.equalTo(editButton.snp.trailing).offset(-60)
            make.height.equalTo(1)
        }
        
        endButton.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(25)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
            
            make.height.equalTo(44)
        }
    }
}
