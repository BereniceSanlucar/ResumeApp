//
//  ContactInformationProtocols.swift
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/23/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import UIKit
import CoreData

//PRESENTER -> VIEW
protocol ContactInformationViewProtocol: class {
    
    var presenter: ContactInformationPresenterProtocol? { get set }
    
    func checkEmailAvailability()
}

//VIEW -> PRESENTER
protocol ContactInformationPresenterProtocol: class {
    
    var view: ContactInformationViewProtocol? { get set }
    var interactor: ContactInformationInteractorInputProtocol? { get set }
    var wireFrame: ContactInformationWireFrameProtocol? { get set }
    
    func determineNumberOfItemsInSection() -> Int
    func determineCellForItemAt() -> String
    func determineValuesForItem(with indexPath: IndexPath) -> ContactInformationStructs.ContactMean
    func determineSizeForItemAt(with width: CGFloat) -> CGSize
    func manageDidSelectItemAt(for indexPath: IndexPath)
    func determineInsetForSectionAt() -> (top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat)
    func determineMinimumLineSpacingForSectionAt() -> CGFloat
    func determineMinimumInteritemSpacingForSectionAt() -> CGFloat
    func resultForEmailAvalability(isAvailable: Bool, from controller: ContactInformationViewController)
    func resultFromSendingMail(anErrorOccured: Bool, didFail: Bool)
}

//PRESENTER -> INTERACTOR
protocol ContactInformationInteractorInputProtocol: class {
    
    var presenter: ContactInformationInteractorOutputProtocol? { get set }
    var internalDataManager: ContactInformationInternalDataManagerInputProtocol { get set }
    
    func dictateNumberOfItemsInSection() -> Int
    func dictateValuesForItem(with indexPath: IndexPath) -> ContactInformationStructs.ContactMean
    func defineActionForItemAt(with indexPath: IndexPath)
    func resultAfterCheckEmailAvailability(isAvailable: Bool)
    func resultAfterSendingMail(anErrorOccured: Bool, didFail: Bool)
}

//INTERACTOR -> PRESENTER
protocol ContactInformationInteractorOutputProtocol: class {
    
    func askForCheckEmailAvailability()
    func askToShowMail(for mail: ContactInformationStructs.Mail)
    func askToShowAlert(with content: ResumeAppCommonStructs.AlertMessage)
    func askToDismissView()
    func askToOpenDestination(with URL: URL)
}

//INTERACTOR -> INTERNAL DATA MANAGER
protocol ContactInformationInternalDataManagerInputProtocol: class {
    
    var interactor: ContactInformationInternalDataManagerOutputProtocol? { get set }
    var context: NSManagedObjectContext? { get set }
    
    func getDataFromStorage() -> (owner: String?, means: [ContactInformation]?)?
}

//INTERNAL DATA MANAGER -> INTERACTOR
protocol ContactInformationInternalDataManagerOutputProtocol: class {
    
}

//PRESENTER -> WIREFRAME
protocol ContactInformationWireFrameProtocol: class {
    static func createContactInformationModule(context: NSManagedObjectContext) -> UIViewController
    func openDestination(with url: URL)
    func showMailComposerVC(from controller: ContactInformationViewController, for mail: ContactInformationStructs.Mail)
    func showAlertMessage(with content: ResumeAppCommonStructs.AlertMessage, from controller: ContactInformationViewController)
    func dismissController(controller: ContactInformationViewController)
}
