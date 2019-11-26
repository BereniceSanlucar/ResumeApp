//
//  WorkInformationProtocols.swift
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/23/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import UIKit
import CoreData

//PRESENTER -> VIEW
protocol WorkInformationViewProtocol: class {
    var presenter: WorkInformationPresenterProtocol? { get set }
}

//VIEW -> PRESENTER
protocol WorkInformationPresenterProtocol: class {
    
    var view: WorkInformationViewProtocol? { get set }
    var interactor: WorkInformationInteractorInputProtocol? { get set }
    var wireFrame: WorkInformationWireFrameProtocol? { get set }
    
    func determineNumberOfSections() -> Int
    func determineNumberOfRowsInSection(with section: Int) -> Int
    func determineCellForRowAt() -> String
    func determineValueForRow(with indexPath: IndexPath) -> WorkInformationStructs.Job
    func determineTitleForHeaderInSection(with section: Int) -> String?
    func determineHeightForRowAt(for indexPath: IndexPath) -> CGFloat
}

//PRESENTER -> INTERACTOR
protocol WorkInformationInteractorInputProtocol: class {
    
    var presenter: WorkInformationInteractorOutputProtocol? { get set }
    var internalDataManager: WorkInformationInternalDataManagerInputProtocol { get set }
    
    func dictateNumberOfSections() -> Int
    func dictateNumberOfRowsInSection(with section: Int) -> Int
    func dictateTitleForHeaderInSection(with section: Int) -> String?
    func dictateValueForRow(with indexPath: IndexPath) -> WorkInformationStructs.Job
}

//INTERACTOR -> PRESENTER
protocol WorkInformationInteractorOutputProtocol: class {
    
}

//INTERACTOR -> INTERNAL DATA MANAGER
protocol WorkInformationInternalDataManagerInputProtocol: class {
    
    var interactor: WorkInformationInternalDataManagerOutputProtocol? { get set }
    var context: NSManagedObjectContext? { get set }
    
    func getDataFromStorage() -> [Job]?
}

//INTERNAL DATA MANAGER -> INTERACTOR
protocol WorkInformationInternalDataManagerOutputProtocol: class {
    
}

//PRESENTER -> WIREFRAME
protocol WorkInformationWireFrameProtocol: class {
    static func createWorkInformationModule(context: NSManagedObjectContext) -> UIViewController
}
