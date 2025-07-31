//
//  Button.swift
//  MovieLog
//
//  Created by 서지민 on 7/31/25.
//

import UIKit

class Button: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleColor(UIColor(hex: "98FB98"), for: .normal)
        backgroundColor = .clear
        layer.borderColor = UIColor(hex: "98FB98").cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 20
        clipsToBounds = true
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
