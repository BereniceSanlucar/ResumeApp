//
//  WorkInformationPresenter.swift
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/23/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import Foundation
import CoreGraphics

class WorkInformationPresenter: WorkInformationPresenterProtocol {
    
    weak var view: WorkInformationViewProtocol?
    var interactor: WorkInformationInteractorInputProtocol?
    var wireFrame: WorkInformationWireFrameProtocol?
    
    let height: CGFloat = 170
    
    func determineNumberOfSections() -> Int {
        return interactor?.dictateNumberOfSections() ?? 0
    }
    
    func determineNumberOfRowsInSection(with section: Int) -> Int {
        return interactor?.dictateNumberOfRowsInSection(with: section) ?? 0
    }
    
    func determineCellForRowAt() -> String {
        return WorkTableViewCell.identifier
    }
    
    func determineValueForRow(with indexPath: IndexPath) -> WorkInformationStructs.Job {
        return interactor?.dictateValueForRow(with: indexPath) ?? WorkInformationStructs.Job(role: ResumeAppCommonConstants.DefaultContents.notItem, duration: ResumeAppCommonConstants.DefaultContents.notItem, summary: ResumeAppCommonConstants.DefaultContents.notItem, companyLogo: Data())
    }
    
    func determineTitleForHeaderInSection(with section: Int) -> String? {
        return interactor?.dictateTitleForHeaderInSection(with: section)
    }
    
    func determineHeightForRowAt(for indexPath: IndexPath) -> CGFloat {
        return height
    }
}

extension WorkInformationPresenter: WorkInformationInteractorOutputProtocol {
    
}
