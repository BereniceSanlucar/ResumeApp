//
//  BasicInformationProtocols.swift
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/23/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import UIKit
import CoreData

//PRESENTER -> VIEW
protocol BasicInformationViewProtocol: class {
    var presenter: BasicInformationPresenterProtocol? { get set }
}

//VIEW -> PRESENTER
protocol BasicInformationPresenterProtocol: class {
    
    var view: BasicInformationViewProtocol? { get set }
    var interactor: BasicInformationInteractorInputProtocol? { get set }
    var wireFrame: BasicInformationWireFrameProtocol? { get set }
    
    func getTitleForNavigationBar() -> String?
    func determineNumberOfSections() -> Int
    func determineNumberOfItemsInSection(with section: Int) -> Int
    func determineCellForItemAt(with indexPath: IndexPath) -> String
    func determineValuesForProfessionalInfo() -> BasicInformationStructs.Summary
    func determineValueForItem(with indexPath: IndexPath) -> String
    func determineHeaderInSection() -> String
    func determineTitleForHeaderInSection(with indexPath: IndexPath) -> String?
    func determineSizeForItemAt(for indexPath: IndexPath, with sizes: (width: CGFloat, height: CGFloat)) -> CGSize
    func determineSizeForHeaderInSection(with width: CGFloat) -> CGSize
    func determineInsetForSectionAt(with section: Int) -> (top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat)
    func determineMinimumLineSpacingForSectionAt(with section: Int) -> CGFloat
    func determineMinimumInteritemSpacingForSectionAt(with section: Int) -> CGFloat
}

//PRESENTER -> INTERACTOR
protocol BasicInformationInteractorInputProtocol: class {
    
    var presenter: BasicInformationInteractorOutputProtocol? { get set }
    var internalDataManager: BasicInformationInternalDataManagerInputProtocol { get set }
    
    func getTitleForNavigationBar() -> String?
    func dictateNumberOfSections() -> Int
    func dictateNumberOfItemsInSection(with section: Int) -> Int
    func dictateValuesForProfessionalInfo() -> BasicInformationStructs.Summary
    func dictateValueForItem(with indexPath: IndexPath) -> String
}

//INTERACTOR -> PRESENTER
protocol BasicInformationInteractorOutputProtocol: class {
    
}

//INTERACTOR -> INTERNAL DATA MANAGER
protocol BasicInformationInternalDataManagerInputProtocol: class {
    
    var interactor: BasicInformationInternalDataManagerOutputProtocol? { get set }
    var context: NSManagedObjectContext? { get set }
    
    func getDataFromStorage() -> Person?
}

//INTERNAL DATA MANAGER -> INTERACTOR
protocol BasicInformationInternalDataManagerOutputProtocol: class {
    
}

//PRESENTER -> WIREFRAME
protocol BasicInformationWireFrameProtocol: class {
    static func createBasicInformationModule(context: NSManagedObjectContext) -> UIViewController
}
