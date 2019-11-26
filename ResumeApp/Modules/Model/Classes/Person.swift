//
//  Person.swift
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/25/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import CoreData

class Person: NSManagedObject, Decodable {
    @NSManaged var name: String?
    @NSManaged var professionalsummary: String?
    @NSManaged var photo: String?
    @NSManaged var languages: NSSet?
    @NSManaged var programmingLanguages: NSSet?
    @NSManaged var jobs: NSSet?
    @NSManaged var contactMeans: NSSet?
    
    
    private enum CodingKeys: String, CodingKey {
        case name
        case professionalsummary = "summary"
        case photo
        case languages
        case programmingLanguages
        case jobs
        case contactMeans = "contactInformation"
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: ResumeAppCommonConstants.InternalManagerIdentifiers.personEntity)
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard let contextKey = CodingUserInfoKey.context, let managedObjectContext = decoder.userInfo[contextKey] as? NSManagedObjectContext, let entity = NSEntityDescription.entity(forEntityName: ResumeAppCommonConstants.InternalManagerIdentifiers.personEntity, in: managedObjectContext) else {
            fatalError(ResumeAppCommonConstants.InternalManagerIdentifiers.personError)
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.professionalsummary = try container.decode(String.self, forKey: .professionalsummary)
        self.photo = try container.decode(String.self, forKey: .photo)
        self.languages = NSSet(object: try container.decode(Language.self, forKey: .languages))
        self.programmingLanguages = NSSet(object: try container.decode(ProgrammingLanguage.self, forKey: .programmingLanguages))
        self.jobs = NSSet(array: try container.decode([Job].self, forKey: .jobs))
        self.contactMeans = NSSet(object: try container.decode(ContactInformation.self, forKey: .contactMeans))
    }
}

extension Person {
    
    @objc(addContactMeansObject:)
    @NSManaged public func addToContactMeans(_ value: ContactInformation)
    
    @objc(removeContactMeansObject:)
    @NSManaged public func removeFromContactMeans(_ value: ContactInformation)
    
    @objc(addContactMeans:)
    @NSManaged public func addToContactMeans(_ values: NSSet)
    
    @objc(removeContactMeans:)
    @NSManaged public func removeFromContactMeans(_ values: NSSet)
    
}

extension Person {
    
    @objc(addJobsObject:)
    @NSManaged public func addToJobs(_ value: Job)
    
    @objc(removeJobsObject:)
    @NSManaged public func removeFromJobs(_ value: Job)
    
    @objc(addJobs:)
    @NSManaged public func addToJobs(_ values: NSSet)
    
    @objc(removeJobs:)
    @NSManaged public func removeFromJobs(_ values: NSSet)
    
}

extension Person {
    
    @objc(addLanguagesObject:)
    @NSManaged public func addToLanguages(_ value: Language)
    
    @objc(removeLanguagesObject:)
    @NSManaged public func removeFromLanguages(_ value: Language)
    
    @objc(addLanguages:)
    @NSManaged public func addToLanguages(_ values: NSSet)
    
    @objc(removeLanguages:)
    @NSManaged public func removeFromLanguages(_ values: NSSet)
    
}

extension Person {
    
    @objc(addProgrammingLanguagesObject:)
    @NSManaged public func addToProgrammingLanguages(_ value: ProgrammingLanguage)
    
    @objc(removeProgrammingLanguagesObject:)
    @NSManaged public func removeFromProgrammingLanguages(_ value: ProgrammingLanguage)
    
    @objc(addProgrammingLanguages:)
    @NSManaged public func addToProgrammingLanguages(_ values: NSSet)
    
    @objc(removeProgrammingLanguages:)
    @NSManaged public func removeFromProgrammingLanguages(_ values: NSSet)
}
