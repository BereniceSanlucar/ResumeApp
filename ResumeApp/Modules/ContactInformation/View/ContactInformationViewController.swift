//
//  ContactInformationViewController.swift
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/23/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import UIKit
import MessageUI

class ContactInformationViewController: UIViewController {

    @IBOutlet weak var contactInfoCollectionView: UICollectionView!
    
    var presenter: ContactInformationPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContactInfoCollectionView()
    }
    
    private func configureContactInfoCollectionView() {
        contactInfoCollectionView.dataSource = self
        contactInfoCollectionView.delegate = self
        contactInfoCollectionView.register(UINib(nibName: ResumeAppCommonConstants.XibIdentifiers.contactXib, bundle: nil), forCellWithReuseIdentifier: ContactCollectionViewCell.identifier)
    }
}

extension ContactInformationViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.determineNumberOfItemsInSection() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let presenter = presenter else {
            return UICollectionViewCell()
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: presenter.determineCellForItemAt(), for: indexPath) as! ContactCollectionViewCell
        let contactMean = presenter.determineValuesForItem(with: indexPath)
        cell.setUICell(with: contactMean)
        return cell
    }
}

extension ContactInformationViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.manageDidSelectItemAt(for: indexPath)
    }
}

extension ContactInformationViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return presenter?.determineSizeForItemAt(with: collectionView.frame.width) ?? CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        guard let presenter = presenter else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        let insets = presenter.determineInsetForSectionAt()
        return UIEdgeInsets(top: insets.top, left: insets.left, bottom: insets.bottom, right: insets.right)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return presenter?.determineMinimumLineSpacingForSectionAt() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return presenter?.determineMinimumInteritemSpacingForSectionAt() ?? 0
    }
}

extension ContactInformationViewController: ContactInformationViewProtocol {
    
    func checkEmailAvailability() {
        let availability = MFMailComposeViewController.canSendMail()
        presenter?.resultForEmailAvalability(isAvailable: availability, from: self)
    }
    
}

extension ContactInformationViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        let isThereAnError = error == nil ? false : true
        let didFail = result == .failed ? true : false
        presenter?.resultFromSendingMail(anErrorOccured: isThereAnError, didFail: didFail)
    }
    
}
