//
//  TabBarModuleViewController.swift
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/23/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import UIKit

class TabBarModuleViewController: UITabBarController {
    
    var presenter: TabBarModulePresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension TabBarModuleViewController: TabBarModuleViewProtocol {
    
}
