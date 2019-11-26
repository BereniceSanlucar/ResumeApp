//
//  LanguagesCollectionViewCell.swift
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/23/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import UIKit

class LanguagesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    static let identifier = "LanguagesCVC"
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.setupView()
    }
    
    func setUICell(with asset: String) {
        imageView.image = UIImage(named: asset)
    }
}
