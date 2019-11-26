//
//  BasicInformationWireFrame.swift
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/23/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import UIKit
import CoreData

class BasicInformationWireFrame: BasicInformationWireFrameProtocol {
    
    static func createBasicInformationModule(context: NSManagedObjectContext) -> UIViewController {
        let storyboard = UIStoryboard(name: ResumeAppCommonConstants.StoryboardIdentifiers.basicInfoModule, bundle: nil)
        let basicInfoVC = storyboard.instantiateViewController(withIdentifier: ResumeAppCommonConstants.ViewControllerIdentifiers.basicInfoController)
        if let view = basicInfoVC as? BasicInformationViewController {
            let tabBarItem = UITabBarItem()
            tabBarItem.image = UIImage(named: ResumeAppCommonConstants.TabBarItems.basicInfoItem)
            view.tabBarItem = tabBarItem
            setVIPERProperties(for: view, context: context)
            let navController = UINavigationController(rootViewController: view)
            navController.setNavigationBarHidden(false, animated: false)
            return navController
        }
        return UIViewController()
    }
    
    
    private static func setVIPERProperties(for controller: BasicInformationViewController, context: NSManagedObjectContext) {
        let internalDataManager = BasicInformationInternalDataManager()
        internalDataManager.context = context
        let interactor = BasicInformationInteractor(internalDataManager: internalDataManager)
        internalDataManager.interactor = interactor
        let presenter = BasicInformationPresenter()
        presenter.view = controller
        presenter.interactor = interactor
        presenter.wireFrame = BasicInformationWireFrame()
        interactor.presenter = presenter
        controller.presenter = presenter
    }
    
}
