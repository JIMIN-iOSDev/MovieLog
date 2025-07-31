//
//  NicknameViewController.swift
//  MovieLog
//
//  Created by 서지민 on 7/31/25.
//

import UIKit

class NicknameViewController: UIViewController {

    private let mainView = Nickname()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "닉네임 설정"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        mainView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }
    
    @objc func editButtonTapped() {
        let vc = NicknameDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .green
    }
}
