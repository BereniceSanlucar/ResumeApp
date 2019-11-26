//
//  SummaryCollectionViewCell.swift
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/23/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import UIKit

class SummaryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var summaryLabel: UILabel!
    
    static let identifier = "SummaryCVC"
    
    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.setupView()
        summaryLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setUICell(with info: BasicInformationStructs.Summary) {
        photoImageView.image = UIImage(data: info.photo)
        photoImageView.layer.borderWidth = 1.5
        summaryLabel.text = info.professionalSummary
    }
}
