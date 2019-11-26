//
//  BasicInformationConstants.swift
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/23/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import CoreGraphics

struct BasicInformationConstants {
    
    struct DefaultContents {
        static let notSummary = "Not professional summary available"
    }
    
    struct ImageNames {
        static let kotlin = "kotlin"
        static let swift = "swift"
        static let english = "english"
        static let french = "french"
        static let spanish = "spanish"
    }
    
    struct Sizes {
        static let numberOfItemsPerRow: CGFloat = 3
        static let spaceBetweenCells: CGFloat = 8
        static let numberOfSpaces: CGFloat = 4
        static let spaceForSectionFirst: CGFloat = 0
        static let heightForHeader: CGFloat = 20
    }
    
    struct CVCellHeight {
        static let forIPhone5S: CGFloat = 121
        static let forIPhone6: CGFloat = 144
        static let forIPhone7Plus: CGFloat = 170
        static let forIPhoneX: CGFloat = 178
        static let forIPhoneXR: CGFloat = 197
    }
    
    enum TitleForBasicInformation: Int {
        case summmary
        case languages
        case programmingLanguages
        
        var title: String {
            switch self {
            case .summmary:
                return "Professional Summary"
            case .languages:
                return "Speaking Languages"
            case .programmingLanguages:
                return "Programming Languages"
            }
        }
    }
    
}
