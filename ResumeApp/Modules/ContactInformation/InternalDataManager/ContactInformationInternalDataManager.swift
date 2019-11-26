//
//  ContactInformationInternalDataManager.swift
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/25/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import Foundation
import CoreData

class ContactInformationInternalDataManager: ContactInformationInternalDataManagerInputProtocol {
    
    weak var interactor: ContactInformationInternalDataManagerOutputProtocol?
    var context: NSManagedObjectContext?
    
    func getDataFromStorage() -> (owner: String?, means: [ContactInformation]?)? {
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
        
        guard let contactMeans = person?.contactMeans else {
            return nil
        }
        
        let means = Array(contactMeans) as? [ContactInformation]
        return (owner: person?.name, means: means)
    }
}
