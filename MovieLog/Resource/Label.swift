//
//  Label.swift
//  MovieLog
//
//  Created by 서지민 on 7/31/25.
//

import UIKit

class Label: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(size: CGFloat, weight: UIFont.Weight, alignment: NSTextAlignment) {
        super.init(frame: .zero)
        textColor = .white
        font = .systemFont(ofSize: size, weight: weight)
        textAlignment = alignment
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
