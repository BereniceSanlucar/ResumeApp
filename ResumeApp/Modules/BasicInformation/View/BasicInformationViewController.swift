//
//  BasicInformationViewController.swift
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/23/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import UIKit

class BasicInformationViewController: UIViewController {
    
    @IBOutlet weak var basicInfoCollectionView: UICollectionView!
    
    var presenter: BasicInformationPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBasicInfoCollectionView()
    }
    
    private func configureBasicInfoCollectionView() {
        basicInfoCollectionView.dataSource = self
        basicInfoCollectionView.delegate = self
        basicInfoCollectionView.register(UINib(nibName: ResumeAppCommonConstants.XibIdentifiers.collectionViewHeaderXib, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier)
        basicInfoCollectionView.register(UINib(nibName: ResumeAppCommonConstants.XibIdentifiers.professionalSummaryXib, bundle: nil), forCellWithReuseIdentifier: SummaryCollectionViewCell.identifier)
        basicInfoCollectionView.register(UINib(nibName: ResumeAppCommonConstants.XibIdentifiers.languagesXib, bundle: nil), forCellWithReuseIdentifier: LanguagesCollectionViewCell.identifier)
    }
    
}

extension BasicInformationViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter?.determineNumberOfSections() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.determineNumberOfItemsInSection(with: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let presenter = presenter else {
            return UICollectionViewCell()
        }
        let identifier = presenter.determineCellForItemAt(with: indexPath)
        if let professionalInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? SummaryCollectionViewCell {
            let professionalInfo = presenter.determineValuesForProfessionalInfo()
            professionalInfoCell.setUICell(with: professionalInfo)
            return professionalInfoCell
        } else if let languageCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? LanguagesCollectionViewCell {
            languageCell.setUICell(with: presenter.determineValueForItem(with: indexPath))
            return languageCell
        }
        return UICollectionViewCell()
    }
    
}

extension BasicInformationViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let presenter = presenter else {
            return UICollectionReusableView()
        }
        let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: presenter.determineHeaderInSection(), for: indexPath)
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = reusableView as! HeaderCollectionReusableView
            headerView.titleLabel.text = presenter.determineTitleForHeaderInSection(with: indexPath)
            return headerView
        default:
            return UICollectionReusableView()
        }
    }

}

extension BasicInformationViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return presenter?.determineSizeForItemAt(for: indexPath, with: (width: collectionView.frame.width, height: UIScreen.main.bounds.height)) ?? CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return presenter?.determineSizeForHeaderInSection(with: collectionView.frame.width) ?? CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        guard let presenter = presenter else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        let insets = presenter.determineInsetForSectionAt(with: section)
        return UIEdgeInsets(top: insets.top, left: insets.left, bottom: insets.bottom, right: insets.right)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return presenter?.determineMinimumLineSpacingForSectionAt(with: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return presenter?.determineMinimumInteritemSpacingForSectionAt(with: section) ?? 0
    }
}

extension BasicInformationViewController: BasicInformationViewProtocol {
    
}
