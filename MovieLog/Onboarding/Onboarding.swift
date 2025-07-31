//
//  Onboarding.swift
//  MovieLog
//
//  Created by 서지민 on 7/31/25.
//

import UIKit
import SnapKit

class Onboarding: BaseView {
    
    private let image = {
        let image = UIImageView()
        image.image = .splash
        image.backgroundColor = .clear
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let title = {
        let label = Label(size: 40, weight: .bold, alignment: .center)
        label.text = "Onboarding"
        return label
    }()
    
    private let explain = {
        let label = Label(size: 20, weight: .regular, alignment: .center)
        label.text = "당신만의 영화 세상,\nMovieLog를 시작해보세요"
        label.textColor = .gray
        label.numberOfLines = 2
        return label
    }()
    
    let startButton = {
        let button = Button()
        button.setTitle("시작하기", for: .normal)
        return button
    }()
    
    override func configureHierarchy() {
        addSubview(image)
        addSubview(title)
        addSubview(explain)
        addSubview(startButton)
    }
    
    override func configureLayout() {
        image.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.centerX.equalToSuperview()
            make.size.equalTo(200)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(120)
            make.centerX.equalToSuperview()
        }
        
        explain.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        
        startButton.snp.makeConstraints { make in
            make.top.equalTo(explain.snp.bottom).offset(45)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
        }
    }
}
