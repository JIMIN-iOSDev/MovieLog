//
//  ReusableViewProtocol.swift
//  MovieLog
//
//  Created by 서지민 on 8/30/25.
//

import UIKit

protocol ReusableViewProtocol {
    static var identifier: String { get }
}

extension UITableViewCell: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewHeaderFooterView: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
