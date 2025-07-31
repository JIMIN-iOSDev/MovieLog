//
//  NicknameDetailViewController.swift
//  MovieLog
//
//  Created by Jimin on 7/31/25.
//

import UIKit

class NicknameDetailViewController: UIViewController {

    private let mainView = NicknameDetail()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "닉네임 설정"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }

}
