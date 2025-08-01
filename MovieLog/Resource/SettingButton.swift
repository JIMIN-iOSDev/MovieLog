//
//  SettingButton.swift
//  MovieLog
//
//  Created by Jimin on 8/2/25.
//

import UIKit

class SettingButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        contentHorizontalAlignment = .left
        titleLabel?.font = UIFont.systemFont(ofSize: 15)
        backgroundColor = .clear
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

