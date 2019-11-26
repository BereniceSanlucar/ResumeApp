//
//  ContactInformationStructs.swift
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/24/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import Foundation

struct ContactInformationStructs {
    
    struct Mail {
        let recipients: [String]
        let subject: String
        let message: String
    }
    
    struct ContactMean {
        let name: String
        let value: String
    }
    
    enum ContactMeans: String {
        case mail
        case linkedin = "linkedIn"
        case phone
    }
}
