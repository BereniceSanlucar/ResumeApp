//
//  BasicInformationInteractor.swift
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/23/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import Foundation

class BasicInformationInteractor: BasicInformationInteractorInputProtocol {
    
    weak var presenter: BasicInformationInteractorOutputProtocol?
    var internalDataManager: BasicInformationInternalDataManagerInputProtocol
    
    private var person: Person?
    private var content: [[Any]]?
    
    init(internalDataManager: BasicInformationInternalDataManagerInputProtocol) {
        self.internalDataManager = internalDataManager
        person = self.internalDataManager.getDataFromStorage()
        convertToDataNeeded()
    }
    
    private func convertToDataNeeded() {
        content = [[Any]]()
        convertToSummary()
        convertToLanguages()
        convertToProgrammingLanguages()
    }
    
    private func convertToSummary() {
        guard let person = person, let name = person.name, let summary = person.professionalsummary, let photo = person.photo, let data = convertToData(item: photo) else {
            return
        }
        
        let summaryInfo = BasicInformationStructs.Summary(name: name, photo: data, professionalSummary: summary)
        content?.append([summaryInfo])
    }
    
    private func convertToLanguages() {
        guard let person = person, let languages = person.languages else {
            return
        }
        
        var languagesInfo = [String]()
        
        for language in languages {
            if let language = language as? Language, let english = language.english, let french = language.french, let spanish = language.spanish {
                if english == true {
                    languagesInfo.append(BasicInformationConstants.ImageNames.english)
                }
                
                if french == true {
                    languagesInfo.append(BasicInformationConstants.ImageNames.french)
                }
                
                if spanish == true {
                    languagesInfo.append(BasicInformationConstants.ImageNames.spanish)
                }
            }
        }
        
        content?.append(languagesInfo)
    }
    
    private func convertToProgrammingLanguages() {
        guard let person = person, let languages = person.programmingLanguages else {
            return
        }
        
        var languagesInfo = [String]()
        
        for language in languages {
            if let language = language as? ProgrammingLanguage, let kotlin = language.kotlin, let swift = language.swift {
                if kotlin == true {
                    languagesInfo.append(BasicInformationConstants.ImageNames.kotlin)
                }
                
                if swift == true {
                    languagesInfo.append(BasicInformationConstants.ImageNames.swift)
                }
            }
        }
        
        content?.append(languagesInfo)
    }
    
    private func convertToData(item: String) -> Data? {
        guard let url = URL(string: item) else {
            return nil
        }
        return try? Data(contentsOf: url)
    }
    
    func getTitleForNavigationBar() -> String? {
        return person?.name
    }
    
    func dictateNumberOfSections() -> Int {
        return content?.count ?? 0
    }
    
    func dictateNumberOfItemsInSection(with section: Int) -> Int {
        return content?[section].count ?? 0
    }
    
    func dictateValuesForProfessionalInfo() -> BasicInformationStructs.Summary {
        let summary = content?[0][0] as? BasicInformationStructs.Summary
        return summary ?? BasicInformationStructs.Summary(name: ResumeAppCommonConstants.DefaultContents.notItem, photo: Data(), professionalSummary: BasicInformationConstants.DefaultContents.notSummary)
    }
    
    func dictateValueForItem(with indexPath: IndexPath) -> String {
        return content?[indexPath.section][indexPath.row] as? String ?? ResumeAppCommonConstants.DefaultContents.notItem
    }
}

extension BasicInformationInteractor: BasicInformationInternalDataManagerOutputProtocol {
    
}
