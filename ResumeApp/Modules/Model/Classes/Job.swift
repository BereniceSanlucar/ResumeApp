//
//  Job.swift
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/25/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import Foundation
import CoreData

class Job: NSManagedObject, Decodable {
    @NSManaged var company: Company?
    @NSManaged var role: String?
    @NSManaged var duration: String?
    @NSManaged var summary: String?
    
    private enum CodingKeys: String, CodingKey {
        case company
        case role
        case duration
        case summary
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Job> {
        return NSFetchRequest<Job>(entityName: ResumeAppCommonConstants.InternalManagerIdentifiers.jobEntity)
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard let contextKey = CodingUserInfoKey.context, let managedObjectContext = decoder.userInfo[contextKey] as? NSManagedObjectContext, let entity = NSEntityDescription.entity(forEntityName: ResumeAppCommonConstants.InternalManagerIdentifiers.jobEntity, in: managedObjectContext) else {
            fatalError(ResumeAppCommonConstants.InternalManagerIdentifiers.jobError)
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.company = try container.decode(Company.self, forKey: .company)
        self.role = try container.decode(String.self, forKey: .role)
        self.duration = try container.decode(String.self, forKey: .duration)
        self.summary = try container.decode(String.self, forKey: .summary)
    }
}
