//
//  WorkInformationWireFrame.swift
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/23/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import UIKit
import CoreData

class WorkInformationWireFrame: WorkInformationWireFrameProtocol {
    
    static func createWorkInformationModule(context: NSManagedObjectContext) -> UIViewController {
        let storyboard = UIStoryboard(name: ResumeAppCommonConstants.StoryboardIdentifiers.workInfoModule, bundle: nil)
        let workInfoVC = storyboard.instantiateViewController(withIdentifier: ResumeAppCommonConstants.ViewControllerIdentifiers.workInfoController)
        if let view = workInfoVC as? WorkInformationViewController {
            let tabBarItem = UITabBarItem()
            tabBarItem.image = UIImage(named: ResumeAppCommonConstants.TabBarItems.workInfoItem)
            view.tabBarItem = tabBarItem
            setVIPERProperties(for: view, context: context)
            let navController = UINavigationController(rootViewController: view)
            navController.setNavigationBarHidden(false, animated: false)
            navController.navigationBar.topItem?.title = ResumeAppCommonConstants.ModuleTitles.workInfoTitle.uppercased()
            return navController
        }
        return UIViewController()
    }
    
    private static func setVIPERProperties(for controller: WorkInformationViewController, context: NSManagedObjectContext) {
        let internalDataManager = WorkInformationInternalDataManager()
        internalDataManager.context = context
        let interactor = WorkInformationInteractor(internalDataManager: internalDataManager)
        internalDataManager.interactor = interactor
        let presenter = WorkInformationPresenter()
        presenter.view = controller
        presenter.interactor = interactor
        presenter.wireFrame = WorkInformationWireFrame()
        interactor.presenter = presenter
        controller.presenter = presenter
    }
}
