//
//  ContactInformationInteractor.swift
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/23/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import Foundation

class ContactInformationInteractor: ContactInformationInteractorInputProtocol {
    
    var presenter: ContactInformationInteractorOutputProtocol?
    var internalDataManager: ContactInformationInternalDataManagerInputProtocol
    
    private var contactMeans: [ContactInformation]?
    private var owner: String?
    private var content: [ContactInformationStructs.ContactMean]?
    private var contactMeanValue: String?
    
    init(internalDataManager: ContactInformationInternalDataManagerInputProtocol) {
        self.internalDataManager = internalDataManager
        contactMeans = self.internalDataManager.getDataFromStorage()?.means
        owner = self.internalDataManager.getDataFromStorage()?.owner
        convertToDataNeeded()
    }
   
    private func convertToDataNeeded() {
        content = [ContactInformationStructs.ContactMean]()
        guard let means = contactMeans else {
            return
        }
        
        for mean in means {
            if let linkedIn = mean.linkedIn {
                content?.append(ContactInformationStructs.ContactMean(name: ContactInformationStructs.ContactMeans.linkedin.rawValue, value: linkedIn))
            }
            
            if let phone = mean.phone {
                content?.append(ContactInformationStructs.ContactMean(name: ContactInformationStructs.ContactMeans.phone.rawValue, value: phone))
            }
            
            if let mail = mean.mail {
                content?.append(ContactInformationStructs.ContactMean(name: ContactInformationStructs.ContactMeans.mail.rawValue, value: mail))
            }
        }
    }
    
    func dictateNumberOfItemsInSection() -> Int {
        return content?.count ?? 0
    }
    
    func dictateValuesForItem(with indexPath: IndexPath) -> ContactInformationStructs.ContactMean {
        let contactMean = content?[indexPath.row]
        return contactMean ?? ContactInformationStructs.ContactMean(name: ResumeAppCommonConstants.DefaultContents.notItem, value: ResumeAppCommonConstants.DefaultContents.notItem)
    }
    
    func defineActionForItemAt(with indexPath: IndexPath) {
        guard let content = content?[indexPath.row] else {
            return
        }
        
        if content.name == ContactInformationStructs.ContactMeans.mail.rawValue {
            contactMeanValue = content.value
            presenter?.askForCheckEmailAvailability()
        } else if content.name == ContactInformationStructs.ContactMeans.phone.rawValue {
            guard let url = URL(string: "\(ContactInformationConstants.OpenPhone.scheme)\(content.value)") else {
                return
            }
            presenter?.askToOpenDestination(with: url)
        } else {
            guard let url = URL(string: content.value) else {
                return
            }
            presenter?.askToOpenDestination(with: url)
        }
    }
    
    func resultAfterCheckEmailAvailability(isAvailable: Bool) {
        if isAvailable {
            guard let recipient = contactMeanValue, let name = owner else {
                return
            }
            
            let mail = ContactInformationStructs.Mail(recipients: [recipient], subject: ContactInformationConstants.Mail.subject, message: "\(ContactInformationConstants.Mail.message) \(name)")
            presenter?.askToShowMail(for: mail)
        } else {
            let alertInfo = ResumeAppCommonStructs.AlertMessage(title: ContactInformationConstants.MailNotConfigured.title, message: ContactInformationConstants.MailNotConfigured.message, button: ContactInformationConstants.ButtonTitle.title)
            presenter?.askToShowAlert(with: alertInfo)
        }
    }
    
    func resultAfterSendingMail(anErrorOccured: Bool, didFail: Bool) {
        if anErrorOccured || didFail {
            let alertInfo = ResumeAppCommonStructs.AlertMessage(title: ContactInformationConstants.FailedSendingMail.title, message: ContactInformationConstants.FailedSendingMail.message, button: ContactInformationConstants.ButtonTitle.title)
            presenter?.askToShowAlert(with: alertInfo)
        }
        presenter?.askToDismissView()
    }
}

extension ContactInformationInteractor: ContactInformationInternalDataManagerOutputProtocol {
    
}
