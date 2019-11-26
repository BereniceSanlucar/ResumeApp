//
//  TabBarModuleWireFrame.swift
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/23/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import UIKit

class TabBarModuleWireFrame: TabBarModuleWireFrameProtocol {
    
    static func createTabBarModule(tabBarViewControllers: [UIViewController]) -> UIViewController {
        let storyboard = UIStoryboard(name: ResumeAppCommonConstants.StoryboardIdentifiers.tabBarModule, bundle: nil)
        let tabBarVC = storyboard.instantiateViewController(withIdentifier: ResumeAppCommonConstants.ViewControllerIdentifiers.tabController)
        if let view = tabBarVC as? TabBarModuleViewController {
            view.viewControllers = tabBarViewControllers
            return view
        }
        return UIViewController()
    }
    
}
