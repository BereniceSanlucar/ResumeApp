//
//  CircleUIImageView.swift
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/24/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setupView() {
        self.layoutIfNeeded()
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFit
    }
    
}

