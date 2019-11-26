//
//  WorkInformationViewController.swift
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/23/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import UIKit

class WorkInformationViewController: UIViewController {

    @IBOutlet weak var workInfoTableView: UITableView!
    
    var presenter: WorkInformationPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWorkInfoTableView()
    }
    
    private func configureWorkInfoTableView() {
        workInfoTableView.dataSource = self
        workInfoTableView.delegate = self
        workInfoTableView.register(UINib(nibName: ResumeAppCommonConstants.XibIdentifiers.workXib, bundle: nil), forCellReuseIdentifier: WorkTableViewCell.identifier)
    }
}

extension WorkInformationViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.determineNumberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.determineNumberOfRowsInSection(with: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter = presenter else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: presenter.determineCellForRowAt(), for: indexPath) as! WorkTableViewCell
        let job = presenter.determineValueForRow(with: indexPath)
        cell.setUICell(with: job)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter?.determineTitleForHeaderInSection(with: section)
    }
}

extension WorkInformationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return presenter?.determineHeightForRowAt(for: indexPath) ?? 0
    }
}

extension WorkInformationViewController: WorkInformationViewProtocol {
    
}
