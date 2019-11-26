//
//  ResumeAppCommonConstants.swift
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/24/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import CoreGraphics

struct ResumeAppCommonConstants {
    
    struct URLComponents {
        static let scheme = "https"
        static let host = "api.myjson.com"
        static let path = "/bins/jhwba"
    }
    
    struct IPhoneScreenHeight {
        static let iPhone5S: CGFloat = 568
        static let iPhone6: CGFloat = 667
        static let iPhone7Plus: CGFloat = 736
        static let iPhoneX: CGFloat = 812
        static let iPhoneXR: CGFloat = 896
    }
    
    struct DefaultContents {
        static let notItem = "Unavailable"
    }
    
    struct StoryboardIdentifiers {
        static let tabBarModule = "TabBarModuleScreen"
        static let basicInfoModule = "BasicInformationScreen"
        static let workInfoModule = "WorkInformationScreen"
        static let contactInfoModule = "ContactInformationScreen"
        
    }
    
    struct XibIdentifiers {
        static let languagesXib = "LanguagesCollectionViewCell"
        static let professionalSummaryXib = "SummaryCollectionViewCell"
        static let collectionViewHeaderXib = "HeaderReusableView"
        static let workXib = "WorkTableViewCell"
        static let contactXib = "ContactCollectionViewCell"
    }
    
    struct ViewControllerIdentifiers {
        static let tabController = "TabBarModuleVC"
        static let basicInfoController = "BasicInformationVC"
        static let workInfoController = "WorkInformationVC"
        static let contactInfoController = "ContactInformationVC"
    }
    
    struct TabBarItems {
        static let basicInfoItem = "circle-user-7"
        static let workInfoItem = "business-bag-7"
        static let contactInfoItem = "email-7"
    }
    
    struct ModuleTitles {
        static let workInfoTitle = "Work Experience"
        static let contactInfoTitle = "Contact Information"
        static let basicInfoTitle = "Resume"
    }
    
    struct InternalManagerIdentifiers {
        static let resumeModel = "ResumeAppModel"
        static let keyContext = "context"
        static let personEntity = "Person"
        static let personError = "Failed to decode Person Entity"
        static let jobEntity = "Job"
        static let jobError = "Failed to decode Job Entity"
        static let companyEntity = "Company"
        static let companyError = "Failed to decode Company Entity"
        static let languageEntity = "Language"
        static let languageError = "Failed to decode Language Entity"
        static let programmingLanguageEntity = "ProgrammingLanguage"
        static let programmingLanguageError = "Failed to decode ProgrammingLanguage Entity"
        static let contactInformationEntity = "ContactInformation"
        static let contactInformationError = "Failed to decode ContactInformation Entity"
        static let retrievingError = "Unable to retrieve data from internal storage"
    }
    
    struct ExternalManagerIdentifiers {
        static let retrievingError = "Unable to retrieve data from the repository"
        static let parsingError = "Unable to parse data"
    }
}
