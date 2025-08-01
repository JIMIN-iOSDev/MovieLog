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
    }
}
