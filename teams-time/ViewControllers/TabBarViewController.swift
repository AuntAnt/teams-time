//
//  TabBarViewController.swift
//  teams-time
//
//  Created by Илья Стратович on 12.03.23.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let appearance = UITabBarAppearance()
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        tabBar.layer.borderWidth = 0.5
    }
    
}
