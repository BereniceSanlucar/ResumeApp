//
//  ProgrammingLanguage.swift
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/25/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import Foundation
import CoreData

class ProgrammingLanguage: NSManagedObject, Decodable {
    @NSManaged var swift: NSNumber?
    @NSManaged var kotlin: NSNumber?
    
    private enum CodingKeys: String, CodingKey {
        case swift
        case kotlin
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProgrammingLanguage> {
        return NSFetchRequest<ProgrammingLanguage>(entityName: ResumeAppCommonConstants.InternalManagerIdentifiers.programmingLanguageEntity)
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard let contextKey = CodingUserInfoKey.context, let managedObjectContext = decoder.userInfo[contextKey] as? NSManagedObjectContext, let entity = NSEntityDescription.entity(forEntityName: ResumeAppCommonConstants.InternalManagerIdentifiers.programmingLanguageEntity, in: managedObjectContext) else {
            fatalError(ResumeAppCommonConstants.InternalManagerIdentifiers.programmingLanguageError)
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.swift = try container.decode(Bool.self, forKey: .swift) as NSNumber
        self.kotlin = try container.decode(Bool.self, forKey: .kotlin) as NSNumber
    }
}
