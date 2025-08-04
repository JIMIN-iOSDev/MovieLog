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
        
        mainView.textField.text = UserDefaults.standard.string(forKey: "NickName")
        mainView.textField.becomeFirstResponder()
        mainView.textField.delegate = self
        mainView.textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange() {
        validateNickname()
    }
    
    private func validateNickname() {
        
        guard let text = mainView.textField.text else { return }
        
        if text.count < 2 || text.count >= 10 {
            mainView.status.text = "2글자 이상 10글자 미만으로 설정해주세요"
            return
        }
        
        let specialCharacters = CharacterSet(charactersIn: "@#$%")
        if text.rangeOfCharacter(from: specialCharacters) != nil {
            mainView.status.text = "닉네임에 @, #, $, % 는 포함할 수 없어요"
            return
        }
        
        let number = CharacterSet.decimalDigits
        if text.rangeOfCharacter(from: number) != nil {
            mainView.status.text = "닉네임에 숫자는 포함할 수 없어요"
            return
        }
        
        mainView.status.text = "사용할 수 있는 닉네임이에요"
    }
}

extension NicknameDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        UserDefaults.standard.set(textField.text, forKey: "NickName")
        return true
    }
}
