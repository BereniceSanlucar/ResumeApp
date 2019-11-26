//
//  BasicInformationPresenter.swift
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/23/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import Foundation
import CoreGraphics

class BasicInformationPresenter: BasicInformationPresenterProtocol {
    
    weak var view: BasicInformationViewProtocol?
    var interactor: BasicInformationInteractorInputProtocol?
    var wireFrame: BasicInformationWireFrameProtocol?
    
    func determineNumberOfSections() -> Int {
        return interactor?.dictateNumberOfSections() ?? 0
    }
    
    func determineNumberOfItemsInSection(with section: Int) -> Int {
        return interactor?.dictateNumberOfItemsInSection(with: section) ?? 0
    }
    
    func determineCellForItemAt(with indexPath: IndexPath) -> String {
        if indexPath.section == 0 {
            return SummaryCollectionViewCell.identifier
        } else {
            return LanguagesCollectionViewCell.identifier
        }
    }
    
    func determineValuesForProfessionalInfo() -> BasicInformationStructs.Summary {
        return interactor?.dictateValuesForProfessionalInfo() ?? BasicInformationStructs.Summary(name: ResumeAppCommonConstants.DefaultContents.notItem, photo: Data(), professionalSummary: BasicInformationConstants.DefaultContents.notSummary)
    }
    
    func determineValueForItem(with indexPath: IndexPath) -> String {
        return interactor?.dictateValueForItem(with: indexPath) ?? ResumeAppCommonConstants.DefaultContents.notItem
    }
    
    func determineHeaderInSection() -> String {
        return HeaderCollectionReusableView.identifier
    }
    
    func determineTitleForHeaderInSection(with indexPath: IndexPath) -> String? {
        let titleCase = BasicInformationConstants.TitleForBasicInformation.init(rawValue: indexPath.section)
        return titleCase?.title
    }
    
    func determineSizeForItemAt(for indexPath: IndexPath, with sizes: (width: CGFloat, height: CGFloat)) -> CGSize {
        var height: CGFloat
        var width = sizes.width
        
        switch sizes.height {
        case ResumeAppCommonConstants.IPhoneScreenHeight.iPhone5S:
            height = BasicInformationConstants.CVCellHeight.forIPhone5S
        case ResumeAppCommonConstants.IPhoneScreenHeight.iPhone7Plus:
            height = BasicInformationConstants.CVCellHeight.forIPhone7Plus
        case ResumeAppCommonConstants.IPhoneScreenHeight.iPhoneX:
            height = BasicInformationConstants.CVCellHeight.forIPhoneX
        case ResumeAppCommonConstants.IPhoneScreenHeight.iPhoneXR:
            height =  BasicInformationConstants.CVCellHeight.forIPhoneXR
        default:
            height = BasicInformationConstants.CVCellHeight.forIPhone6
        }
        
        if indexPath.section != 0 {
            width = (sizes.width-BasicInformationConstants.Sizes.spaceBetweenCells*BasicInformationConstants.Sizes.numberOfSpaces)/BasicInformationConstants.Sizes.numberOfItemsPerRow
        }
        
        return CGSize(width: width, height: height)
    }
    
    func determineSizeForHeaderInSection(with width: CGFloat) -> CGSize {
        return CGSize(width: width, height: BasicInformationConstants.Sizes.heightForHeader)
    }
    
    func determineInsetForSectionAt(with section: Int) -> (top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        if section == 0 {
            let space = BasicInformationConstants.Sizes.spaceForSectionFirst
            return (top: space, left: space, bottom: space, right: space)
        } else {
            let space = BasicInformationConstants.Sizes.spaceBetweenCells
            return (top: space, left: space, bottom: space, right: space)
        }
    }
    
    func determineMinimumLineSpacingForSectionAt(with section: Int) -> CGFloat {
        if section == 0 {
            return BasicInformationConstants.Sizes.spaceForSectionFirst
        } else {
            return BasicInformationConstants.Sizes.spaceBetweenCells
        }
    }
    
    func determineMinimumInteritemSpacingForSectionAt(with section: Int) -> CGFloat {
        if section == 0 {
            return BasicInformationConstants.Sizes.spaceForSectionFirst
        } else {
            return BasicInformationConstants.Sizes.spaceBetweenCells
        }
    }
}

extension BasicInformationPresenter: BasicInformationInteractorOutputProtocol {
    
}
