//
//  WorkTableViewCell.swift
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/24/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import UIKit

class WorkTableViewCell: UITableViewCell {
        
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    static let identifier = "WorkTVC"

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        logoImageView.setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setUICell(with job: WorkInformationStructs.Job) {
        logoImageView.image = UIImage(data: job.companyLogo)
        roleLabel.text = job.role
        dateLabel.text = job.duration
        summaryLabel.text = job.summary
    }
}

