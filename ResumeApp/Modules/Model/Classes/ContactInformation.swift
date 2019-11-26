//
//  ContactInformation.swift
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/24/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import Foundation
import CoreData

class ContactInformation: NSManagedObject, Decodable {
    @NSManaged var linkedIn: String?
    @NSManaged var phone: String?
    @NSManaged var mail: String?
    
    private enum CodingKeys: String, CodingKey {
        case linkedIn
        case phone
        case mail
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ContactInformation> {
        return NSFetchRequest<ContactInformation>(entityName: ResumeAppCommonConstants.InternalManagerIdentifiers.contactInformationEntity)
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard let contextKey = CodingUserInfoKey.context, let managedObjectContext = decoder.userInfo[contextKey] as? NSManagedObjectContext, let entity = NSEntityDescription.entity(forEntityName: ResumeAppCommonConstants.InternalManagerIdentifiers.contactInformationEntity, in: managedObjectContext) else {
            fatalError(ResumeAppCommonConstants.InternalManagerIdentifiers.contactInformationError)
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.linkedIn = try container.decode(String.self, forKey: .linkedIn)
        self.phone = try container.decode(String.self, forKey: .phone)
        self.mail = try container.decode(String.self, forKey: .mail)
    }
}
