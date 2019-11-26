//
//  WorkInformationInteractor.swift
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/23/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import Foundation

class WorkInformationInteractor: WorkInformationInteractorInputProtocol {
    
    weak var presenter: WorkInformationInteractorOutputProtocol?
    var internalDataManager: WorkInformationInternalDataManagerInputProtocol
    
    private var jobs: [Job]?
    private var content: [[WorkInformationStructs.Job]]?
    private var companies: [Int: String]?
    
    init(internalDataManager: WorkInformationInternalDataManagerInputProtocol) {
        self.internalDataManager = internalDataManager
        jobs = self.internalDataManager.getDataFromStorage()
        convertToDataNeeded()
    }
    
    private func convertToDataNeeded() {
        content = [[WorkInformationStructs.Job]]()
        getCompanies()
        getJobs()
    }
    
    private func getCompanies() {
        guard let jobs = jobs else {
            return
        }
        
        companies = [Int: String]()
        var index = 0
        for job in jobs {
            if let company = job.company?.name {
                if let _ = companies?[index] {
                    companies?[index + 1] = company
                } else {
                    companies?[index] = company
                }
                index += 1
            }
        }
        
        for i in 0..<index {
            if let _ = companies?[i] {
                content?.append([WorkInformationStructs.Job]())
            }
        }
    }
    
    private func getJobs() {
        guard let jobs = jobs, let count = content?.count else {
            return
        }
        
        for i in 0..<count {
            for job in jobs {
                if let company = job.company?.name, let companies = companies, let role = job.role, let duration = job.duration, let summary = job.summary, let companyLogo = job.company?.logo, let logo = convertToData(item: companyLogo) {
                    if companies[i] == company {
                        content?[i].append(WorkInformationStructs.Job(role: role, duration: duration, summary: summary, companyLogo: logo))
                    }
                }
            }
        }
    }
    
    private func convertToData(item: String) -> Data? {
        guard let url = URL(string: item) else {
            return nil
        }
        return try? Data(contentsOf: url)
    }
    
    func dictateNumberOfSections() -> Int {
        return content?.count ?? 0
    }
    
    func dictateNumberOfRowsInSection(with section: Int) -> Int {
        return content?[section].count ?? 0
    }
    
    func dictateTitleForHeaderInSection(with section: Int) -> String? {
        return companies?[section]
    }
    
    func dictateValueForRow(with indexPath: IndexPath) -> WorkInformationStructs.Job {
        
        let job = content?[indexPath.section][indexPath.row]
        return job ?? WorkInformationStructs.Job(role: ResumeAppCommonConstants.DefaultContents.notItem, duration: ResumeAppCommonConstants.DefaultContents.notItem, summary: ResumeAppCommonConstants.DefaultContents.notItem, companyLogo: Data())
    }
}

extension WorkInformationInteractor: WorkInformationInternalDataManagerOutputProtocol {
    
}
