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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.textField.text = UserDefaults.standard.string(forKey: "NickName")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {    // 안쓰면 화면이 사라지는 모든 순간에 데이터 지워짐. pop인 순간에만 지우게 함
            UserDefaults.standard.removeObject(forKey: "NickName")
        }
    }
    
    @objc func editButtonTapped() {
        let vc = NicknameDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = UIColor(hex: "98FB98")
    }
}
