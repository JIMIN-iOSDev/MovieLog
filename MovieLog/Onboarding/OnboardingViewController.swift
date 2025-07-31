//
//  OnboardingViewController.swift
//  MovieLog
//
//  Created by 서지민 on 7/31/25.
//

import UIKit

class OnboardingViewController: UIViewController {

    let mainView = Onboarding()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    @objc func startButtonTapped() {
        let vc = NicknameViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
