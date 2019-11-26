//
//  TabBarModulePresenter.swift
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/23/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import Foundation

class TabBarModulePresenter: TabBarModulePresenterProtocol {
    
    var view: TabBarModuleViewProtocol?
    var interactor: TabBarModuleInteractorInputProtocol?
    var wireFrame: TabBarModuleWireFrameProtocol?
    
}

extension TabBarModulePresenter: TabBarModuleInteractorOutputProtocol {
    
}
