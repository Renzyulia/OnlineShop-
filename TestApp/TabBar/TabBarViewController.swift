//
//  TabBarViewController.swift
//  TestApp
//
//  Created by Yulia Ignateva on 17.03.2023.
//

import UIKit

final class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = UIColor(named: "BackgroundColor")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.frame.size.height = 100
        tabBar.frame.origin.y = view.frame.height - 100
        tabBar.clipsToBounds = true
        tabBar.layer.cornerRadius = 35
    }
}
