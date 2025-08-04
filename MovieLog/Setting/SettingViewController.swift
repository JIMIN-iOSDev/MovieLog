//
//  SettingViewController.swift
//  MovieLog
//
//  Created by Jimin on 8/1/25.
//

import UIKit

class SettingViewController: UIViewController {

    private let mainView = Setting()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "설정"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        mainView.delete.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    @objc func deleteButtonTapped() {
        let alert = UIAlertController(title: "탈퇴하기", message: "탈퇴하시면 데이터가 모두 초기화됩니다.\n탈퇴하시겠습니까?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            UserDefaults.standard.removeObject(forKey: "NickName")
            RecentSearch.clearRecentSearch()
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first(where: { $0.isKeyWindow }) {
                let nav = UINavigationController(rootViewController: OnboardingViewController())
                window.rootViewController = nav
                window.makeKeyAndVisible()
            }
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
