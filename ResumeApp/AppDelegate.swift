//
//  AppDelegate.swift
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/23/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let internalDataManager = ResumeAppInternalDataManager(modelName: ResumeAppCommonConstants.InternalManagerIdentifiers.resumeModel)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        DispatchQueue.global(qos: .userInteractive).async {
            self.internalDataManager.load()
            ResumeAppExternalDataManager.shared.context = self.internalDataManager.viewContext
            ResumeAppExternalDataManager.shared.getDataFromExternalSource { name in
                self.createHomeVC(personName: name, context: self.internalDataManager.viewContext)
            }
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        internalDataManager.deleteDataFromStorage()
    }
}

extension AppDelegate {
    
    private func createHomeVC(personName: String, context: NSManagedObjectContext) {
        let viewControllers = [BasicInformationWireFrame.createBasicInformationModule(moduleTitle: personName, context: context),
                               WorkInformationWireFrame.createWorkInformationModule(context: context),
                               ContactInformationWireFrame.createContactInformationModule(context: context)]
        let homeVC = TabBarModuleWireFrame.createTabBarModule(tabBarViewControllers: viewControllers)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = homeVC
        window?.makeKeyAndVisible()
    }
    
}
