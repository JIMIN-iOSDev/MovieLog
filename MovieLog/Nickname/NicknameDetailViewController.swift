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
        mainView.textField.becomeFirstResponder()
    }
    
//    func condition() {
//        if let text = mainView.textField.text {
//            if text.count >= 2 && text.count < 10 {
//                mainView.status.text = "2글자 이상 10글자 미만으로 설정해주세요"
//            } else if {
//                mainView.status.text = "닉네임에 @, #, $, % 는 포함할 수 없어요"
//            } else if  {
//                mainView.status.text = "닉네임에 숫자는 포함할 수 없어요"
//            } else {
//                mainView.status.text = "사용할 수 있는 닉네임이에요"
//            }
//        }
//    }
//    let regex = "^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,50}$"
//    let test = mainView.textField.text!.range(of: regex)
}
