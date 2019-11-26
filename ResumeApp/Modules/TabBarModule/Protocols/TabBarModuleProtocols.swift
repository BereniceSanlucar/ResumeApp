//
//  TabBarModuleProtocols.swift
//  ResumeApp
//
//  Created by Berenice Sanlúcar on 11/23/19.
//  Copyright © 2019 Berenice Sanlúcar. All rights reserved.
//

import UIKit

//PRESENTER -> VIEW
protocol TabBarModuleViewProtocol: class {
    var presenter: TabBarModulePresenterProtocol? { get set }
}

//VIEW -> PRESENTER
protocol TabBarModulePresenterProtocol: class {
    var view: TabBarModuleViewProtocol? { get set }
    var interactor: TabBarModuleInteractorInputProtocol? { get set }
    var wireFrame: TabBarModuleWireFrameProtocol? { get set }
}

//PRESENTER -> INTERACTOR
protocol TabBarModuleInteractorInputProtocol: class {
    var presenter: TabBarModuleInteractorOutputProtocol? { get set }
}

//INTERACTOR -> PRESENTER
protocol TabBarModuleInteractorOutputProtocol: class {
    
}

//PRESENTER -> WIREFRAME
protocol TabBarModuleWireFrameProtocol: class {
    static func createTabBarModule(tabBarViewControllers: [UIViewController]) -> UIViewController
}
