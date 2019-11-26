//
//  Company.swift
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/25/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import Foundation
import CoreData

class Company: NSManagedObject, Decodable {
    @NSManaged var name: String?
    @NSManaged var logo: String?
    
    private enum CodingKeys: String, CodingKey {
        case name
        case logo
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: ResumeAppCommonConstants.InternalManagerIdentifiers.companyEntity)
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard let contextKey = CodingUserInfoKey.context, let managedObjectContext = decoder.userInfo[contextKey] as? NSManagedObjectContext, let entity = NSEntityDescription.entity(forEntityName: ResumeAppCommonConstants.InternalManagerIdentifiers.companyEntity, in: managedObjectContext) else {
            fatalError(ResumeAppCommonConstants.InternalManagerIdentifiers.companyError)
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.logo = try container.decode(String.self, forKey: .logo)
    }
}

extension Company {
    
    @objc(addJobsObject:)
    @NSManaged public func addToJobs(_ value: Job)
    
    @objc(removeJobsObject:)
    @NSManaged public func removeFromJobs(_ value: Job)
    
    @objc(addJobs:)
    @NSManaged public func addToJobs(_ values: NSSet)
    
    @objc(removeJobs:)
    @NSManaged public func removeFromJobs(_ values: NSSet)
    
}
