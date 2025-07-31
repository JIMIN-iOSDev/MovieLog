//
//  TabBarViewController.swift
//  MovieLog
//
//  Created by Jimin on 8/1/25.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
    }

    private func setTabBar() {
        self.tabBar.tintColor = UIColor(hex: "98FB98")
        self.tabBar.unselectedItemTintColor = UIColor(hex: "E1E1E1")
        
        let firstVC = UINavigationController(rootViewController: MainViewController())
        firstVC.tabBarItem.image = UIImage(systemName: "popcorn")
        firstVC.tabBarItem.title = "CINEMA"
        
        let secondVC = UpcomingViewController()
        secondVC.tabBarItem.image = UIImage(systemName: "film.stack")
        secondVC.tabBarItem.title = "UPCOMING"
        
        let thirdVC = SettingViewController()
        thirdVC.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        thirdVC.tabBarItem.title = "PROFILE"
        
        viewControllers = [firstVC, secondVC, thirdVC]
    }
}
