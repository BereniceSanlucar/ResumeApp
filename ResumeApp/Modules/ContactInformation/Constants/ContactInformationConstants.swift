//
//  ContactInformationConstants.swift
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/25/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import Foundation

struct ContactInformationConstants {
    
    struct Mail {
        static let subject = "Job Offer"
        static let message = "Hi"
    }
    
    struct ButtonTitle {
        static let title = "Accept"
    }
    
    struct MailNotConfigured {
        static let title = "Not Mail Services Available"
        static let message = "Not Mail Services configured in this device"
    }
    
    struct FailedSendingMail {
        static let title = "Error in sending mail"
        static let message = "Impossible to send mail message"
    }
    
    struct OpenPhone {
        static let scheme = "tel://"
    }
}
