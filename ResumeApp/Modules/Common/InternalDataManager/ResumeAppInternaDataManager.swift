//
//  ResumeAppInternalDataManager
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/25/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import Foundation
import CoreData

class ResumeAppInternalDataManager {
    
    let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completion: (()->Void)? = nil) {
        persistentContainer.loadPersistentStores { storeDescription, error in
            guard error == nil else { fatalError(error!.localizedDescription) }
            completion?()
        }
    }
    
    func deleteDataFromStorage() {
        let fetchRequestPerson = NSFetchRequest<NSFetchRequestResult>(entityName: ResumeAppCommonConstants.InternalManagerIdentifiers.personEntity)
        let fetchRequestCompany = NSFetchRequest<NSFetchRequestResult>(entityName: ResumeAppCommonConstants.InternalManagerIdentifiers.companyEntity)
        let deleteRequestPerson = NSBatchDeleteRequest(fetchRequest: fetchRequestPerson)
        let deleteRequestCompany = NSBatchDeleteRequest(fetchRequest: fetchRequestCompany)
        
        do {
            try viewContext.execute(deleteRequestPerson)
            try viewContext.execute(deleteRequestCompany)
        } catch {
            print(error)
        }
    }
}
