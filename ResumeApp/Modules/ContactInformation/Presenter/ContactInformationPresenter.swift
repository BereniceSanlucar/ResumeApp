//
//  ContactInformationPresenter.swift
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/23/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import Foundation
import CoreGraphics

class ContactInformationPresenter: ContactInformationPresenterProtocol {
    
    var view: ContactInformationViewProtocol?
    var interactor: ContactInformationInteractorInputProtocol?
    var wireFrame: ContactInformationWireFrameProtocol?
    
    private let spaceBetweenCells: CGFloat = 0
    private let extraSpace: CGFloat = 30
    private var controller: ContactInformationViewController?
    
    func determineNumberOfItemsInSection() -> Int {
        return interactor?.dictateNumberOfItemsInSection() ?? 0
    }
    
    func determineCellForItemAt() -> String {
        return ContactCollectionViewCell.identifier
    }
    
    func determineValuesForItem(with indexPath: IndexPath) -> ContactInformationStructs.ContactMean {
        return interactor?.dictateValuesForItem(with: indexPath) ?? ContactInformationStructs.ContactMean(name: ResumeAppCommonConstants.DefaultContents.notItem, value: ResumeAppCommonConstants.DefaultContents.notItem)
    }
    
    func manageDidSelectItemAt(for indexPath: IndexPath) {
        interactor?.defineActionForItemAt(with: indexPath)
    }
    
    func determineSizeForItemAt(with width: CGFloat) -> CGSize {
        let size = width/2
        return CGSize(width: size, height: size + extraSpace)
    }
    
    func determineInsetForSectionAt() -> (top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        return (top: spaceBetweenCells, left: spaceBetweenCells, bottom: 0, right: spaceBetweenCells)
    }
    
    func determineMinimumLineSpacingForSectionAt() -> CGFloat {
        return spaceBetweenCells
    }
    
    func determineMinimumInteritemSpacingForSectionAt() -> CGFloat {
        return spaceBetweenCells
    }
    
    func resultForEmailAvalability(isAvailable: Bool, from controller: ContactInformationViewController) {
        self.controller = controller
        interactor?.resultAfterCheckEmailAvailability(isAvailable: isAvailable)
    }
    
    func resultFromSendingMail(anErrorOccured: Bool, didFail: Bool) {
        interactor?.resultAfterSendingMail(anErrorOccured: anErrorOccured, didFail: didFail)
    }
}

extension ContactInformationPresenter: ContactInformationInteractorOutputProtocol {

    func askForCheckEmailAvailability() {
        view?.checkEmailAvailability()
    }
    
    func askToShowMail(for mail: ContactInformationStructs.Mail) {
        guard let controller = self.controller else {
            return
        }
        wireFrame?.showMailComposerVC(from: controller, for: mail)
    }
    
    func askToShowAlert(with content: ResumeAppCommonStructs.AlertMessage) {
        guard let controller = self.controller else {
            return
        }
        wireFrame?.showAlertMessage(with: content, from: controller)
    }
    
    func askToDismissView() {
        guard let controller = self.controller else {
            return
        }
        wireFrame?.dismissController(controller: controller)
    }
    
    func askToOpenDestination(with URL: URL) {
        wireFrame?.openDestination(with: URL)
    }
}
