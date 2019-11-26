//
//  ContactInformationWireFrame.swift
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/23/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import UIKit
import MessageUI
import CoreData

class ContactInformationWireFrame: ContactInformationWireFrameProtocol {
    
    static func createContactInformationModule(context: NSManagedObjectContext) -> UIViewController {
        let storyboard = UIStoryboard(name: ResumeAppCommonConstants.StoryboardIdentifiers.contactInfoModule, bundle: nil)
        let contactInfoVC = storyboard.instantiateViewController(withIdentifier: ResumeAppCommonConstants.ViewControllerIdentifiers.contactInfoController)
        if let view = contactInfoVC as? ContactInformationViewController {
            let tabBarItem = UITabBarItem()
            tabBarItem.image = UIImage(named: ResumeAppCommonConstants.TabBarItems.contactInfoItem)
            view.tabBarItem = tabBarItem
            setVIPERProperties(for: view, context: context)
            let navController = UINavigationController(rootViewController: view)
            navController.setNavigationBarHidden(false, animated: false)
            navController.navigationBar.topItem?.title = ResumeAppCommonConstants.ModuleTitles.contactInfoTitle.uppercased()
            return navController
        }
        return UIViewController()
    }
    
    private static func setVIPERProperties(for controller: ContactInformationViewController, context: NSManagedObjectContext) {
        let internalDataManager = ContactInformationInternalDataManager()
        internalDataManager.context = context
        let interactor = ContactInformationInteractor(internalDataManager: internalDataManager)
        internalDataManager.interactor = interactor
        let presenter = ContactInformationPresenter()
        presenter.view = controller
        presenter.interactor = interactor
        presenter.wireFrame = ContactInformationWireFrame()
        interactor.presenter = presenter
        controller.presenter = presenter
    }
    
    func showMailComposerVC(from controller: ContactInformationViewController, for mail: ContactInformationStructs.Mail) {
        
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = controller
        mailComposer.setToRecipients(mail.recipients)
        mailComposer.setSubject(mail.subject)
        mailComposer.setMessageBody(mail.message, isHTML: false)
        
        controller.present(mailComposer, animated: true, completion: nil)
    }
    
    func showAlertMessage(with content: ResumeAppCommonStructs.AlertMessage, from controller: ContactInformationViewController) {
        let alert = UIAlertController(title: content.title, message: content.message, preferredStyle: .alert)
        let action = UIAlertAction(title: content.button, style: .default) { _ in
            alert.dismiss(animated: false, completion: nil)
        }
        
        alert.addAction(action)
        controller.present(alert, animated: true)
    }
    
    func dismissController(controller: ContactInformationViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func openDestination(with url: URL) {
        let application: UIApplication = UIApplication.shared
        application.open(url, options: [:], completionHandler: nil)
    }
}
