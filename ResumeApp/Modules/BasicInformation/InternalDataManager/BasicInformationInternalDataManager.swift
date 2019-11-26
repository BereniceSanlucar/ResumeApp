//
//  BasicInformationInternalDataManager.swift
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/25/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import Foundation
import CoreData

class BasicInformationInternalDataManager: BasicInformationInternalDataManagerInputProtocol {
    
    weak var interactor: BasicInformationInternalDataManagerOutputProtocol?
    var context: NSManagedObjectContext?
    
    func getDataFromStorage() -> Person? {
        guard let context = context else {
            return nil
        }
        
        var person: Person? = nil
        
        context.performAndWait {
            let fetchRequest = NSFetchRequest<Person>(entityName: ResumeAppCommonConstants.InternalManagerIdentifiers.personEntity)
            fetchRequest.fetchLimit = 1
            if let results = try? context.fetch(fetchRequest) {
                person = results.first
            }
        }
        return person
    }
}

