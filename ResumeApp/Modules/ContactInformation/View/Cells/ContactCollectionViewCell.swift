//
//  ContactCollectionViewCell.swift
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/24/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import UIKit

class ContactCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var contactLogoImageView: UIImageView!
    @IBOutlet weak var contactLabel: UILabel!
    
    static let identifier = "ContactCVC"
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contactLogoImageView.setupView()
    }
    
    func setUICell(with info: ContactInformationStructs.ContactMean) {
        if info.name == ContactInformationStructs.ContactMeans.phone.rawValue {
            contactLogoImageView.layer.borderWidth = 1.5
        }
        contactLogoImageView.image = UIImage(named: info.name)
        contactLabel.text = info.value
    }
}
