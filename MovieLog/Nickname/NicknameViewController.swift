//
//  NicknameViewController.swift
//  MovieLog
//
//  Created by 서지민 on 7/31/25.
//

import UIKit
import Toast

class NicknameViewController: UIViewController {

    private let mainView = Nickname()
    private let dateFormatter = DateFormatter()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "닉네임 설정"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        UserDefaults.standard.removeObject(forKey: "NickName")
        mainView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        mainView.endButton.addTarget(self, action: #selector(endButtonTapped), for: .touchUpInside)
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
    
    @objc func endButtonTapped() {
        let nickName = mainView.textField.text
        if let message = validateNickname(text: nickName) {
            view.makeToast(message, duration: 2, position: .bottom)
        } else {
            UserDefaults.standard.set(nickName, forKey: "NickName")
            
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = scene.delegate as? SceneDelegate, let window = delegate.window {
                window.rootViewController = TabBarViewController()
                window.makeKeyAndVisible()
            }
        }
    
        dateFormatter.dateFormat = "yy-MM-dd"
        let dateString = dateFormatter.string(from: Date())
        UserDefaults.standard.set(dateString, forKey: "Date")
    }
    
    private func validateNickname(text: String?) -> String? {
        
        guard let text = text else { return "닉네임을 입력하세요" }
        
        if text.count < 2 || text.count >= 10 {
            return "2글자 이상 10글자 미만으로 설정해주세요"
        }
        
        let specialCharacters = CharacterSet(charactersIn: "@#$%")
        if text.rangeOfCharacter(from: specialCharacters) != nil {
            return "닉네임에 @, #, $, % 는 포함할 수 없어요"
        }
        
        let number = CharacterSet.decimalDigits
        if text.rangeOfCharacter(from: number) != nil {
            return "닉네임에 숫자는 포함할 수 없어요"
        }
        
        return nil
    }
}
