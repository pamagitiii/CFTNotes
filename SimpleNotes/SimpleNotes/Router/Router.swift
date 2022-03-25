//
//  Router.swift
//  SimpleNotes
//
//  Created by Anatoliy on 25.03.2022.
//

import UIKit

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var moduleBuilder: ModuleBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showEdit(note: Note)
    func popToRoot()
}

class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var moduleBuilder: ModuleBuilderProtocol?
    
    init(navigationController: UINavigationController, moduleBuilder: ModuleBuilderProtocol) {
        self.navigationController = navigationController
        self.moduleBuilder = moduleBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let listViewController = moduleBuilder?.createListModule(router: self) else { return }
            navigationController.viewControllers = [listViewController]
        }
    }
    
    func showEdit(note: Note) {
        if let navigationController = navigationController {
            guard let editViewController = moduleBuilder?.createEditModule(router: self, note: note) else { return }
            navigationController.pushViewController(editViewController, animated: true)
        }
    }
    
    func popToRoot() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
