//
//  WorkInformationInternalDataManager.swift
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/25/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import Foundation
import CoreData

class WorkInformationInternalDataManager: WorkInformationInternalDataManagerInputProtocol {
    
    weak var interactor: WorkInformationInternalDataManagerOutputProtocol?
    var context: NSManagedObjectContext?
    
    func getDataFromStorage() -> [Job]? {
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
        
        guard let jobs = person?.jobs else {
            return nil
        }
        
        return Array(jobs) as? [Job]
    }
}
