//
//  Language.swift
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/25/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import Foundation
import CoreData

class Language: NSManagedObject, Decodable {
    @NSManaged var spanish: NSNumber?
    @NSManaged var french: NSNumber?
    @NSManaged var english: NSNumber?
    
    private enum CodingKeys: String, CodingKey {
        case spanish
        case french
        case english
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Language> {
        return NSFetchRequest<Language>(entityName: ResumeAppCommonConstants.InternalManagerIdentifiers.languageEntity)
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard let contextKey = CodingUserInfoKey.context, let managedObjectContext = decoder.userInfo[contextKey] as? NSManagedObjectContext, let entity = NSEntityDescription.entity(forEntityName: ResumeAppCommonConstants.InternalManagerIdentifiers.languageEntity, in: managedObjectContext) else {
            fatalError(ResumeAppCommonConstants.InternalManagerIdentifiers.languageError)
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.spanish = try container.decode(Bool.self, forKey: .spanish) as NSNumber
        self.french = try container.decode(Bool.self, forKey: .french) as NSNumber
        self.english = try container.decode(Bool.self, forKey: .english) as NSNumber
    }
}
