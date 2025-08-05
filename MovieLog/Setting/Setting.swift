//
//  Setting.swift
//  MovieLog
//
//  Created by Jimin on 8/2/25.
//

import UIKit

class Setting: BaseView {
    
    private let infoBox = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#292929")
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private let nickName = {
        let label = Label(size: 18, weight: .bold, alignment: .left)
        label.text = UserDefaults.standard.string(forKey: "NickName")
        return label
    }()
    
    private let date = {
        let label = Label(size: 13, weight: .regular, alignment: .right)
        label.text = "\(UserDefaults.standard.string(forKey: "Date") ?? "") 가입 >"
        return label
    }()
    
    let likeCount = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hex: "#4A6246")
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.isEnabled = false
        return button
    }()
    
    private let question = {
        let button = SettingButton(title: "자주 묻는 질문")
        return button
    }()
    
    private let line1 = {
        let line = UIView()
        line.backgroundColor = .gray
        return line
    }()
    
    private let inquiry = {
        let button = SettingButton(title: "1:1 문의")
        return button
    }()
    
    private let line2 = {
        let line = UIView()
        line.backgroundColor = .gray
        return line
    }()
    
    private let alarm = {
        let button = SettingButton(title: "알림 설정")
        return button
    }()
    
    private let line3 = {
        let line = UIView()
        line.backgroundColor = .gray
        return line
    }()
    
    let delete = {
        let button = SettingButton(title: "탈퇴하기")
        return button
    }()
    
    private let line4 = {
        let line = UIView()
        line.backgroundColor = .gray
        return line
    }()
    
    override func configureHierarchy() {
        addSubview(infoBox)
        addSubview(nickName)
        addSubview(date)
        addSubview(likeCount)
        addSubview(question)
        addSubview(inquiry)
        addSubview(alarm)
        addSubview(delete)
        addSubview(line1)
        addSubview(line2)
        addSubview(line3)
        addSubview(line4)
    }
    
    override func configureLayout() {
        infoBox.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(120)
        }
        nickName.snp.makeConstraints { make in
            make.top.equalTo(infoBox.snp.top).offset(20)
            make.leading.equalTo(infoBox.snp.leading).offset(20)
        }
        date.snp.makeConstraints { make in
            make.centerY.equalTo(nickName.snp.centerY)
            make.trailing.equalTo(infoBox.snp.trailing).offset(-20)
        }
        likeCount.snp.makeConstraints { make in
            make.top.equalTo(nickName.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(infoBox.snp.horizontalEdges).inset(20)
            make.height.equalTo(44)
        }
        question.snp.makeConstraints { make in
            make.top.equalTo(infoBox.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(infoBox.snp.horizontalEdges)
        }
        line1.snp.makeConstraints { make in
            make.top.equalTo(question.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(question.snp.horizontalEdges)
            make.height.equalTo(1)
        }
        inquiry.snp.makeConstraints { make in
            make.top.equalTo(line1.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(question.snp.horizontalEdges)
        }
        line2.snp.makeConstraints { make in
            make.top.equalTo(inquiry.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(question.snp.horizontalEdges)
            make.height.equalTo(1)
        }
        alarm.snp.makeConstraints { make in
            make.top.equalTo(line2.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(question.snp.horizontalEdges)
        }
        line3.snp.makeConstraints { make in
            make.top.equalTo(alarm.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(question.snp.horizontalEdges)
            make.height.equalTo(1)
        }
        delete.snp.makeConstraints { make in
            make.top.equalTo(line3.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(question.snp.horizontalEdges)
        }
        line4.snp.makeConstraints { make in
            make.top.equalTo(delete.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(question.snp.horizontalEdges)
            make.height.equalTo(1)
        }
    }
}
